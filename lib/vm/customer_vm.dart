import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/vm/repositories/customer_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerVM extends AsyncNotifier<List<CustomerModel>> {
  @override
  Future<List<CustomerModel>> build() async {
    return await get();
  }

  Future<List<CustomerModel>> get({int? id, Map<String, dynamic>? where, String? orderBy, bool ascending = true, Map<String, dynamic>? search}) async {
    try {
      List<CustomerModel> customers = state.value ?? [];

      if (id != null) {
        final customer = (await CustomerRepo.fetchCustomers(where: {"id": id})).first;
        final index = customers.indexWhere((c) => c.id == customer.id);
        index != -1 ? customers[index] = customer : customers.add(customer);
      } else {
        customers = await CustomerRepo.fetchCustomers(where: where, orderBy: orderBy, ascending: ascending, search: search);
      }

      state = AsyncValue.data(customers);
      return customers;
    } catch (e, stackTrace) {
      qp('Error: $e\nStackTrace: $stackTrace');
      return [];
    }
  }

  Future<bool> save(CustomerModel model) async {
    final res = await CustomerRepo.addCustomer(model);
    if (res != 0) await get(id: res);
    return res != 0;
  }
}

final customerVMProvider = AsyncNotifierProvider<CustomerVM, List<CustomerModel>>(CustomerVM.new);
