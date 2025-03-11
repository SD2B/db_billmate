import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/repositories/transaction_repo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tempTransactionProvider = StateProvider<TransactionModel>((ref) => TransactionModel());

class TransactionVM extends AsyncNotifier<List<TransactionModel>> {
  @override
  Future<List<TransactionModel>> build() async {
    return await get(noLoad: true);
  }

  Future<List<TransactionModel>> get({bool noLoad = false, int? id, Map<String, dynamic>? where, String? orderBy, bool? isDouble, bool ascending = false, Map<String, dynamic>? search, int? pageIndex, DateTimeRange? dateRange}) async {
    try {
      if (!noLoad) state = AsyncValue.loading();
      List<TransactionModel> transactionList = state.value ?? [];

      if (id != null) {
        final transaction = (await TransactionRepo.get(where: {"id": id})).first;
        transactionList.removeWhere((t) => t.id == transaction.id);
        transactionList = [transaction, ...transactionList];
      } else {
        transactionList = await TransactionRepo.get(where: where, dateRange: MapEntry("date_time", dateRange ?? DateTimeRange(start: DateTime.now().subtract(Duration(days: 30)), end: DateTime.now())));
      }
      state = AsyncValue.data(transactionList);
      qp(transactionList);
      return transactionList;
    } catch (e, stackTrace) {
      qp('Error: $e\nStackTrace: $stackTrace');
      return [];
    }
  }

  Future<void> test() async {
    try {
      for (int j = 1; j < 1005; j++) {
        for (int i = 1; i < 500; i++) {
          await testSave(TransactionModel(
            amount: 200,
            customerId: j,
            dateTime: DateTime.now(),
            description: "test transaction - ##$i",
            toGet: i.isOdd ? true : false,
            transactionType: TransactionType.normal,
          ));
        }
      }
    } catch (e) {
      qp(e);
    }
  }

  Future<bool> testSave(TransactionModel model) async {
    state = AsyncValue.loading();
    try {
      bool res = await TransactionRepo.save(model);
      if (res) {
        final newCustomer = (await ref.read(customerVMProvider.notifier).singleGet(model.customerId ?? 0));
        ref.read(tempCustomerProvider.notifier).state = newCustomer;
      }
      return res;
    } catch (e) {
      qp(e, "transactionSaveError");
      state = AsyncValue.data(state.value ?? []);
      return false;
    }
  }

  Future<bool> save(TransactionModel model) async {
    state = AsyncValue.loading();
    try {
      bool res = await TransactionRepo.save(model);
      final customer = ref.read(tempCustomerProvider.notifier).state;
      if (res) {
        await get(where: {"customer_id": customer.id}, noLoad: true);
        final newCustomer = (await ref.read(customerVMProvider.notifier).singleGet(customer.id ?? 0));
        ref.read(tempCustomerProvider.notifier).state = newCustomer;
      }
      return res;
    } catch (e) {
      qp(e, "transactionSaveError");
      state = AsyncValue.data(state.value ?? []);
      return false;
    }
  }

  Future<bool> updateTransactionModel(TransactionModel model) async {
    state = AsyncValue.loading();
    try {
      bool res = await TransactionRepo.save(model);
      CustomerModel customer = ref.read(tempCustomerProvider.notifier).state;
      double prevTransactionAmount = (state.value?.where((e) => e.id == model.id).toList())?.first.amount ?? 0;
      customer = customer.copyWith(balanceAmount: "${(double.parse(customer.balanceAmount) - prevTransactionAmount) + model.amount}");
      await ref.read(customerVMProvider.notifier).save(customer);
      if (res) {
        await get(where: {"customer_id": customer.id}, noLoad: true);
        // final newCustomer = (await ref.read(customerVMProvider.notifier).singleGet(customer.id ?? 0));
        // ref.read(tempCustomerProvider.notifier).state = newCustomer;
      }
      return res;
    } catch (e) {
      qp(e, "transactionSaveError");
      state = AsyncValue.data(state.value ?? []);
      return false;
    }
  }

  Future closeAccount(int id) async {
    await TransactionRepo.closeAccount(id);
    // await get(where: {"customer_id": id});
  }

  Future<bool> delete(TransactionModel model) async {
    final res = await TransactionRepo.delete(model.id ?? 0);
    if (res) {
      CustomerModel customerModel = ref.read(tempCustomerProvider.notifier).state;
      qp(customerModel, "ddddddddddddddddddd");
      qp(model, "ddddddddddddddddddd");
      final minusAmount = model.toGet ? model.amount : double.parse("-${model.amount}");
      final balanceAmount = double.parse(customerModel.balanceAmount);
      customerModel = customerModel.copyWith(balanceAmount: "${balanceAmount - minusAmount}");
      await ref.read(customerVMProvider.notifier).save(customerModel);
      get(where: {"customer_id": customerModel.id});
    }
    return res;
  }
}

final transactionVMProvider = AsyncNotifierProvider<TransactionVM, List<TransactionModel>>(TransactionVM.new);
