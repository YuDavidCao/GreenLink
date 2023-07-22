import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:GreenLink/constants.dart';
import 'package:GreenLink/controller/time_ticking_state.dart';
import 'package:GreenLink/controller/utilities.dart';
import 'package:GreenLink/firebase/firebase_firestore_service.dart';
import 'package:GreenLink/pages/community_page/comment_form.dart';
import 'package:GreenLink/pages/community_page/edit_form.dart';
import 'package:GreenLink/widgets/loading_screen.dart';
import 'package:GreenLink/widgets/upvote_button.dart';

class PostCard extends StatefulWidget {
  final String title;
  final String content;
  final String documentUserName;
  final String currentUserEmail;
  final String documentUserEmail;
  final DateTime time;
  final String documentId;
  final int upvote;
  final List<dynamic> tags;
  final bool alreadyUpvoted;
  final bool colorFlag;
  final bool onMobile;

  const PostCard(
      {Key? key,
      required this.onMobile,
      required this.documentId,
      required this.title,
      required this.content,
      required this.time,
      required this.documentUserName,
      required this.currentUserEmail,
      required this.documentUserEmail,
      required this.upvote,
      required this.tags,
      required this.colorFlag,
      required this.alreadyUpvoted})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool onComment = false;
  bool onEdit = false;

  //TODO -> Duplicated code
  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        FirebaseFirestoreService.deletePost(
            widget.documentId, widget.documentUserEmail);
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure you want to delete the post?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onEdit) {
      return EditForm(
        documentId: widget.documentId,
        title: widget.title,
        content: widget.content,
        cancelEditing: () {
          setState(() {
            onEdit = false;
          });
        },
      );
    } else {
      return Container(
        padding: (!widget.onMobile)
            ? const EdgeInsets.all(globalEdgePadding)
            : const EdgeInsets.fromLTRB(globalEdgePadding, globalMarginPadding,
                globalEdgePadding, globalMarginPadding),
        margin: (!widget.onMobile)
            ? const EdgeInsets.all(globalEdgePadding)
            : const EdgeInsets.fromLTRB(globalEdgePadding, globalMarginPadding,
                globalEdgePadding, globalMarginPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: thirtyUIColor, width: 3)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.indigo,
                        ),
                        text: "${widget.documentUserName} ",
                      ),
                    ),
                    Consumer<TimeTickingState>(
                      builder:
                          (context, TimeTickingState timeTickingState, child) {
                        return Text(
                          " ${Utilities.convertToTimeAgo(widget.time)}",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: globalMarginPadding,
                ),
                SelectableText(
                  widget.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SelectableText(
                  widget.content,
                  style: const TextStyle(height: 1.5),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //testing - Text(widget.upvote.toString()),
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            onComment = !onComment;
                          });
                        },
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                        )),
                    UpvoteButton(
                        key: UniqueKey(),
                        upvote: widget.upvote,
                        alreadyUpvoted: widget.alreadyUpvoted,
                        documentId: widget.documentId,
                        currentUserEmail: widget.currentUserEmail),
                    if (widget.documentUserEmail == widget.currentUserEmail)
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              onEdit = !onEdit;
                            });
                          },
                          icon: const Icon(
                            Icons.mode_edit_outlined,
                          )),
                    if (widget.documentUserEmail == widget.currentUserEmail)
                      IconButton(
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                          )),
                  ],
                ),
                if (onComment)
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Comment')
                        .doc(widget.documentId)
                        .collection("Comment")
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingScreen();
                      }
                      return Column(
                        children: [
                          ...snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Column(
                              children: [
                                const Divider(
                                  thickness: 2,
                                  color: thirtyUIColor,
                                ),
                                CommentCard(
                                  content: data['content'],
                                  postDocumentId: widget.documentId,
                                  currentUserEmail: widget.currentUserEmail,
                                  documentUserEmail: data['userEmail'],
                                  documentId: document.id,
                                ),
                              ],
                            );
                          }).toList(),
                          CommentForm(
                            documentId: widget.documentId,
                            cancelComment: () {
                              setState(() {
                                onComment = false;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  )
              ],
            ),
          ),
        ]),
      );
    }
  }
}

class CommentCard extends StatelessWidget {
  final String content;
  final String postDocumentId;
  final String currentUserEmail;
  final String documentId;
  final String documentUserEmail;
  const CommentCard(
      {required this.content,
      required this.postDocumentId,
      required this.currentUserEmail,
      required this.documentId,
      required this.documentUserEmail,
      super.key});

  //TODO -> Duplicated code
  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        FirebaseFirestoreService.deleteComment(postDocumentId, documentId);
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure you want to delete the comment?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Text(content),
            ),
          ),
          if (documentUserEmail == currentUserEmail)
            IconButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                icon: const Icon(
                  Icons.delete_outline,
                ))
        ],
      ),
    );
  }
}
