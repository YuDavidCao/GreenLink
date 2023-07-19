import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_web/controller/user_state.dart';
import 'package:solar_web/firebase/firebase_firestore_service.dart';

class CommentForm extends StatefulWidget {
  final String documentId;
  final Function() cancelComment;
  const CommentForm(
      {super.key, required this.documentId, required this.cancelComment});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final TextEditingController commentController = TextEditingController();
  bool empty = false;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: commentController,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
          isDense: true,
          labelText: (!empty) ? 'Comment' : 'cannot be empty',
          labelStyle: (!empty) ? null : const TextStyle(color: Colors.red),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
              onPressed: () {
                if (commentController.text == "") {
                  setState(() {
                    empty = true;
                  });
                } else {
                  FirebaseFirestoreService.postComment(
                      widget.documentId,
                      commentController.text,
                      Provider.of<UserState>(context, listen: false).email,
                      DateTime.now());
                  widget.cancelComment();
                }
              },
              icon: const Icon(
                Icons.check,
                color: Colors.black,
              ))),
      onSubmitted: (String dummy) {
        if (commentController.text == "") {
          setState(() {
            empty = true;
          });
        } else {
          FirebaseFirestoreService.postComment(
              widget.documentId,
              commentController.text,
              Provider.of<UserState>(context, listen: false).email,
              DateTime.now());
          widget.cancelComment();
        }
      },
      keyboardType: TextInputType.multiline,
    );
  }
}
