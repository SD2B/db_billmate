import 'package:db_billmate/models/login_model.dart';
import 'package:db_billmate/vm/repositories/login_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginVM extends AsyncNotifier<LoginModel?> {
  @override
  Future<LoginModel?> build() async {
    return await get();
  }

  Future<LoginModel> get() async {
    state = const AsyncValue.loading();
    try {
      final data = await LoginRepo.get();
      state = AsyncValue.data(data);
      return data;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return LoginModel();
    }
  }

  Future<bool> updateLoginModel(LoginModel model) async {
    final res = await LoginRepo.update(model);
    return res;
  }
}

final loginProvider = AsyncNotifierProvider<LoginVM, LoginModel?>(() => LoginVM());
