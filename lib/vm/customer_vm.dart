import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/vm/repositories/customer_repo.dart';
import 'package:db_billmate/vm/repositories/transaction_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tempCustomerProvider = StateProvider<CustomerModel>((ref) => CustomerModel());

class CustomerVM extends AsyncNotifier<List<CustomerModel>> {
  @override
  Future<List<CustomerModel>> build() async {
    return await get(noLoad: true);
  }

  Future<List<CustomerModel>> get({bool noLoad = false, int? id, Map<String, dynamic>? where, String? orderBy, bool? isDouble, bool ascending = false, Map<String, dynamic>? search, int? pageIndex, bool noWait = false}) async {
    try {
      if (!noLoad) state = AsyncValue.loading();
      List<CustomerModel> customers = state.value ?? [];

      if (id != null) {
        final customer = (await CustomerRepo.fetchCustomers(where: {"id": id})).first;
        customers.removeWhere((c) => c.id == customer.id);
        customers = [customer, ...customers];
      } else {
        customers = await CustomerRepo.fetchCustomers(where: where, orderBy: orderBy ?? "modified", isDouble: isDouble, ascending: ascending, search: search);
      }
      if (!noWait) await Future.delayed(Duration(seconds: 2));
      state = AsyncValue.data(customers);
      return customers;
    } catch (e, stackTrace) {
      state = AsyncValue.data([]);
      qp('Error: $e\nStackTrace: $stackTrace');
      return [];
    }
  }

  Future<CustomerModel> singleGet(int id) async {
    try {
      List<CustomerModel> customers = state.value ?? [];
      final customer = (await CustomerRepo.fetchCustomers(where: {"id": id})).first;
      customers.removeWhere((c) => c.id == customer.id);
      customers = [customer, ...customers];
      state = AsyncValue.data(customers);
      return customer;
    } catch (e) {
      return CustomerModel();
    }
  }

  Future<bool> save(CustomerModel model, {TransactionModel transactionModel = const TransactionModel()}) async {
    state = AsyncValue.loading();
    List<dynamic> results = await Future.wait([CustomerRepo.addCustomer(model), if (transactionModel != TransactionModel()) TransactionRepo.save(transactionModel.copyWith(customerId: model.id ?? (state.value?.length ?? 0) + 1))]);
    final res = results[0];
    if (res != 0) {
      await singleGet(res);
      if (model.id != null) {
        final tempCustomer = ref.read(tempCustomerProvider.notifier);
        tempCustomer.state = state.value?.where((e) => e.id == tempCustomer.state.id).first ?? CustomerModel();
      }
    }
    return res != 0;
  }
}

final customerVMProvider = AsyncNotifierProvider<CustomerVM, List<CustomerModel>>(CustomerVM.new);
