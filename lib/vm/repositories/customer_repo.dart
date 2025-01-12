import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';

double sumOfElements(List<double> numbers) {
  return numbers.fold(0.0, (sum, element) => sum + element);
}

class CustomerRepo {
  static Future<List<CustomerModel>> fetchCustomers({Map<String, dynamic>? where, String? orderBy, bool ascending = true, Map<String, dynamic>? search}) async {
    try {
      final data = await LocalStorage.get(DBTable.customers, where: where, orderBy: orderBy, ascending: ascending, search: search);

      final List<CustomerModel> outData = (data as List<dynamic>).map((e) {
        return CustomerModel.fromJson(e);
      }).toList();

      return outData;
    } catch (e) {
      qp(e, "getCustomerError");
      return [];
    }
  }

  static Future<int> addCustomer(CustomerModel model) async {
    try {
      int? id;
      final youGave = sumOfElements(model.transactionList?.where((e) => e.toGet == true).map((e) => e.amount).toList() ?? []);
      final youGot = sumOfElements(model.transactionList?.where((e) => e.toGet == false).map((e) => e.amount).toList() ?? []);
      final balance = youGave - youGot;
      model = model.copyWith(balanceAmount: balance.toString(), modified: DateTime.now());
      if (model.id != null) {
        id = await LocalStorage.update(DBTable.customers, model.toJson(), where: {"id": model.id});
        qp(id, "...........................");
      } else {
        id = await LocalStorage.save(DBTable.customers, model.toJson());
        qp(id, "...........................");
      }
      return id ?? 0;
    } catch (e) {
      qp(e);
      return 0;
    }
  }
}
