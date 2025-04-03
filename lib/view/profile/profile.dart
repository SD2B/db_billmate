import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/custom_icon_button.dart';
import 'package:db_billmate/common_widgets/delete_popup.dart';
import 'package:db_billmate/common_widgets/header_label.dart';
import 'package:db_billmate/common_widgets/loading_widget.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/sddb_helper.dart';
import 'package:db_billmate/helpers/send_helper.dart';
import 'package:db_billmate/models/login_model.dart';
import 'package:db_billmate/vm/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            border: Border.all(color: appPrimary),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ...ref.watch(loginProvider).when(
                  data: (data) {
                    return [
                      CustomButtonCard(width: 450, height: 50, text: "Profile", buttonColor: appSecondary, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: appPrimary)),
                      20.height,
                      Stack(
                        children: [
                          Container(
                              width: 450,
                              decoration: BoxDecoration(
                                border: Border.all(color: appPrimary),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelHeader(label: "Name", header: "${data?.name}"),
                                  20.height,
                                  LabelHeader(label: "Address", header: "${data?.address}"),
                                ],
                              )),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: CustomIconButton(
                              buttonSize: 40,
                              buttonColor: appSecondary,
                              iconColor: appPrimary,
                              shape: BoxShape.rectangle,
                              icon: Icons.edit,
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                      20.height,
                      Stack(
                        children: [
                          Container(
                            width: 450,
                            decoration: BoxDecoration(
                              border: Border.all(color: appPrimary),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelHeader(label: "Username", header: "${data?.userName}"),
                                20.height,
                                LabelHeader(label: "Password", header: "*" * (data?.password?.length ?? 0)),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: CustomIconButton(
                              buttonSize: 40,
                              buttonColor: appSecondary,
                              iconColor: appPrimary,
                              shape: BoxShape.rectangle,
                              icon: Icons.edit,
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                    ];
                  },
                  error: (error, stackTrace) => [Text(error.toString())],
                  loading: () => [SizedBox(height: context.height() - 300, width: context.width() - 200, child: LoadingWidget())]),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    width: 200,
                    height: 50,
                    text: "Backup",
                    buttonColor: appPrimary,
                    textColor: whiteColor,
                    onTap: () async {
                      await SendHelper.shareDatabase();
                    },
                  ),
                  CustomButton(
                    width: 200,
                    height: 50,
                    text: "Logout",
                    buttonColor: appSecondary,
                    textColor: blackColor,
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) => DeletePopup(
                              title: "Are you sure about logging out?",
                              onYes: () async {
                                LoginModel model = await ref.read(loginProvider.notifier).get();
                                model = model.copyWith(isLoggedIn: false);
                                final res = await ref.read(loginProvider.notifier).updateLoginModel(model);
                                if (res) {
                                  context.goNamed(RouteEnum.login.name);
                                }
                              }));
                    },
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
