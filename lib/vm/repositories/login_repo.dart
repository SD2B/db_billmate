import 'package:db_billmate/common_widgets/sd_toast.dart';
import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/login_model.dart';

class LoginRepo {
  static Future<LoginModel> get() async {
    LoginModel model = LoginModel();
    try {
      final res = await LocalStorage.get(DBTable.login);
      if (res.isNotEmpty) {
        model = LoginModel.fromJson(res.first);
      }
      return model;
    } catch (e) {
      qp(e, "loginRepoGetError");
      return model;
    }
  }

  static Future<bool> update(LoginModel model) async {
    try {
      await LocalStorage.update(DBTable.login, model.toJson(), where: {"id": model.id});
      return true;
    } catch (e) {
      SDToast.errorToast(description: "$e");
      qp(e, "loginRepoSaveError");
      return false;
    }
  }
}
