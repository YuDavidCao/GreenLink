import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/controller/post_state.dart';
import 'package:solar_web/controller/time_ticking_state.dart';
import 'package:solar_web/controller/user_state.dart';
import 'package:solar_web/controller/utilities.dart';
import 'package:solar_web/firebase/firebase_firestore_service.dart';
import 'package:solar_web/widgets/debugging_layout_widget.dart';
import 'package:solar_web/widgets/global_app_bar.dart';
import 'package:solar_web/widgets/loading_screen.dart';
import 'package:solar_web/widgets/login_widget.dart';
import 'package:solar_web/widgets/search_bar.dart';
import 'package:solar_web/widgets/upvote_button.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<UserState>(context, listen: false).user == null) {
        popupForm(context, MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height, formKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool onMobile = width < height;
    if (!onMobile) {
      return Scaffold(
        appBar: globalAppBar(width, onMobile, context),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(flex: 1, child: SizedBox()),
            Flexible(
              flex: 4,
              child: ListView(
                children: [
                  const GlobalSearchBar(),
                  // const Divider(
                  //   thickness: 5,
                  //   color: tenUIColor,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 2 / 3,
                        child: Column(
                          children: [
                            Consumer2<UserState, PostState>(builder: (context,
                                UserState userState,
                                PostState postState,
                                child) {
                              // print(postState.loadedPost.length);
                              if (userState.user != null) {
                                return Column(
                                  children: postState.loadedPost.mapIndexed(
                                      (int index, DocumentSnapshot data) {
                                    // return Text("1");
                                    return PostCard(
                                      documentId: data.id,
                                      title: data['title'],
                                      content: data['content'],
                                      time: data['time'].toDate(),
                                      currentUserEmail: userState.email,
                                      documentUserEmail: data['userId'],
                                      tags: data["tags"],
                                      upvote: data['upvote'],
                                      colorFlag: index % 2 == 0,
                                      alreadyUpvoted:
                                          List<String>.from(data['upvoted'])
                                              .contains(userState.email),
                                    );
                                  }).toList(),
                                );
                              } else {
                                return ElevatedButton(
                                    onPressed: () {
                                      popupForm(
                                          context, width, height, formKey);
                                    },
                                    child: const Text(
                                        "Please login or sign up first"));
                              }
                            }),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 5,
                        color: tenUIColor,
                      ),
                      Column(
                        children: [],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Flexible(flex: 1, child: SizedBox()),
          ],
        ),
        floatingActionButton: FloatingActionButton.large(onPressed: () {
          // popupForm(context, width, height, formKey);
          FirebaseFirestoreService.addPost(
              Provider.of<UserState>(context, listen: false).id,
              "Test title",
              "Test content",
              DateTime.now(),
              [],
              false,
              context);
        }),
      );
    } else {
      return const Placeholder();
    }
  }
}

class PostCard extends StatelessWidget {
  final String title;
  final String content;
  final String currentUserEmail;
  final String documentUserEmail;
  final DateTime time;
  final String documentId;
  final int upvote;
  final List<dynamic> tags;
  final bool alreadyUpvoted;
  final bool colorFlag;

  const PostCard(
      {Key? key,
      required this.documentId,
      required this.title,
      required this.content,
      required this.time,
      required this.currentUserEmail,
      required this.documentUserEmail,
      required this.upvote,
      required this.tags,
      required this.colorFlag,
      required this.alreadyUpvoted})
      : super(key: key);

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
        FirebaseFirestoreService.deletePost(documentId, documentUserEmail);
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
    return Container(
      padding: const EdgeInsets.all(globalEdgePadding),
      decoration: BoxDecoration(
        color: colorFlag ? Color(0xFFf7f7e6) : Color(0xFFe8e8e3),
      ),
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
                      text: "$documentUserEmail ",
                    ),
                  ),
                  Consumer<TimeTickingState>(
                    builder:
                        (context, TimeTickingState timeTickingState, child) {
                      return Text(
                        " ${Utilities.convertToTimeAgo(time)}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: globalMarginPadding,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                content,
                style: const TextStyle(height: 1.5),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //testing - Text(widget.upvote.toString()),
                  IconButton(
                      onPressed: () async {
                        //TODO duplictate getPostImageUrl
                        Navigator.of(context).pushNamed(
                          '/PostDetailPage',
                          arguments: [
                            title,
                            content,
                            tags,
                            documentId,
                            documentUserEmail,
                            currentUserEmail,
                            time,
                            alreadyUpvoted,
                          ],
                        );
                      },
                      icon: const Icon(
                        Icons.chat_bubble_outline,
                      )),
                  UpvoteButton(
                      key: UniqueKey(),
                      alreadyUpvoted: alreadyUpvoted,
                      documentId: documentId,
                      currentUserEmail: currentUserEmail),
                  if (documentUserEmail == currentUserEmail)
                    IconButton(
                        onPressed: () async {
                          Navigator.of(context).pushNamed(
                            '/EditingPostPage',
                            arguments: [
                              title,
                              content,
                              tags,
                              documentId,
                            ],
                          );
                        },
                        icon: const Icon(
                          Icons.mode_edit_outlined,
                        )),
                  if (documentUserEmail == currentUserEmail)
                    IconButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                        )),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
