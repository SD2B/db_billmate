import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/end_user_model.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:db_billmate/vm/repositories/transaction_repo.dart';
import 'package:db_billmate/vm/supplier_vm.dart';
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
      state = AsyncValue.data(state.value ?? []);
      return [];
    }
  }

  //document the save function
  Future<bool> save(TransactionModel model, {bool isSupplier = false}) async {
    state = AsyncValue.loading();
    try {
      //save the transaction
      bool res = await TransactionRepo.save(model);
      //get the end user
      EndUserModel endUser;
      if (isSupplier) {
        //get the supplier
        endUser = ref.read(tempSupplierProvider.notifier).state;
      } else {
        //get the customer
        endUser = ref.read(tempCustomerProvider.notifier).state;
      }
      //if the transaction is saved
      if (res) {
        //get the transactions
        await get(where: {"customer_id": endUser.id}, noLoad: true);
        //get the new end user
        EndUserModel newEndUser;
        if (isSupplier) {
          //get the supplier
          newEndUser = (await ref.read(supplierVMProvider.notifier).singleGet(endUser.id ?? 0));
          //set the new supplier
          ref.read(tempSupplierProvider.notifier).state = newEndUser;
        } else {
          //get the customer
          newEndUser = (await ref.read(customerVMProvider.notifier).singleGet(endUser.id ?? 0));
          //set the new customer
          ref.read(tempCustomerProvider.notifier).state = newEndUser;
        }
      }
      return res;
    } catch (e) {
      qp(e, "transactionSaveError");
      state = AsyncValue.data(state.value ?? []);
      return false;
    }
  }

  Future<bool> updateTransactionModel(TransactionModel model, {bool isSupplier = false}) async {
    state = AsyncValue.loading();
    try {
      //get the previous transaction amount
      double prevTransactionAmount = (await TransactionRepo.get(where: {"id": model.id})).first.amount;
      //update the transaction
      bool res = await TransactionRepo.save(model);
      EndUserModel endUser;
      if (isSupplier) {
        endUser = ref.read(tempSupplierProvider.notifier).state;
      } else {
        endUser = ref.read(tempCustomerProvider.notifier).state;
      }
      //update the balance amount of the end user
      endUser = endUser.copyWith(balanceAmount: "${(double.parse(endUser.balanceAmount) - prevTransactionAmount) + model.amount}");
      //save the end user
      if (isSupplier) {
        await ref.read(supplierVMProvider.notifier).save(endUser);
      } else {
        await ref.read(customerVMProvider.notifier).save(endUser);
      }
      if (res) {
        await get(where: {"customer_id": endUser.id}, noLoad: true);
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

  Future<bool> delete(TransactionModel model, {bool isSupplier = false}) async {
    final res = await TransactionRepo.delete(model.id ?? 0);
    if (res) {
      EndUserModel endUser;
      if (isSupplier) {
        endUser = ref.read(tempSupplierProvider.notifier).state;
      } else {
        endUser = ref.read(tempCustomerProvider.notifier).state;
      }

      final minusAmount = model.toGet ? model.amount : double.parse("-${model.amount}");
      final balanceAmount = double.parse(endUser.balanceAmount);
      endUser = endUser.copyWith(balanceAmount: "${balanceAmount - minusAmount}");
      if (isSupplier) {
        await ref.read(supplierVMProvider.notifier).save(endUser);
      } else {
        await ref.read(customerVMProvider.notifier).save(endUser);
      }
      get(where: {"customer_id": endUser.id});
    }
    return res;
  }
}

final transactionVMProvider = AsyncNotifierProvider<TransactionVM, List<TransactionModel>>(TransactionVM.new);
