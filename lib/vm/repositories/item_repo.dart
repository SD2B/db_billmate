import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/models/ui_model.dart';

class ItemRepo {
  static Future<List<ItemModel>> get({Map<String, dynamic>? search, Map<String, dynamic>? where}) async {
    try {
      final rawData = await LocalStorage.get(DBTable.items, search: search, where: where, orderBy: "name", ascending: true);
      qp(rawData.first["stock_count"].runtimeType);
      List<ItemModel> data = rawData.map((e) => ItemModel.fromJson(e)).toList();
      return data;
    } catch (e, stackTrace) {
      qp(e, "$stackTrace");
      return [];
    }
  }

  static Future<ResponseModel> save(ItemModel model) async {
    int? res;
    ResponseModel response = ResponseModel();
    model = model.copyWith(modified: DateTime.now(), purchasePrice: (model.purchasePrice?.isEmpty == true || model.purchasePrice == null) ? null : model.purchasePrice);
    try {
      if (model.id != null) {
        res = await LocalStorage.update(DBTable.items, model.toJson(), where: {"id": model.id});
      } else {
        res = await LocalStorage.save(DBTable.items, model.toJson());
      }
      return response.copyWith(id: res, isSuccess: res != null);
    } catch (e) {
      return response.copyWith(isSuccess: false);
    }
  }

  static Future<bool> multiSave(List<ItemModel> itemList) async {
    try {
      final tempList = await get();
      for (ItemModel model in itemList) {
        if (tempList.where((e) => e.name?.toLowerCase() == model.name?.toLowerCase()).toList().isEmpty) {
          model = model.copyWith(modified: DateTime.now(), billId: null, quantity: null, billPrice: null, category: (model.category?.isEmpty == true || model.category == null) ? null : model.category, purchasePrice: (model.purchasePrice?.isEmpty == true || model.purchasePrice == null) ? null : model.purchasePrice);
          await LocalStorage.save(DBTable.items, model.toJson());
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<ResponseModel> updateStock(String stockOutValue, String stockCountValue, String itemId) async {
    try {
      await LocalStorage.rawQuery(
        'UPDATE items SET stock_out = ?, stock_count = ? WHERE id = ?',
        [stockOutValue, stockCountValue, itemId],
      );
      return ResponseModel(isSuccess: true);
    } catch (e) {
      return ResponseModel(isSuccess: false);
    }
  }

  static Future<bool> delete(int id) async {
    try {
      await LocalStorage.delete(DBTable.items, where: {"id": id});
      return true;
    } catch (e) {
      return false;
    }
  }
}
