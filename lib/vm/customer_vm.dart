import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/vm/repositories/customer_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerVM extends AsyncNotifier<List<CustomerModel>> {
  @override
  Future<List<CustomerModel>> build() async {
    return await getCustomers();
  }

  Future<List<CustomerModel>> getCustomers({bool isBuild = true}) async {
    try {
      final customers = await CustomerRepo.fetchCustomers();
      qp(customers);
      return customers;
    } catch (e) {
      qp(e);
      return [];
    }
  }
}

final customerVMProvider = AsyncNotifierProvider<CustomerVM, List<CustomerModel>>(CustomerVM.new);
