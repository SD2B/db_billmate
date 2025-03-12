import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/ui_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isFirstTimeNotifier = StateProvider<bool>((ref) => true);
final toGetAndGive = StateProvider<List<String>>((ref) => []);

class DashboardVM extends AsyncNotifier<List<UiModel>> {
  @override
  Future<List<UiModel>> build() async {
    return await getDashboardData();
  }

  Future<List<UiModel>> getDashboardData() async {
    try {
      state = AsyncValue.data([]);
      state = AsyncValue.loading();
      List<UiModel> data = [...await getTotalGetAndGive()];
      state = AsyncValue.data([]);
      return data;
    } catch (e) {
      qp(e);
      return [];
    }
  }

  Future<List<UiModel>> getTotalGetAndGive({bool noLoad = false, int? id, Map<String, dynamic>? where, String? orderBy, bool? isDouble, bool ascending = false, Map<String, dynamic>? search, int? pageIndex, bool noWait = false}) async {
    try {
      final rawData = await LocalStorage.rawQuery('''
    SELECT 
      SUM(CASE WHEN CAST(balance_amount AS REAL) >= 0 THEN CAST(balance_amount AS REAL) ELSE 0 END) AS to_get,
      SUM(CASE WHEN CAST(balance_amount AS REAL) < 0 THEN CAST(balance_amount AS REAL) ELSE 0 END) AS to_give
    FROM customers;
  ''');
      qp(rawData);
      List<UiModel> data = rawData.expand((e) => [UiModel(id: 1, title: "To get", value: double.parse("${e["to_get"]??0}").toStringAsFixed(2)), UiModel(id: 2, title: "To give", value: double.parse("${e["to_give"]??0}").toStringAsFixed(2).split("-").join())]).toList();
      qp(data);
      ref.read(toGetAndGive.notifier).state = [...data.map((e) => e.value ?? "")];
      return data;
    } catch (e, stackTrace) {
      qp('Error: $e\nStackTrace: $stackTrace');
      return [];
    }
  }
}

final dashboardVMProvider = AsyncNotifierProvider<DashboardVM, List<UiModel>>(DashboardVM.new);
