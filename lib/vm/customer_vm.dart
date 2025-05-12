import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/vm/dashboard_vm.dart';
import 'package:db_billmate/vm/repositories/customer_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final customerQuickTransaction = StateProvider<bool>((ref) => false);
final customerPageIndex = StateProvider<int>((ref) => 1);
final tempCustomerProvider = StateProvider<EndUserModel>((ref) => EndUserModel());
final billCustomerProvider = StateProvider<EndUserModel>((ref) => EndUserModel());

class CustomerVM extends AsyncNotifier<List<EndUserModel>> {
  @override
  Future<List<EndUserModel>> build() async {
    return await get(noLoad: true);
  }

  Future<List<EndUserModel>> get({bool noLoad = false, int? id, Map<String, dynamic>? where, String? orderBy, bool? isDouble, bool ascending = false, Map<String, dynamic>? search, int? pageIndex, bool noWait = false}) async {
    try {
      if (!noLoad) state = AsyncValue.loading();
      List<EndUserModel> customers = state.value ?? [];

      if (id != null) {
        final customer = (await CustomerRepo.fetchCustomers(where: {"id": id})).first;
        customers.removeWhere((c) => c.id == customer.id);
        customers = [customer, ...customers];
      } else {
        customers = await CustomerRepo.fetchCustomers(
          where: where,
          orderBy: orderBy ?? "modified",
          isDouble: isDouble,
          ascending: ascending,
          search: search,
          limit: 30,
          pageIndex: pageIndex,
        );
      }
      ref.read(dashboardVMProvider.notifier).getTotalGetAndGive();
      state = AsyncValue.data(customers);
      return customers;
    } catch (e, stackTrace) {
      state = AsyncValue.data([]);
      qp('Error: $e\nStackTrace: $stackTrace');
      return [];
    }
  }

  Future<EndUserModel> singleGet(int id) async {
    try {
      List<EndUserModel> customers = state.value ?? [];
      final customer = (await CustomerRepo.fetchCustomers(where: {"id": id})).first;
      customers.removeWhere((c) => c.id == customer.id);
      customers = [customer, ...customers];
      state = AsyncValue.data(customers);
      ref.read(dashboardVMProvider.notifier).getTotalGetAndGive();
      return customer;
    } catch (e) {
      return EndUserModel();
    }
  }

  Future<bool> save(EndUserModel model, {bool enaableReset= true}) async {
    state = AsyncValue.loading();
    
    List<dynamic> results = await Future.wait([CustomerRepo.addCustomer(model)]);
    final res = results[0];
    if (res != 0) {
      await singleGet(res);
      if (model.id != null) {
        final tempCustomer = ref.read(tempCustomerProvider.notifier);
        tempCustomer.state = state.value?.where((e) => e.id == tempCustomer.state.id).first ?? EndUserModel();
      }
    }
    return res != 0;
  }

  Future<bool> multiSave(List<EndUserModel> customerList) async {
    final res = await CustomerRepo.multiSave(customerList);
    if (res) await get();
    return res;
  }
}

final customerVMProvider = AsyncNotifierProvider<CustomerVM, List<EndUserModel>>(CustomerVM.new);
