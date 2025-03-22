import 'package:db_billmate/common_widgets/loading_widget.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/vm/dashboard_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ref.watch(dashboardVMProvider).when(
                  data: (data) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...data.map((e) => Tilt(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  height: 100,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: redColor.withValues(alpha: .3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(e.title ?? ""),
                                      Text(e.value ?? ""),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => SizedBox(height: context.height() - 300, width: context.width() - 200, child: LoadingWidget()),
                ),
          ],
        ));
  }
}
