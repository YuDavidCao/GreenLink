import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/controller/adding_state.dart';
import 'package:solar_web/controller/user_state.dart';
import 'package:solar_web/firebase/firebase_firestore_service.dart';

class PostForm extends StatefulWidget {
  const PostForm({super.key});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(globalEdgePadding),
      margin: const EdgeInsets.all(globalEdgePadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: thirtyUIColor, width: 3)),
      child: Stack(
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Title',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.multiline,
                  validator: (val) => val!.isEmpty ? 'Cannot be blank' : null,
                ),
                SizedBox(
                  height: 100,
                  child: TextFormField(
                    controller: contentController,
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'Content',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.multiline,
                    validator: (val) => val!.isEmpty ? 'Cannot be blank' : null,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Provider.of<AddingState>(context, listen: false).onPosting =
                        false;
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: globalEdgePadding,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    FirebaseFirestoreService.addPost(
                        userId: Provider.of<UserState>(context, listen: false)
                            .email,
                        title: titleController.text,
                        content: contentController.text,
                        username: await FirebaseFirestoreService.getUserName(
                            Provider.of<UserState>(context, listen: false)
                                .email),
                        time: DateTime.now(),
                        tags: [],
                        haveImage: false,
                        context: context);
                    if (mounted) {
                      Provider.of<AddingState>(context, listen: false)
                          .onPosting = false;
                    }
                  },
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
