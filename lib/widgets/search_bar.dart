import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/controller/post_state.dart';

class GlobalSearchBar extends StatefulWidget {
  const GlobalSearchBar({super.key});

  @override
  State<GlobalSearchBar> createState() => _GlobalSearchBarState();
}

class _GlobalSearchBarState extends State<GlobalSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(globalEdgePadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: thirtyUIColor, width: 3)),
      child: TextField(
        onSubmitted: (String searchTerm) {
          Provider.of<PostState>(context, listen: false).search(searchTerm, []);
        },
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 17),
          hintText: 'Search',
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(10, 14, 10, 14),
        ),
      ),
    );
  }
}
