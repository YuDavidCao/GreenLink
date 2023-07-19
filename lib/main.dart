import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solar_web/controller/adding_state.dart';
import 'package:solar_web/controller/post_state.dart';
import 'package:solar_web/controller/time_ticking_state.dart';
import 'package:solar_web/controller/user_state.dart';
import 'package:solar_web/firebase_options.dart';
import 'package:solar_web/pages/community_page/community_page.dart';
import 'package:solar_web/pages/home_page/home_page.dart';
import 'package:solar_web/pages/wind_page/wind_page.dart';
import 'pages.dart';


//! file solar_hero's commented part is it's web version

Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostState()),
        ChangeNotifierProvider(create: (_) => UserState()),
        ChangeNotifierProvider(create: (_) => TimeTickingState ()),
        ChangeNotifierProvider(create: (_) => AddingState ()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GreenLink',
          theme: ThemeData(
            primarySwatch: const MaterialColor(0xFF60B45A, {
              50: Color(0xFF60B45A),
              100: Color(0xFF60B45A),
              200: Color(0xFF60B45A),
              300: Color(0xFF60B45A),
              400: Color(0xFF60B45A),
              500: Color(0xFF60B45A),
              600: Color(0xFF60B45A),
              700: Color(0xFF60B45A),
              800: Color(0xFF60B45A),
              900: Color(0xFF60B45A),
            }),
          ),
          initialRoute: '/Home',
          routes: {
            '/Home': (context) => const Home(),
            '/Solar': (context) => const SolarPage(),
            '/Wind': (context) => const WindPage(),
            '/Community': (context) => const Community(),
          },
        ),
      ),
    );
  }
}
