import 'package:flutter/material.dart';

class ReUseTextForm extends StatelessWidget {
  final String? inputName;
  final String textLabel;
  final TextEditingController textController;
  final bool isHidingText;

  final bool isShowPasswordBtn;
  final Function? onTogglePassword;

  const ReUseTextForm({
    super.key,
    required this.textController,
    required this.textLabel,
    required this.inputName,
    required this.isHidingText,
    this.isShowPasswordBtn = false,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    late String? _passwordInput;

    return Stack(
      children: [
        TextFormField(
          controller: textController,
          obscureText: isHidingText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
            border: const OutlineInputBorder(),
            labelText: textLabel,
            labelStyle: const TextStyle(color: Colors.white),
          ),

          // validator
          validator: (value) {
            if (inputName == "username") {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              } else if (value.length < 2) {
                return 'Username must be at least 6 characters';
              } else if (value.length > 10) {
                return 'Username must be less than 10 characters';
              }
              return null;
            } else if (inputName == "password") {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              } else if (value.length > 20) {
                return 'Password must be less than 20 characters';
              } else if (value.contains(' ')) {
                return 'Password must not contain spaces';
              }
              _passwordInput = value;

              return null;
            } else if (inputName == "email") {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email address';
              } else if (value.length > 50) {
                return 'Email must be less than 50 characters';
              }
              return null;
            }
          },
        ),

        // show password
        if (isShowPasswordBtn)
          Positioned(
              top: 5,
              right: 5,
              child: TextButton(
                onPressed: () {
                  onTogglePassword!();
                },
                child: Text(
                  isHidingText ? "Show" : "Hide",
                  style: const TextStyle(
                    color: Colors.orange,
                  ),
                ),
              )),
      ],
    );
  }
}
