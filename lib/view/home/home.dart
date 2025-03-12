import 'package:db_billmate/common_widgets/loading_widget.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/vm/dashboard_vm.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(dashboardVMProvider).when(
          data: (data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...data.map((e) => Text(e.value ?? "")),
              ],
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => SizedBox(height: context.height() - 300, width: context.width() - 200, child: LoadingWidget()),
        );
  }
}
