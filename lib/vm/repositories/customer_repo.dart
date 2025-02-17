import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';

double sumOfElements(List<double> numbers) {
  return numbers.fold(0.0, (sum, element) => sum + element);
}

class CustomerRepo {
  static Future<List<CustomerModel>> fetchCustomers({Map<String, dynamic>? where, String? orderBy, bool? isDouble, bool ascending = true, Map<String, dynamic>? search, int? limit, int? pageIndex}) async {
    try {
      final data = await LocalStorage.get(DBTable.customers, where: where, orderBy: orderBy, isDouble: isDouble ?? false, ascending: ascending, search: search, limit: limit, pageIndex: pageIndex ?? 1);

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
    qp(model, "repoooooooooooo");
    try {
      int? id;

      model = model.copyWith(modified: DateTime.now());
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
