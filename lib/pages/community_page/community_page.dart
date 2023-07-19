import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_web/controller/adding_state.dart';
import 'package:solar_web/controller/post_state.dart';
import 'package:solar_web/controller/user_state.dart';
import 'package:solar_web/pages/community_page/post_card.dart';
import 'package:solar_web/pages/community_page/post_form.dart';
import 'package:solar_web/widgets/global_app_bar.dart';
import 'package:solar_web/widgets/login_widget.dart';
import 'package:solar_web/widgets/search_bar.dart';

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
        appBar: globalAppBar(width, onMobile, context, height),
        body: Center(
          child: SizedBox(
            width: width * 2 / 3,
            child: ListView(
              children: [
                const GlobalSearchBar(),
                // const Divider(
                //   thickness: 5,
                //   color: tenUIColor,
                // ),
                Consumer<AddingState>(
                  builder: (context, AddingState addingState, child) {
                    if (addingState.onPosting) {
                      return const PostForm();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Consumer2<UserState, PostState>(builder:
                    (context, UserState userState, PostState postState, child) {
                  // print(postState.loadedPost.length);
                  if (userState.user != null) {
                    return Column(
                        children: postState.loadedPost
                            .mapIndexed((int index, DocumentSnapshot data) {
                      // return Text("1");
                      return PostCard(
                        key: UniqueKey(),
                        documentId: data.id,
                        title: data['title'],
                        documentUserName: data["username"],
                        content: data['content'],
                        time: data['time'].toDate(),
                        currentUserEmail: userState.email,
                        documentUserEmail: data['userId'],
                        tags: data["tags"],
                        upvote: data['upvote'],
                        colorFlag: index % 2 == 0,
                        alreadyUpvoted: List<String>.from(data['upvoted'])
                            .contains(userState.email),
                      );
                    }).toList());
                  } else {
                    return ElevatedButton(
                        onPressed: () {
                          popupForm(context, width, height, formKey);
                        },
                        child: const Text("Please login or sign up first"));
                  }
                }),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            if (Provider.of<UserState>(context, listen: false).user != null) {
              Provider.of<AddingState>(context, listen: false).onPosting = true;
            } else {
              final GlobalKey<FormState> formKey = GlobalKey<FormState>();
              popupForm(context, width, height, formKey);
            }
            // popupForm(context, width, height, formKey);
            // FirebaseFirestoreService.addPost(
            //     Provider.of<UserState>(context, listen: false).email,
            //     "Test title",
            //     "Test content",
            //     DateTime.now(),
            //     [],
            //     false,
            //     context);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return const Placeholder();
    }
  }
}
