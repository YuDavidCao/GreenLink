import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';

void popupForm(BuildContext context, double width, double height,
    GlobalKey<FormState> formKey) {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoginDialog(
            width: width,
            height: height,
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController);
      });
}

class LoginDialog extends StatefulWidget {
  const LoginDialog({
    super.key,
    required this.width,
    required this.height,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final double width;
  final double height;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  bool failed = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: EdgeInsets.fromLTRB(
            globalEdgePadding,
            (widget.width > widget.height) ? globalEdgePadding : 0,
            globalEdgePadding,
            (widget.width > widget.height) ? globalEdgePadding : 0),
        child: SizedBox(
          height: max(widget.height / 2, 500),
          width: max(widget.width / 4, 600),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                SelectableText(
                  "Login",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: (widget.width > widget.height) ? 30 : 18.5,
                          height: 2)),
                ),
                (widget.width > widget.height)
                    ? const SizedBox(
                        height: globalEdgePadding,
                      )
                    : const SizedBox(),
                TextFormField(
                  controller: widget.emailController,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Email: ',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.multiline,
                  validator: (val) => val!.isEmpty ? 'Cannot be blank' : null,
                ),
                SizedBox(
                  width: 1,
                  height: (widget.width > widget.height)
                      ? globalEdgePadding
                      : globalMarginPadding,
                ),
                TextFormField(
                  controller: widget.passwordController,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'password: ',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.multiline,
                  validator: (val) => val!.isEmpty ? 'Cannot be blank' : null,
                ),
                SizedBox(
                  width: 1,
                  height: (widget.width > widget.height)
                      ? globalEdgePadding
                      : globalMarginPadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.formKey.currentState!.validate()) {
                        if (await _loginWithEmailAndPassword(
                            context,
                            widget.emailController.text,
                            widget.passwordController.text)) {
                          Navigator.of(context).pop();
                        } else {
                          setState(() {
                            failed = true;
                          });
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          globalEdgePadding,
                          (widget.width > widget.height)
                              ? globalEdgePadding
                              : 0,
                          globalEdgePadding,
                          (widget.width > widget.height)
                              ? globalEdgePadding
                              : 0),
                      child: Text(
                        "Submit",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize:
                                    (widget.width > widget.height) ? 18.5 : 15,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                if (failed)
                  const Text(
                    "Login Failed",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _loginWithEmailAndPassword(
    BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Successful login, you can navigate to the next screen or do any other logic here.
  } catch (e) {
    // Handle login errors (e.g., invalid credentials, user not found, etc.)
    print('Error: $e');
    // You can show a snackbar, alert dialog, or any other error handling UI here.
  }
  return FirebaseAuth.instance.currentUser != null;
}
