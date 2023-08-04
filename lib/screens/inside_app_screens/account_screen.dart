import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/functions/APIs/call_logout_api.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kScreenHeight * 0.2,
        leading: null,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Container(
            color: kWhiteSingleOcassionBorder,
            height: 2.0,
          ),
        ),
        title: SizedBox(
            height: 100,
            child: Image.asset(
              "assets/images/Group 5.png",
              fit: BoxFit.fill,
            )),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Container(
              width: double.infinity,
              color: kWhiteSingleOcassionBorder,
              height: 3.0,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: kScreenHeight * 0.05,
            child: Card(
              //borderOnForeground: true,
              shape: const Border.symmetric(
                vertical: BorderSide.none,
                horizontal: BorderSide(
                  color: kLogoutCardBorder,
                ),
              ),
              color: kLogoutCard,
              child: InkWell(
                onTap: () {
                  logout(context: context);
                },
                child: Row(
                  children: [
                    ImageIcon(
                      const AssetImage(
                        "assets/images/..png",
                      ),
                      size: kScreenHeight * 0.1,
                      color: kBlack,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustomizedTextWidget(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        data: "Log Out",
                        color: kBlack),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
