import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';

double sumOfElements(List<double> numbers) {
  return numbers.fold(0.0, (sum, element) => sum + element);
}

class CustomerRepo {
  static Future<List<EndUserModel>> fetchCustomers({Map<String, dynamic>? where, String? orderBy, bool? isDouble, bool ascending = true, Map<String, dynamic>? search, int? limit, int? pageIndex}) async {
    try {
      final data = await LocalStorage.get(DBTable.customers, where: {...?where, "end_user_type": EndUsertype.customer}, orderBy: orderBy, isDouble: isDouble ?? false, ascending: ascending, search: search, limit: limit, pageIndex: pageIndex ?? 1);
      qp(data.length, "prrreeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeerrrrrrrrrreeeeeeeeeeeppooo");
      final List<EndUserModel> outData = (data as List<dynamic>).map((e) {
        return EndUserModel.fromJson(e);
      }).toList();

      return outData;
    } catch (e) {
      qp(e, "getCustomerError");
      return [];
    }
  }

  static Future<int> addCustomer(EndUserModel model) async {
    qp(model, "repoooooooooooo");
    try {
      int? id;

      model = model.copyWith(modified: DateTime.now());
      if (model.id != null) {
        id = await LocalStorage.update(DBTable.customers, model.toJson(), where: {"id": model.id});
        qp(id, "...........................");
      } else {
        id = await LocalStorage.save(DBTable.customers, model.toJson());
        TransactionModel trnx = TransactionModel(customerId: id, amount: double.tryParse(model.balanceAmount.split("-").join()) ?? 0.00, toGet: model.balanceAmount.contains("-") ? false : true, dateTime: DateTime.now(), transactionType: TransactionType.normal, description: "## opening balance ##");
        await LocalStorage.save(DBTable.transactions, trnx.toJson());
        qp(id, "...........................");
      }
      return id ?? 0;
    } catch (e) {
      qp(e);
      return 0;
    }
  }

  static Future<bool> multiSave(List<EndUserModel> itemList) async {
    try {
      final tempList = await fetchCustomers();
      for (EndUserModel model in itemList) {
        if (tempList.where((e) => e.name?.toLowerCase() == model.name?.toLowerCase()).toList().isEmpty) {
          final id = await LocalStorage.save(DBTable.customers, model.toJson());
          TransactionModel trnx = TransactionModel(customerId: id, amount: double.tryParse(model.balanceAmount.split("-").join()) ?? 0.00, toGet: model.balanceAmount.contains("-") ? false : true, dateTime: DateTime.now(), transactionType: TransactionType.normal, description: "## opening balance ##");
          await LocalStorage.save(DBTable.transactions, trnx.toJson());
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
