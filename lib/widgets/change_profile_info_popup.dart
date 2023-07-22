import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/controller/user_state.dart';
import 'package:solar_web/firebase/firebase_auth_service.dart';
import 'package:solar_web/firebase/firebase_firestore_service.dart';

void changeProfileInfoPopup(BuildContext context, double width, double height,
    GlobalKey<FormState> formKey, String username) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoginDialog(
          width: width,
          height: height,
          formKey: formKey,
          username: username,
        );
      });
}

class LoginDialog extends StatefulWidget {
  const LoginDialog({
    super.key,
    required this.width,
    required this.height,
    required this.formKey,
    required this.username,
  });

  final double width;
  final double height;
  final GlobalKey<FormState> formKey;
  final String username;

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    usernameController.text = widget.username;
    super.initState();
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
                  "Account Info",
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Enter a new username:"),
                ),
                TextFormField(
                  controller: usernameController,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                      isDense: true, border: OutlineInputBorder()),
                  keyboardType: TextInputType.multiline,
                  validator: (val) => val!.isEmpty ? 'Cannot be blank' : null,
                ),
                const SizedBox(
                  height: globalEdgePadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.formKey.currentState!.validate()) {
                        await FirebaseFirestoreService.updateUserName(
                            usernameController.text,
                            Provider.of<UserState>(context, listen: false)
                                .email);
                        if (mounted) {
                          Navigator.pop(context);
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
                const SizedBox(
                  height: globalEdgePadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      await FirebaseAuthService.deleteUser();
                      if (mounted) {
                        Navigator.pop(context);
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
                        "Delete account",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize:
                                    (widget.width > widget.height) ? 18.5 : 15,
                                color: Colors.white)),
                      ),
                    ),
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

// showAlertDialog(BuildContext context) {
//   Widget cancelButton = TextButton(
//     child: const Text("Cancel"),
//     onPressed: () {
//       Navigator.pop(context);
//     },
//   );
//   Widget continueButton = TextButton(
//     child: const Text("Yes"),
//     onPressed: () async {
//       await FirebaseAuthService.deleteUser();
//       if (context.mounted) {
//         Navigator.pop(context);
//       }
//     },
//   );
//   AlertDialog alert = AlertDialog(
//     content: const Text("Are you sure you want to delete your account?"),
//     actions: [
//       cancelButton,
//       continueButton,
//     ],
//   );
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
