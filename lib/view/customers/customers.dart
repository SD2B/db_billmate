import 'package:db_billmate/common_widgets/header_label.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/models/customer_model.dart';
import 'package:db_billmate/vm/customer_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Customers extends HookConsumerWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HeaderLabel(header: "Customers"),
        ref.watch(customerVMProvider).when(
            data: (customerList) {
              return Expanded(
                child: ListView.builder(
                    itemCount: customerList.length,
                    itemBuilder: (context, index) {
                      CustomerModel model = customerList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                          model.name!.initials,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        ),
                        title: Text(
                          model.name!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      );
                    }),
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => CircularProgressIndicator.adaptive())
      ],
    );
  }
}
