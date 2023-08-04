import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:flutter/material.dart';

class BeginigInterfaceWidget extends StatelessWidget {
  const BeginigInterfaceWidget(
      {super.key, required this.image, required this.pageTitle});
  final String image;
  final String pageTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kScreenHeight * .3,
          width: kScreenWidth * .8,
          child: Stack(
            children: [
              Positioned(
                top: kScreenHeight * 0.03,
                left: kScreenWidth * 0.2,
                height: kScreenHeight * 0.1,
                width: kScreenWidth * 0.37,
                child: Image.asset('assets/images/$image'),
              ),
              Positioned(
                top: kScreenHeight * 0.16,
                left: kScreenWidth * 0.15,
                height: kScreenHeight * 0.08,
                width: kScreenWidth * 0.75,
                child: Text(
                  pageTitle,
                  style: const TextStyle(
                      color: kBlack,
                      fontFamily: 'Jost',
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
