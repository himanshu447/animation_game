import 'dart:math';

import 'package:animation/login_page.dart';
import 'package:animation/toggle_button_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class _MyHomePageState extends State<MyHomePage>  with TickerProviderStateMixin{

  late AnimationController animationController;

  late AnimationController _controller;
  bool isPlaying = false;
  int maxDuration = 10;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _controller = AnimationController(vsync: this, duration: Duration(seconds: maxDuration))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isPlaying = false;
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double val = (_controller.value * maxDuration);
    return Scaffold(
      backgroundColor: const Color(0xFF232424),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                (val.toInt() * 10).toString(),
                style: const TextStyle(color: Colors.white, fontSize: 50),
              ),
              Text(
                ".${val.toStringAsFixed(1).substring(val.toString().indexOf(".") + 1)} %",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CustomPaint(
                          painter: LiquidPainter(
                            _controller.value * maxDuration,
                            maxDuration.toDouble(),
                          ),
                        ),
                      ),
                      CustomPaint(
                          painter: RadialProgressPainter(
                            value: _controller.value * maxDuration,
                            backgroundGradientColors: gradientColors,
                            minValue: 0,
                            maxValue: maxDuration.toDouble(),
                          )),
                    ],
                  ),
                );
              }),
          const SizedBox(
            height: 50,
          ),
          // Start and Stop Button
          Container(
            alignment: Alignment.center,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white54,
                  width: 2,
                ),
                shape: BoxShape.circle),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isPlaying) {
                    _controller.reset();
                  } else {
                    _controller.reset();
                    _controller.forward();
                  }
                  isPlaying = !isPlaying;
                });
              },
              child: AnimatedContainer(
                height: isPlaying ? 25 : 60,
                width: isPlaying ? 25 : 60,
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isPlaying ? 4 : 100),
                  color: Colors.white54,
                ),
              ),
            ),
          )
        ],
      ),
    );
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
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (_) => const LoginPage()));
            },
            child: const Text(
              'Login Page'
            ),
          )
        ],
      ),
    );
  }
}
class LiquidPainter extends CustomPainter{
  final double value;
  final double maxValue;

  /// Creates a [LiquidPainter] with the given [value] and [maxValue].
  LiquidPainter(this.value, this.maxValue);


  @override
  void paint(Canvas canvas, Size size) {
    double diameter = min(size.height, size.width);
    double radius = diameter / 2;

    // Defining coordinate points. The wave starts from the bottom and ends at the top as the value changes.
    double pointX = 0;
    double pointY = diameter - ((diameter + 10) * (value / maxValue)); // 10 is an extra offset added to fill the circle completely

    Path path = Path();
    path.moveTo(pointX, pointY);

    // Amplitude: the height of the sine wave
    double amplitude = 10;

    // Period: the time taken to complete one full cycle of the sine wave.
    // f = 1/p, the more the value of the period, the higher the frequency.
    double period = value / maxValue;

    // Phase Shift: the horizontal shift of the sine wave along the x-axis.
    double phaseShift = value * pi;

    // Plotting the sine wave by connecting various paths till it reaches the diameter.
    // Using this formula: y = A * sin(ωt + φ) + C
    for (double i = 0; i <= diameter; i++) {
      path.lineTo(
        i + pointX,
        pointY + amplitude * sin((i * 2 * period * pi / diameter) + phaseShift),
      );
    }

    // Plotting a vertical line which connects the right end of the sine wave.
    path.lineTo(pointX + diameter, diameter);
    // Plotting a vertical line which connects the left end of the sine wave.
    path.lineTo(pointX, diameter);
    // Closing the path.
    path.close();

    Paint paint = Paint()
      ..shader = const SweepGradient(
          colors: [
            Color(0xffFF7A01),
            Color(0xffFF0069),
            Color(0xff7639FB),
          ],
          startAngle: pi / 2,
          endAngle: 5 * pi / 2,
          tileMode: TileMode.clamp,
          stops: [
            0.25,
            0.35,
            0.5,
          ]).createShader(Rect.fromCircle(center: Offset(diameter, diameter), radius: radius))
      ..style = PaintingStyle.fill;

    // Clipping rectangular-shaped path to Oval.
    Path circleClip = Path()..addOval(Rect.fromCenter(center: Offset(radius, radius), width: diameter, height: diameter));
    canvas.clipPath(circleClip, doAntiAlias: true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
class RadialProgressPainter extends CustomPainter {
  final double value;
  final List<Color> backgroundGradientColors;
  final double minValue;
  final double maxValue;

  // Constructor to initialize the RadialProgressPainter with required parameters.
  RadialProgressPainter({
    required this.value,
    required this.backgroundGradientColors,
    required this.minValue,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // circle's diameter // taking min side as diameter
    final double diameter = min(size.height, size.width);
    // Radius
    final double radius = diameter / 2;
    // Center cordinate
    final double centerX = radius;
    final double centerY = radius;

    const double strokeWidth = 6;

    // Paint for the progress with gradient colors.
    final Paint progressPaint = Paint()
      ..shader = SweepGradient(
        colors: backgroundGradientColors,
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
        tileMode: TileMode.repeated,
      ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Paint for the progress track.
    final Paint progressTrackPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Calculate the start and sweep angles to draw the progress arc.
    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * value / maxValue;

    // Drawing track.
    canvas.drawCircle(Offset(centerX, centerY), radius, progressTrackPaint);
    // Drawing progress.
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
List<Color> gradientColors = const [
  Color(0xffFF0069),
  Color(0xffFED602),
  Color(0xff7639FB),
  Color(0xffD500C5),
  Color(0xffFF7A01),
  Color(0xffFF0069),
];
