import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  static Future<DocumentReference?> addPost(
      String userId,
      String title,
      String content,
      DateTime time,
      List<String> tags,
      bool haveImage,
      BuildContext context) async {
    try {
      return await FirebaseFirestore.instance.collection("Post").add({
        "userId": userId,
        "title": title,
        "content": content,
        "time": time.toUtc(),
        "tags": tags,
        "upvote": 0,
        "haveImage": haveImage,
        "upvoted": <String>[],
      });
    } catch (e) {
      //testing print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload the post')));
      return null;
    }
  }

  static void deleteComment(String postDocumentId, String documentId) {
    FirebaseFirestore.instance
        .collection("Comment")
        .doc(postDocumentId)
        .collection("Comment")
        .doc(documentId)
        .delete();
  }

    static void deletePost(
      String docId, String documentUserEmail, bool haveImage) async {
    FirebaseFirestore.instance.collection("Post").doc(docId).delete();
    final snapshot = await FirebaseFirestore.instance
        .collection("Comment")
        .doc(docId)
        .collection("Comment")
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    FirebaseFirestore.instance.collection("Comment").doc(docId).delete();
    if (haveImage) {
      FirebaseStorage.instance
          .ref()
          .child("image/Post/$docId/$documentUserEmail")
          .delete();
    }
  }
}