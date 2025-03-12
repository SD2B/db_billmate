import 'package:db_billmate/common_widgets/custom_button.dart';
import 'package:db_billmate/common_widgets/delete_popup.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:db_billmate/helpers/common_enums.dart';
import 'package:db_billmate/helpers/send_helper.dart';
import 'package:db_billmate/models/login_model.dart';
import 'package:db_billmate/vm/repositories/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
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
                                LoginModel model = await LoginRepo.get();
                                model = model.copyWith(isLoggedIn: false);
                                final res = await LoginRepo.update(model);
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
