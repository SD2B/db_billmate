import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/models/item_model.dart';
import 'package:db_billmate/vm/repositories/invoice_repo.dart';
import 'package:db_billmate/vm/transaction_vm.dart';
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
      //ou transaction updatet
      TransactionModel outTrnx = (await ref.read(transactionVMProvider.notifier).get(where: {"uid": model.outTrnxId})).toList().firstOrNull ?? TransactionModel();
      qp(model, "111111111111111111111");
      qp(outTrnx, "111111111111111111111");
      double billTotal1 = double.tryParse(model.discount) == 0 ? double.parse(model.total ?? "0.00") : (double.parse(model.total ?? "0.00") - double.parse(model.discount));
      outTrnx = outTrnx.copyWith(amount: billTotal1);
      await ref.read(transactionVMProvider.notifier).updateTransactionModel(outTrnx);

      //in transaction update
      if (model.inTrnxId != null) {
        TransactionModel inTrnx = (await ref.read(transactionVMProvider.notifier).get(where: {"uid": model.inTrnxId})).toList().firstOrNull ?? TransactionModel();
        qp(inTrnx, "111111111111111111111222222222222");
        double billTotal2 = double.parse(model.received);
        inTrnx = inTrnx.copyWith(amount: billTotal2);
        await ref.read(transactionVMProvider.notifier).updateTransactionModel(inTrnx);
      } else if (double.parse(model.received) != 0) {
        final inTrnxId = UniqueIdGenerator.generateId(reverse: true);
        double billTotal2 = double.parse(model.received);
        String description2 = "Invoice No:${model.invoiceNumber}";

        TransactionModel inTrnx = TransactionModel(
          uid: inTrnxId,
          toGet: false,
          transactionType: TransactionType.sale,
          customerId: model.customerId,
          amount: billTotal2,
          dateTime: DateTime.now(),
          description: description2,
        );
        qp(inTrnx, "1111111111111111111112222222222223333333333333");
        await ref.read(transactionVMProvider.notifier).save(inTrnx);
        model = model.copyWith(inTrnxId: inTrnxId);
      }
      bool res = await InvoiceRepo.save(model);
      await get(noLoad: true);
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
