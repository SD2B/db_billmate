import 'package:db_billmate/models/ui_model.dart';
import 'package:db_billmate/vm/repositories/attribute_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupVM extends AsyncNotifier<List<UiModel>> {
  @override
  Future<List<UiModel>> build() async {
    return await get();
  }

  Future<List<UiModel>> get() async {
    final data = await AttributeRepo.get(3);
    state = AsyncValue.data(data);
    return data;
  }

  Future<bool> save(String value) async {
    List<String> data = [
      ...(state.value ?? []).map((e) => e.value.toString()),
      value
    ];
    final res = await AttributeRepo.save(3, data);
    if (res) await get();
    return res;
  }
}

final groupVMProvider =
    AsyncNotifierProvider<GroupVM, List<UiModel>>(GroupVM.new);
