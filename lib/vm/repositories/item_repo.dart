import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/models/item_model.dart';

class ItemRepo {
  static Future<List<ItemModel>> get({Map<String, dynamic>? search, Map<String, dynamic>? where}) async {
    try {
      final rawData = await LocalStorage.get(DBTable.items, search: search, where: where, orderBy: "name", ascending: true);
      List<ItemModel> data = rawData.map((e) => ItemModel.fromJson(e)).toList();
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> save(ItemModel model) async {
    try {
      if (model.id != null) {
        await LocalStorage.update(DBTable.items, model.toJson(), where: {"id": model.id});
      } else {
        await LocalStorage.save(DBTable.items, model.toJson());
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> multiSave(List<ItemModel> itemList) async {
    try {
      final tempList = await get();
      for (ItemModel model in itemList) {
        if (tempList.where((e) => e.name?.toLowerCase() == model.name?.toLowerCase()).toList().isEmpty) {
          await LocalStorage.save(DBTable.items, model.toJson());
        }
      }
      return true;
    } catch (e) {
      return false;
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
