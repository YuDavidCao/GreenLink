import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/firebase/firebase_firestore_service.dart';

class EditForm extends StatefulWidget {
  final String title;
  final String content;
  final String documentId;
  final Function cancelEditing;
  const EditForm(
      {super.key,
      required this.title,
      required this.content,
      required this.documentId,
      required this.cancelEditing});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = widget.title;
    contentController.text = widget.content;
    super.initState();
  }

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
                    widget.cancelEditing();
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
                  onPressed: () {
                    FirebaseFirestoreService.updatePostData(
                        widget.documentId, widget.title, widget.content, false);
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
