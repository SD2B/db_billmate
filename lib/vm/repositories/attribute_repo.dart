import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/ui_model.dart';

class AttributeRepo {
  //catogory*****************************************************************
  static Future<List<UiModel>> get(int attributeId) async {
    try {
      final rawData = await LocalStorage.get(DBTable.attributes,
          where: {"id": attributeId});
      List<dynamic> rawDataList = rawData.first["data"];
      List<UiModel> data =
          rawDataList.map((item) => UiModel(value: item)).toList();
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> save(int attributeId, List<String> data) async {
    try {
      qp(data);
      await LocalStorage.updateWhere(
          tableName: DBTable.attributes,
          columnName: "data",
          where: {"id": attributeId},
          data: data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> delete(int attributeId) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
