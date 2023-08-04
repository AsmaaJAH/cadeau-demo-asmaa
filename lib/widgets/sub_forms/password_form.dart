import 'package:asmaa_demo_cadeau/functions/bonus_content_checker.dart';
import 'package:asmaa_demo_cadeau/provider/bonus_task_provider.dart';
import 'package:asmaa_demo_cadeau/provider/fill_provider.dart';
import 'package:asmaa_demo_cadeau/provider/passward_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    super.key,
    required this.label,
    required this.hint,
    required this.isConfirmingPassword,
    required this.isSettingNewPass,
  });
  final String label;
  final String hint;
  final bool isConfirmingPassword;
  final bool isSettingNewPass;

  @override
  State<PasswordForm> createState() {
    return _PasswordFormState();
  }
}

class _PasswordFormState extends State<PasswordForm> {
  var _obscurePassword = true;
  var _isContentChecked = false;
  var _isLengthChecked = false;

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _onSave(String? value) {
    var passState = context.read<EnteredPasswordState>();
    var bonusState = context.read<BonusCheckerState>();
    if (widget.isConfirmingPassword) {
      passState.updateConfirmedPassword(value!);
    } else {
      passState.updateEnteredPassword(value!);
    }
    //reset the bonus Flags:
    bonusState.updateBoolContentChecked(false);
    bonusState.updateBoolLengthChecked(false);
  }

  void _onChange(String value) {
    var bonusState = context.read<BonusCheckerState>();
    var fillState = context.read<FillingState>();
    if (!widget.isConfirmingPassword && widget.isSettingNewPass) {
      //------------------- is checked: ( the bonus task) ----------------------

      if (value.length >= 8 && value.length <= 20) {
        bonusState.updateBoolLengthChecked(true);
      } else {
        bonusState.updateBoolLengthChecked(false);
      }
      //debugPrint(checkPasswordContent(value).toString());

      if (checkPasswordContent(value)) {
        debugPrint(checkPasswordContent(value).toString());
        bonusState.updateBoolContentChecked(true);
      } else {
        //debugPrint(checkPasswordContent(value).toString());

        bonusState.updateBoolContentChecked(false);
      }
    }

    //----------------------    is filled: ------------------------------------------------
    if (value.trim().isNotEmpty) {
      if (!widget.isConfirmingPassword) {
        fillState.updateBoolFilledPassword(true);
      } else {
        fillState.updateBoolFilledConfirmationPassword(true);
      }
    } else {
      if (!widget.isConfirmingPassword) {
        fillState.updateBoolFilledPassword(false);
      } else {
        fillState.updateBoolFilledConfirmationPassword(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String? onValidate(String? value) {
      _isContentChecked = context.read<BonusCheckerState>().isContentChecked;
      _isLengthChecked = context.read<BonusCheckerState>().isContentChecked;
      if (!widget.isConfirmingPassword &&
          (value == null ||
              value.trim().length < 8 ||
              value.trim().length > 20 ||
              (widget.isSettingNewPass &&
                  (!_isContentChecked || !_isLengthChecked)))) {
        return 'Passward must be vaild with at least 8 chars long.';
      } else if (!widget.isConfirmingPassword &&
          widget.isSettingNewPass &&
          value != null &&
          value.trim().length >= 8 &&
          value.trim().length <= 20 &&
          _isContentChecked &&
          _isLengthChecked) {
        context.read<EnteredPasswordState>().updateEnteredPassword(value);
      }

      //-------------------- my Bonus validator to hundle a very specific case (hide confirm pass validotar if user clicked done without kept restricted to the bonus validators)-----------------------------------

      if (widget.isConfirmingPassword &&
          widget.isSettingNewPass &&
          (value != context.read<EnteredPasswordState>().enteredPassword)) {
        return 'Confirm-passward must match your above password.';
      }

      return null;
    }

    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: IconButton(
          onPressed: _toggle,
          icon: _obscurePassword
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      obscureText: _obscurePassword,
      obscuringCharacter: '*',
      validator: onValidate,
      onChanged: (value) {
        _onChange(value);
      },
      onSaved: (value) {
        _onSave(value);
      },
    );
  }
}
