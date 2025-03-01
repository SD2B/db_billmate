import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/vm/repositories/transaction_repo.dart';

class InvoiceRepo {
  static Future<List<BillModel>> get({Map<String, dynamic>? where}) async {
    try {
      final rawData = await LocalStorage.get(DBTable.invoice, where: where);
      final data = rawData.map((e) => BillModel.fromJson(e)).toList();
      return data;
    } catch (e, stackTrace) {
      qp(e, "InvoiceRepoGetError");
      qp(stackTrace, "InvoiceRepoGetError");
      return [];
    }
  }

  static Future<bool> save(BillModel model) async {
    try {
      if (model.id == null) {
        //save invoice
        await LocalStorage.save(DBTable.invoice, model.toJson());

        //bill total transaction
        String description1 = double.tryParse(model.discount) == 0
            ? "Invoice No:${model.invoiceNumber}"
            : "Invoice No: ${model.invoiceNumber}\nBill total: ${model.total} and discount:${model.discount}";
        double billTotal1 = double.tryParse(model.discount) == 0
            ? double.parse(model.total ?? "0.00")
            : (double.parse(model.total ?? "0.00") -
                double.parse(model.discount));
        TransactionModel trnxModel1 = TransactionModel(
            amount: billTotal1,
            toGet: true,
            dateTime: model.dateTime,
            transactionType: TransactionType.sale,
            customerId: model.customerId,
            description: description1);
        await TransactionRepo.save(trnxModel1);

        //bill recieved transaction
        if (double.parse(model.received) != 0) {
          String description2 = "Invoice No:${model.invoiceNumber}";
          double billTotal2 = double.parse(model.received);
          TransactionModel trnxModel2 = TransactionModel(
              amount: billTotal2,
              toGet: false,
              dateTime: model.dateTime,
              transactionType: TransactionType.sale,
              customerId: model.customerId,
              description: description2);
          await TransactionRepo.save(trnxModel2);
        }
      } else {
        await LocalStorage.update(DBTable.invoice, model.toJson(),
            where: {"id": model.id});
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> delete(int id) async {
    try {
      await LocalStorage.delete(DBTable.invoice, where: {"id": id});
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
