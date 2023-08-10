import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/provider/fill_provider.dart';
import 'package:asmaa_demo_cadeau/provider/phone_form_provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneForm extends StatefulWidget {
  const PhoneForm({
    super.key,
    required this.hint,
  });

  final String hint;
  @override
  State<PhoneForm> createState() {
    return _PhoneFormState();
  }
}

String? _onValidate(String? value) {
  if (value == null ||
      value.trim().isEmpty ||
      !value.contains('1') ||
      value.length < 10) {
    return 'Please enter valid phone';
  }
  return null;
}

class _PhoneFormState extends State<PhoneForm> {
  late EnteredPhoneState phoneState;

  @override
  void initState() {
    super.initState();
    phoneState = context.read<EnteredPhoneState>();
  }

  void onChange(String value) {
    FillingState fillingState = context.read<FillingState>();

    if (value.trim().isNotEmpty) {
      fillingState.updateBoolFilledPhone(true);
      fillingState.updateBoolisFillingLogIn();
    } else {
      fillingState.updateBoolFilledPhone(false);
      fillingState.updateBoolisFillingLogIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Phone number",
              textAlign: TextAlign.left,
            )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: CountryCodePicker(
                searchDecoration: const InputDecoration(
                  label: Text("Add your country code"),
                ),
                onChanged: (countryCode) {
                  phoneState.updateCountryCode(countryCode.toString());
                },
                initialSelection: 'EG',
                favorite: const ['+20', 'EG'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                showFlag: false,
                showDropDownButton: true,
                alignLeft: true,
              ),
            ),
            Expanded(
              flex: 3,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(color: kGrey),
                ),
                keyboardType: TextInputType.number,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: _onValidate,
                onChanged: (value) {
                  onChange(value);
                },
                onSaved: (value) {
                  phoneState.updateEnteredPhone(value!);
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: kScreenWidth * 0.22,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kUnderLineBlack,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
