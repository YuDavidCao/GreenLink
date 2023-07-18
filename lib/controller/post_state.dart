import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/controller/utilities.dart';

class PostState extends ChangeNotifier {
  StreamSubscription<QuerySnapshot>? _subscription;
  List<DocumentSnapshot> _loadedPost = [];
  bool _noMoreData = false;
  String _searchTerm = "";
  late Query<Map<String, dynamic>> _currentQuery;
  late String _sortedBy;
  late int _endPostIndex;
  late List<String> _tags;

  List<String> get tags => _tags;
  List<DocumentSnapshot> get loadedPost => _loadedPost;
  String get sortedBy => _sortedBy;

  PostState() {
    _currentQuery = FirebaseFirestore.instance
        .collection("Post")
        .orderBy('time', descending: true);
    _sortedBy = "time";
    _tags = [];
    onInitPostPage();
    resetSearchCondition();
  }

  void search(String searchTerm, List<String> tags) async {
    if (searchTerm == _searchTerm && const ListEquality().equals(tags, _tags)) {
      return;
    }
    _searchTerm = searchTerm;
    _tags = List.from(tags);
    if (searchTerm == "" && tags.isEmpty) {
      _noMoreData = false;
      onInitPostPage();
      return;
    }
    _subscription?.cancel();
    _endPostIndex = paginationConstant;
    _noMoreData = false;
    _loadedPost = [];
    const int currentSearchPaginationValue =
        paginationConstant * searchPaginationMultiplier;
    List<DocumentSnapshot> additionalData;
    while (_loadedPost.length != _endPostIndex && !_noMoreData) {
      if (_loadedPost.isEmpty) {
        additionalData =
            (await _currentQuery.limit(currentSearchPaginationValue).get())
                .docs;
        filterData(additionalData, currentSearchPaginationValue);
      } else {
        if (_sortedBy == "time") {
          additionalData = (await _currentQuery
                  .startAfter([_loadedPost.last["time"].toDate()])
                  .limit(currentSearchPaginationValue)
                  .get())
              .docs;
          filterData(additionalData, currentSearchPaginationValue);
        } else if (_sortedBy == "upvote") {
          additionalData = (await _currentQuery
                  .startAfter([
                    _loadedPost.last["upvote"],
                    loadedPost.last["time"].toDate()
                  ])
                  .limit(currentSearchPaginationValue)
                  .get())
              .docs;
          filterData(additionalData, currentSearchPaginationValue);
        }
      }
    }
    notifyListeners();
  }

  void filterData(
      List<DocumentSnapshot> additionalData, int currentSearchPaginationValue) {
    for (int i = 0; i < additionalData.length; i++) {
      if ((additionalData[i]["title"].contains(_searchTerm) ||
              additionalData[i]["content"].contains(_searchTerm)) &&
          ((_tags.isEmpty) ||
              (Utilities.arrayContain(
                  List<String>.from(additionalData[i]["tags"]), _tags)))) {
        _loadedPost.add(additionalData[i]);
        if (_loadedPost.length == _endPostIndex) {
          return;
        }
      }
    }
    if (additionalData.length < currentSearchPaginationValue) {
      _noMoreData = true;
    }
  }

  void changeQuery(
      Query<Map<String, dynamic>> newQuery, String sortedBy) async {
    if (sortedBy != _sortedBy) {
      _endPostIndex = paginationConstant;
      _currentQuery = newQuery;
      _sortedBy = sortedBy;
      _noMoreData = false;
      listenToStream();
    }
  }

  void listenToStream() {
    _subscription?.cancel();
    _subscription =
        _currentQuery.limit(_endPostIndex).snapshots().listen((snapshot) {
      _loadedPost = snapshot.docs;
      notifyListeners();
    });
  }

  void loadMore(BuildContext context) async {
    if (!_noMoreData) {
      List<DocumentSnapshot> additionalData;
      _endPostIndex += paginationConstant;
      if (_searchTerm == "" && _tags.isEmpty) {
        if (_sortedBy == "time") {
          List<DocumentSnapshot> additionalData = (await _currentQuery
                  .startAfter([_loadedPost.last["time"].toDate()])
                  .limit(paginationConstant)
                  .get())
              .docs;
          _loadedPost += additionalData;
          if (additionalData.isEmpty) {
            _noMoreData = true;
          }
        } else if (_sortedBy == "upvote") {
          additionalData = (await _currentQuery
                  .startAfter([
                    _loadedPost.last["upvote"],
                    loadedPost.last["time"].toDate()
                  ])
                  .limit(paginationConstant)
                  .get())
              .docs;
          _loadedPost += additionalData;
          if (additionalData.isEmpty) {
            _noMoreData = true;
          }
        }
        notifyListeners();
        listenToStream();
      } else {
        const int currentSearchPaginationValue =
            paginationConstant * searchPaginationMultiplier;
        while (_loadedPost.length != _endPostIndex && !_noMoreData) {
          if (_loadedPost.isEmpty) {
            additionalData =
                (await _currentQuery.limit(currentSearchPaginationValue).get())
                    .docs;
            filterData(additionalData, currentSearchPaginationValue);
          } else {
            if (_sortedBy == "time") {
              additionalData = (await _currentQuery
                      .startAfter([_loadedPost.last["time"].toDate()])
                      .limit(currentSearchPaginationValue)
                      .get())
                  .docs;
              filterData(additionalData, currentSearchPaginationValue);
            } else if (_sortedBy == "upvote") {
              additionalData = (await _currentQuery
                      .startAfter([
                        _loadedPost.last["upvote"],
                        loadedPost.last["time"].toDate()
                      ])
                      .limit(currentSearchPaginationValue)
                      .get())
                  .docs;
              filterData(additionalData, currentSearchPaginationValue);
            }
          }
        }
        notifyListeners();
        _subscription?.cancel();
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('That\'s all')));
    }
  }

  void postFrameTrigger() {
    _endPostIndex = paginationConstant;
    _noMoreData = false;
  }

  void onInitPostPage() {
    _endPostIndex = paginationConstant;
    listenToStream();
  }

  void resetSearchCondition() {
    _searchTerm = "";
    _tags = [];
  }
}
