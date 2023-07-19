import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solar_web/constants.dart';
import 'package:solar_web/controller/user_state.dart';

class GlobalDrawer extends StatefulWidget {
  final String currentPage;
  const GlobalDrawer({super.key, required this.currentPage});

  @override
  State<GlobalDrawer> createState() => _GlobalDrawerState();
}

class _GlobalDrawerState extends State<GlobalDrawer> {
  GestureDetector generateDrawerContainer(
      Function() funcion, String text, bool ifCurrent, IconData iconData) {
    return GestureDetector(
        onTap: funcion,
        child: Container(
          decoration: (ifCurrent)
              ? BoxDecoration(
                  // color: thirtyUIColor,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4)))
              : null,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: globalEdgePadding,
              ),
              Icon(
                iconData,
                color: tenUIColor,
                size: 30.0,
              ),
              const SizedBox(
                width: globalEdgePadding,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      generateDrawerContainer(() {
        Navigator.of(context).pushReplacementNamed(
          '/Home',
        );
      }, "Home", widget.currentPage == "Home", Icons.home),
      generateDrawerContainer(() {
        Navigator.of(context).pushReplacementNamed(
          '/Wind',
        );
      }, "Wind", widget.currentPage == "Wind", Icons.wind_power),
      generateDrawerContainer(() {
        Navigator.of(context).pushReplacementNamed(
          '/Solar',
        );
      }, "Solar", widget.currentPage == "Solar", Icons.solar_power),
      generateDrawerContainer(() {
        Navigator.of(context).pushReplacementNamed(
          '/Community',
        );
      }, "Community", widget.currentPage == "Community", Icons.people),
    ]));
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:solar_web/constants.dart';
// import 'package:solar_web/controller/user_state.dart';
// import 'package:solar_web/firebase/firebase_firestore_service.dart';
// import 'package:solar_web/widgets/change_profile_info_popup.dart';

// class GlobalDrawer extends StatefulWidget {
//   final double width;
//   final double height;
//   final String currentPage;
//   const GlobalDrawer(
//       {super.key,
//       required this.currentPage,
//       required this.width,
//       required this.height});

//   @override
//   State<GlobalDrawer> createState() => _GlobalDrawerState();
// }

// class _GlobalDrawerState extends State<GlobalDrawer> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   GestureDetector generateDrawerContainer(
//       Function() funcion, String text, bool ifCurrent, IconData iconData) {
//     return GestureDetector(
//         onTap: funcion,
//         child: Container(
//           decoration: (ifCurrent)
//               ? BoxDecoration(
//                   color: thirtyUIColor,
//                   border: Border.all(color: Colors.black, width: 1),
//                   borderRadius: const BorderRadius.all(Radius.circular(4)))
//               : null,
//           margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 width: globalEdgePadding,
//               ),
//               Icon(
//                 iconData,
//                 color: tenUIColor,
//                 size: 30.0,
//               ),
//               const SizedBox(
//                 width: globalEdgePadding,
//               ),
//               Text(
//                 text,
//                 style: TextStyle(
//                   fontSize: 17,
//                   color: (ifCurrent) ? Colors.white : Colors.black,
//                 ),
//               )
//             ],
//           ),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child:
//             Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//       generateDrawerContainer(() {
//         Navigator.of(context).pushReplacementNamed(
//           '/Home',
//         );
//       }, "Home", widget.currentPage == "Home", Icons.home),
//       generateDrawerContainer(() {
//         Navigator.of(context).pushReplacementNamed(
//           '/Wind',
//         );
//       }, "Wind", widget.currentPage == "Wind", Icons.wind_power),
//       generateDrawerContainer(() {
//         Navigator.of(context).pushReplacementNamed(
//           '/Solar',
//         );
//       }, "Solar", widget.currentPage == "Solar", Icons.solar_power),
//       generateDrawerContainer(() {
//         Navigator.of(context).pushReplacementNamed(
//           '/Community',
//         );
//       }, "Community", widget.currentPage == "Community", Icons.people),
//       GestureDetector(
//           onTap: () async {
//             changeProfileInfoPopup(
//                 context,
//                 widget.width,
//                 widget.height,
//                 formKey,
//                 await FirebaseFirestoreService.getUserName(
//                     Provider.of<UserState>(context, listen: false).email));
//           },
//           child: Container(
//             // decoration: (ifCurrent)
//             //     ? BoxDecoration(
//             //         color: thirtyUIColor,
//             //         border: Border.all(color: Colors.black, width: 1),
//             //         borderRadius: const BorderRadius.all(Radius.circular(4)))
//             //     : null,
//             margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: const [
//                 SizedBox(
//                   width: globalEdgePadding,
//                 ),
//                 Icon(
//                   Icons.person,
//                   color: tenUIColor,
//                   size: 30.0,
//                 ),
//                 SizedBox(
//                   width: globalEdgePadding,
//                 ),
//                 Text(
//                   "Change profile",
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 )
//               ],
//             ),
//           ))
//     ]));
//   }
// }
