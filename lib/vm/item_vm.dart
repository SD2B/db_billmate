import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/vm/repositories/item_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemVM extends AsyncNotifier<List<ItemModel>> {
  @override
  Future<List<ItemModel>> build() async {
    return await get(noLoad: true);
  }

  Future<List<ItemModel>> get({bool noLoad = false, Map<String, dynamic>? search, Map<String, dynamic>? where}) async {
    if (!noLoad) state = AsyncValue.loading();
    final itemList = await ItemRepo.get(search: search, where: where);
    state = AsyncValue.data(itemList);
    return itemList;
  }

  Future<bool> save(ItemModel model) async {
    final res = await ItemRepo.save(model);
    if (res) await get();
    return res;
  }
  Future<bool> delete(int id) async {
    final res = await ItemRepo.delete(id);
    if (res) await get();
    return res;
  }
}

final itemVMProvider = AsyncNotifierProvider<ItemVM, List<ItemModel>>(ItemVM.new);
