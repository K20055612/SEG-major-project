import 'package:flutter/material.dart';

import '../../constants.dart';

/// Password repeat field used in the sign-up form.
class PasswordRepeatField extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;

  const PasswordRepeatField(
      this.passwordController, this.repeatPasswordController,
      {Key? key})
      : super(key: key);

  @override
  PasswordRepeatFieldState createState() {
    return PasswordRepeatFieldState();
  }
}

class PasswordRepeatFieldState extends State<PasswordRepeatField> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Password must have at least 8 characters including 1 number, 1 "
          "letter and 1 special character [@\$!%*#?&]",
      decoration: kFormFieldTooltipDecoration,
      textStyle: kFormFieldTooltipTextStyle,
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: widget.repeatPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please repeat your password';
          }
          if (!(widget.repeatPasswordController.text ==
              widget.passwordController.text)) {
            return 'Passwords do not match';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: kTextFieldDecoration.copyWith(
          icon: const Icon(Icons.spellcheck),
          labelText: 'Repeat password',
          hintText: 'Repeat your password',
        ),
      ),
    );
  }
}