import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/vm/repositories/invoice_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tempBillModelProvider = StateProvider<BillModel>((ref) => BillModel());
final invNoProvider = StateProvider<int>((ref) => 1);

class InvoiceVM extends AsyncNotifier<List<BillModel>> {
  @override
  Future<List<BillModel>> build() async {
    return await get(noLoad: true);
  }

  Future<List<BillModel>> get({bool noLoad = false, Map<String, dynamic>? where, String? orderBy, bool? isDouble, bool ascending = false, Map<String, dynamic>? search, int? pageIndex}) async {
    try {
      qp("111111111111");
      if (!noLoad) state = AsyncValue.loading();
      List<BillModel> invoiceList = state.value ?? [];
      invoiceList = await InvoiceRepo.get(where: where, search: search, pageIndex: pageIndex);
      state = AsyncValue.data(invoiceList);
      qp(invoiceList, "ssssssssss");
      return invoiceList;
    } catch (e, stackTrace) {
      qp('Error: $e\nStackTrace: $stackTrace');
      state = AsyncValue.data(state.value ?? []);
      return [];
    }
  }

  Future<bool> save(BillModel model) async {
    state = AsyncValue.loading();
    try {
      bool res = await InvoiceRepo.save(model);
      state = AsyncValue.data(state.value ?? []);
      return res;
    } catch (e) {
      qp(e, "invoiceSaveError");
      state = AsyncValue.data(state.value ?? []);
      return false;
    }
  }

  Future<bool> updateBillModel(BillModel model) async {
    state = AsyncValue.loading();
    try {
      bool res = await InvoiceRepo.save(model);
      return res;
    } catch (e) {
      qp(e, "invoiceSaveError");
      state = AsyncValue.data(state.value ?? []);
      return false;
    }
  }

  Future<bool> delete(BillModel model) async {
    final res = await InvoiceRepo.delete(model.id ?? 0);
    return res;
  }

  Future<void> getInvNo() async {
    try {
      ref.read(invNoProvider.notifier).state = await LocalStorage.getLength(DBTable.invoice) + 1;
    } catch (e) {
      qp(e);
    }
  }
}

final invoiceVMProvider = AsyncNotifierProvider<InvoiceVM, List<BillModel>>(InvoiceVM.new);
