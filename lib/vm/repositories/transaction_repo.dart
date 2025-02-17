import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';

class TransactionRepo {
  static Future<List<TransactionModel>> get({Map<String, dynamic>? where}) async {
    try {
      final rawData = await LocalStorage.get(DBTable.transactions, where: where);
      final data = rawData.map((e) => TransactionModel.fromJson(e)).toList();

      return data;
    } catch (e) {
      qp(e, "TransactionRepoGetError");
      return [];
    }
  }

  static Future<bool> save(TransactionModel model) async {
    try {
      int id = model.customerId ?? 0;
      String amount = model.amount.toString();
      if (model.id == null) {
        final List<int> results = await Future.wait([
          LocalStorage.save(DBTable.transactions, model.toJson()),
          LocalStorage.rawQuery('''
                              UPDATE customers 
                              SET balance_amount = (CAST(balance_amount AS REAL) ${model.toGet ? '+' : '-'} CAST($amount AS REAL)) 
                              WHERE id = $id
                              ''')
        ]);
        qp(results, "TransactionRepoSave");
      } else {
        final res = await LocalStorage.update(DBTable.transactions, model.toJson(), where: {"id": model.id});
        qp(res);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> delete(int id) async {
    try {
      await LocalStorage.delete(DBTable.transactions, where: {"id":id} );
      return true;
    } catch (e) {
      return false;
    }
  }
  static Future<bool> closeAccount(int customerId) async {
    try {
      await LocalStorage.rawQuery('''
      DELETE FROM transactions WHERE customer_id = $customerId
    ''');
      return true;
    } catch (e) {
      return false;
    }
  }
}
