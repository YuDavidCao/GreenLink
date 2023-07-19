import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_web/constants.dart';

void changeProfileInfoPopup(BuildContext context, double width, double height,
    GlobalKey<FormState> formKey, String username) async {
  final TextEditingController usernameController = TextEditingController();
  usernameController.text = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoginDialog(
          width: width,
          height: height,
          formKey: formKey,
          usernameController: usernameController,
        );
      });
  usernameController.dispose();
}

class LoginDialog extends StatefulWidget {
  const LoginDialog({
    super.key,
    required this.width,
    required this.height,
    required this.formKey,
    required this.usernameController,
  });

  final double width;
  final double height;
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
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
                TextFormField(
                  controller: widget.usernameController,
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
                        //TODO
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
                      //TODO
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
