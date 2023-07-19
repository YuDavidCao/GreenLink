import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  static Future<DocumentReference?> addPost(
      {required String userId,
      required String username,
      required String title,
      required String content,
      required DateTime time,
      required List<String> tags,
      required bool haveImage,
      required BuildContext context}) async {
    try {
      return await FirebaseFirestore.instance.collection("Post").add({
        "userId": userId,
        "username": username,
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
      print(e);
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

  static void deletePost(String docId, String documentUserEmail) async {
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
  }

  static void upvote(String userEmail, String docId) {
    FirebaseFirestore.instance.collection("Post").doc(docId).update({
      "upvoted": FieldValue.arrayUnion([userEmail]),
      "upvote": FieldValue.increment(1),
    });
  }

  static void cancelUpvote(String userEmail, String docId) {
    FirebaseFirestore.instance.collection("Post").doc(docId).update({
      "upvoted": FieldValue.arrayRemove([userEmail]),
      "upvote": FieldValue.increment(-1),
    });
  }

  static postComment(String postDocumentId, String content, String userEmail,
      DateTime time) async {
    await FirebaseFirestore.instance
        .collection("Comment")
        .doc(postDocumentId)
        .set({
      "postDocumentId": postDocumentId,
    });
    FirebaseFirestore.instance
        .collection("Comment")
        .doc(postDocumentId)
        .collection("Comment")
        .add({"content": content, "userEmail": userEmail, "time": time});
  }

  static void updatePostData(
      String documentId, String title, String content, bool haveImage) {
    FirebaseFirestore.instance.collection("Post").doc(documentId).update({
      "title": title,
      "content": content,
      "haveImage": haveImage,
    });
  }

  static void addUserData(String email, String username) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('User');
    DocumentSnapshot documentSnapshot =
        await collectionReference.doc(email).get();
    if (!documentSnapshot.exists) {
      collectionReference.doc(email).set({
        "email": email,
        "name": email.substring(0, 2).toUpperCase(),
      });
    }
  }

  static Future<void> updateUserName(String newName, String userEmail) async {
    FirebaseFirestore.instance
        .collection("User")
        .doc(userEmail)
        .update({"name": newName});
  }

  static Future<String> getUserName(String userEmail) async {
    String username = "unknown";
    try {
      username = (await FirebaseFirestore.instance
          .collection("User")
          .doc(userEmail)
          .get())["name"];
    } catch (e) {}
    return username;
  }
}
