import 'dart:math';

import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/vm/repositories/customer_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tempCustomerProvider = StateProvider<CustomerModel>((ref) => CustomerModel());

class CustomerVM extends AsyncNotifier<List<CustomerModel>> {
  @override
  Future<List<CustomerModel>> build() async {
    return await get(noLoad: true);
  }

  Future<List<CustomerModel>> get({bool noLoad = false, int? id, Map<String, dynamic>? where, String? orderBy, bool? isDouble, bool ascending = false, Map<String, dynamic>? search, int? pageIndex}) async {
    try {
      if (!noLoad) state = AsyncValue.loading();
      List<CustomerModel> customers = state.value ?? [];

      if (id != null) {
        final customer = (await CustomerRepo.fetchCustomers(where: {"id": id})).first;
        customers.removeWhere((c) => c.id == customer.id);
        customers = [customer, ...customers];
      } else {
        customers = await CustomerRepo.fetchCustomers(where: where, orderBy: orderBy ?? "modified", isDouble: isDouble, ascending: ascending, search: search);
      }
      await Future.delayed(Duration(seconds: 2));
      state = AsyncValue.data(customers);
      return customers;
    } catch (e, stackTrace) {
      qp('Error: $e\nStackTrace: $stackTrace');
      return [];
    }
  }

  Future<bool> save(CustomerModel model) async {
    final res = await CustomerRepo.addCustomer(model);
    if (res != 0) {
      await get(noLoad: true, id: res);
      final tempCustomer = ref.read(tempCustomerProvider.notifier);
      tempCustomer.state = state.value?.where((e) => e.id == tempCustomer.state.id).first ?? CustomerModel();
    }
    return res != 0;
  }

  Future<void> createAndSaveCustomers() async {
    final random = Random();
    const baseName = "Customer";
    final now = DateTime.now();

    for (int i = 1; i <= 500; i++) {
      // Generate a random name and phone number
      final name = "$baseName $i";
      final phone = generatePhoneNumber(random);

      // Create a customer model
      final customer = CustomerModel(
        name: name,
        phone: phone,
        address: "123 Main Street, Springfield",
        group: "Premium Customers",
        balanceAmount: "475.0",
        modified: now,
        transactionList: generateTransactionList(random, i, now),
      );

      // Save the customer
      final success = await save(customer);
      if (!success) {
        qp("Failed to save customer $i: $name");
      }
    }
    qp("Finished saving 500 customers.");
  }

  String generatePhoneNumber(Random random) {
    return List.generate(10, (index) => random.nextInt(10)).join();
  }

  List<AmountModel> generateTransactionList(Random random, int customerId, DateTime baseTime) {
    List<AmountModel> transactions = [];
    for (int i = 0; i < 300; i++) {
      final amount = random.nextDouble() * 500;
      final toGet = random.nextBool();
      final description = toGet ? "Transaction #${i + 1} - Payment received" : "Transaction #${i + 1} - Payment made";
      final dateTime = baseTime.subtract(Duration(days: random.nextInt(30), hours: random.nextInt(24), minutes: random.nextInt(60)));

      transactions.add(AmountModel(
        id: random.nextInt(10000),
        customerId: customerId,
        amount: double.parse(amount.toStringAsFixed(2)),
        description: description,
        toGet: toGet,
        dateTime: dateTime,
      ));
    }
    return transactions;
  }
}

final customerVMProvider = AsyncNotifierProvider<CustomerVM, List<CustomerModel>>(CustomerVM.new);
