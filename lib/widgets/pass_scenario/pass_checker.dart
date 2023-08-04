import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:flutter/material.dart';

class PassValidatorElement extends StatelessWidget {
  const PassValidatorElement(
      {super.key, required this.checked, required this.validator});
  final bool checked;
  final String validator;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          color: checked ? kOrange : kGreyForgetPass,
        ),
        const SizedBox(
          width: 10,
        ),
        CustomizedTextWidget(
          textAlign: TextAlign.center,
          data: validator,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: checked ? kOrange : kGreyForgetPass,
        ),
      ],
    );
  }
}
