import 'package:flutter/material.dart';
import 'package:solar_web/constants.dart';

class GlobalSearchBar extends StatefulWidget {
  const GlobalSearchBar({super.key});

  @override
  State<GlobalSearchBar> createState() => _GlobalSearchBarState();
}

class _GlobalSearchBarState extends State<GlobalSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.all(globalEdgePadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: thirtyUIColor, width: 5)),
        child: const TextField(
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 17),
            hintText: 'Share your experience!',
            suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(10, 14, 10, 14),
          ),
        ),
      ),
    );
  }
}
