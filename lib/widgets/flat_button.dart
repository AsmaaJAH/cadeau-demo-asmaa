import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:flutter/material.dart';

class FlatButton extends StatefulWidget {
  const FlatButton({
    super.key,
    required this.condition,
    required this.onPressedFunction,
    required this.activatedData,
    required this.deactivedData,


  });
  final void Function() onPressedFunction;
  final bool condition;

  final String activatedData;
  final String deactivedData;


  @override
  State<FlatButton> createState() {
    return _FlatButtonState();
  }
}

class _FlatButtonState extends State<FlatButton> {
  @override
  Widget build(BuildContext context) {
    //flat button is now text button in flutter
    return TextButton(
      onPressed: widget.condition ? widget.onPressedFunction : null,
      style: widget.condition
          ? TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              minimumSize: Size.fromHeight(kScreenHeight* 0.079),
              backgroundColor: kTeal,
            )
          : TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              minimumSize: Size.fromHeight(kScreenHeight * 0.079),
              backgroundColor: kGrey,
            ),
      child: Text( widget.condition
          ? widget.activatedData
          : widget.deactivedData,
        style: const TextStyle(
            color: kWhite, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Jost'),
      ),
    );
  }
}
