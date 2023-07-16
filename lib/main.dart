import 'package:flutter/material.dart';
import 'pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SolarGuide',
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
        initialRoute: '/HomePage',
        routes: {
          '/HomePage': (context) => const HomePage(),
        },
      ),
    );
  }
}
