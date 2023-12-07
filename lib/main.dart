import 'package:animation/game/screen/game_over%20_screen.dart';
import 'package:animation/game/screen/main_menu_screen.dart';
import 'package:animation/login_page.dart';
import 'package:animation/toggle_button_animation.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/flappy_bird_game.dart';

void main() {
  final game = FlappyBirdGame();
  runApp(
    GameWidget(
      game: game,
      initialActiveOverlays: const [
        MainMenuScreen.id,
      ],
      overlayBuilderMap: {
        'MainMenu': (ctx, _) => MainMenuScreen(flappyBirdGame: game),
        GameOverScreen.id: (ctx, _) => GameOverScreen(flappyBirdGame: game),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          RotationTransition(
            turns: animationController,
            child: const FlutterLogo(
              size: 150,
            ),
          ),
          const ToggleButtonWidget(),
          RawMaterialButton(
            fillColor: Colors.blueAccent,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LoginPage()));
            },
            child: const Text('Login Page'),
          )
        ],
      ),
    );
  }
}
