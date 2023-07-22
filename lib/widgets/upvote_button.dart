import 'package:flutter/material.dart';
import 'package:GreenLink/firebase/firebase_firestore_service.dart';

class UpvoteButton extends StatefulWidget {
  final bool alreadyUpvoted;
  final int upvote;
  final String documentId;
  final String currentUserEmail;
  const UpvoteButton(
      {required this.alreadyUpvoted,
      required this.upvote,
      required this.documentId,
      required this.currentUserEmail,
      super.key});

  @override
  State<UpvoteButton> createState() => _UpvoteButtonState();
}

class _UpvoteButtonState extends State<UpvoteButton> {
  late bool alreadyUpvoted;

  @override
  void initState() {
    super.initState();
    alreadyUpvoted = widget.alreadyUpvoted;
  }

  @override
  Widget build(BuildContext context) {
    if (!alreadyUpvoted) {
      return Row(
        children: [
          IconButton(
              onPressed: () {
                FirebaseFirestoreService.upvote(
                    widget.currentUserEmail, widget.documentId);
                setState(() {
                  alreadyUpvoted = true;
                });
              },
              icon: const Icon(
                Icons.thumb_up_outlined,
              )),
          Text(widget.upvote.toString())
        ],
      );
    } else {
      return Row(
        children: [
          IconButton(
              onPressed: () {
                FirebaseFirestoreService.cancelUpvote(
                    widget.currentUserEmail, widget.documentId);
                setState(() {
                  alreadyUpvoted = false;
                });
              },
              icon: const Icon(
                Icons.thumb_up,
              )),
          Text(widget.upvote.toString())
        ],
      );
    }
  }
}
