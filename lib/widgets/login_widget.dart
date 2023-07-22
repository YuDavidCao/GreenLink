import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:GreenLink/constants.dart';
import 'package:GreenLink/controller/user_state.dart';
import 'package:GreenLink/firebase/firebase_auth_service.dart';

void popupForm(BuildContext context, double width, double height,
    GlobalKey<FormState> formKey) async {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoginDialog(
          width: width,
          height: height,
          formKey: formKey,
          emailController: emailController,
          passwordController: passwordController,
          repeatPasswordController: repeatPasswordController,
        );
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
    required this.repeatPasswordController,
  });

  final double width;
  final double height;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  bool failed = false;
  bool login = true;

  @override
  void dispose() {
    widget.repeatPasswordController.dispose();
    widget.passwordController.dispose();
    widget.emailController.dispose();
    super.dispose();
  }

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
                  (login) ? "Login" : "Sign up",
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
                  onFieldSubmitted: (String a) {
                    loginHelper(widget.formKey, widget.emailController.text,
                        widget.passwordController.text, login, context);
                  },
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
                  onFieldSubmitted: (String a) {
                    loginHelper(widget.formKey, widget.emailController.text,
                        widget.passwordController.text, login, context);
                  },
                ),
                if (!login)
                  SizedBox(
                    width: 1,
                    height: (widget.width > widget.height)
                        ? globalEdgePadding
                        : globalMarginPadding,
                  ),
                if (!login)
                  TextFormField(
                    controller: widget.repeatPasswordController,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'repeat your password',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.multiline,
                    onFieldSubmitted: (String a) {
                      loginHelper(widget.formKey, widget.emailController.text,
                          widget.passwordController.text, login, context);
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Cannot be blank';
                      } else if (widget.passwordController.text !=
                          widget.repeatPasswordController.text) {
                        return 'Password doesn\'t match';
                      }
                      return null;
                    },
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
                    onPressed: () {
                      loginHelper(widget.formKey, widget.emailController.text,
                          widget.passwordController.text, login, context);
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
                const SizedBox(
                  height: globalEdgePadding,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      login = !login;
                    });
                  },
                  child: Text((login)
                      ? "Don't have an account? Sign up here!"
                      : "Already have an account? Log in here!"),
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

void loginHelper(GlobalKey<FormState> formKey, String email, String password,
    bool login, BuildContext context) async {
  if (formKey.currentState!.validate()) {
    if (login) {
      bool successful = await FirebaseAuthService.loginWithEmailAndPassword(
          context, email, password);
      if (context.mounted && successful) {
        Navigator.pop(context);
      }
    } else {
      bool successful = await FirebaseAuthService.signupWithEmailAndPassword(
          context, email, password);
      if (context.mounted && successful) {
        Navigator.pop(context);
      }
    }
  }
}
