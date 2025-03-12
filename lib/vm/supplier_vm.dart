import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/vm/dashboard_vm.dart';
import 'package:db_billmate/vm/repositories/supplier_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final supplierPageIndex = StateProvider<int>((ref) => 1);
final tempSupplierProvider = StateProvider<EndUserModel>((ref) => EndUserModel());
final billSupplierProvider = StateProvider<EndUserModel>((ref) => EndUserModel());

class SupplierVM extends AsyncNotifier<List<EndUserModel>> {
  @override
  Future<List<EndUserModel>> build() async {
    return await get(noLoad: true);
  }

  Future<List<EndUserModel>> get({bool noLoad = false, int? id, Map<String, dynamic>? where, String? orderBy, bool? isDouble, bool ascending = false, Map<String, dynamic>? search, int? pageIndex, bool noWait = false}) async {
    try {
      if (!noLoad) state = AsyncValue.loading();
      List<EndUserModel> suppliers = state.value ?? [];

      if (id != null) {
        final supplier = (await SupplierRepo.get(where: {"id": id})).first;
        suppliers.removeWhere((c) => c.id == supplier.id);
        suppliers = [supplier, ...suppliers];
      } else {
        suppliers = await SupplierRepo.get(
          where: {...?where, "end_user_type": EndUsertype.supplier},
          orderBy: orderBy ?? "modified",
          isDouble: isDouble,
          ascending: ascending,
          search: search,
          limit: 30,
          pageIndex: pageIndex,
        );
      }
      ref.read(dashboardVMProvider.notifier).getTotalGetAndGive();
      state = AsyncValue.data(suppliers);
      return suppliers;
    } catch (e, stackTrace) {
      state = AsyncValue.data([]);
      qp('Error: $e\nStackTrace: $stackTrace');
      return [];
    }
  }

  Future<EndUserModel> singleGet(int id) async {
    try {
      List<EndUserModel> suppliers = state.value ?? [];
      final supplier = (await SupplierRepo.get(where: {"id": id})).first;
      suppliers.removeWhere((c) => c.id == supplier.id);
      suppliers = [supplier, ...suppliers];
      state = AsyncValue.data(suppliers);
      ref.read(dashboardVMProvider.notifier).getTotalGetAndGive();
      return supplier;
    } catch (e) {
      return EndUserModel();
    }
  }

  Future<bool> save(EndUserModel model) async {
    state = AsyncValue.loading();
    List<dynamic> results = await Future.wait([SupplierRepo.save(model)]);
    final res = results[0];
    if (res != 0) {
      await singleGet(res);
      if (model.id != null) {
        final tempSupplier = ref.read(tempSupplierProvider.notifier);
        tempSupplier.state = state.value?.where((e) => e.id == tempSupplier.state.id).first ?? EndUserModel();
      }
    }
    return res != 0;
  }
}

final supplierVMProvider = AsyncNotifierProvider<SupplierVM, List<EndUserModel>>(SupplierVM.new);
