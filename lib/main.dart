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
  //fade out
  double opacity = 1;

  //transition
  double top = 0;
  double left = 0;

  //rotate
  double turns = 1;

  //scale
  double scale = 1;

  //Animation Controller
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();

/*  @override
  void initState() {
    animationController.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }*/

  // color + scale + opacity
  late final Animation<Color?> colorTween = ColorTween(begin: Colors.pinkAccent , end: Colors.black).animate(animationController);
  late final Animation<double> opacityTween = Tween<double>(begin: 1.0 , end: 0.5).animate(animationController);
  late final Animation<double> scaleTween = Tween<double>(begin: 1.0 , end: 0.5).animate(CurvedAnimation(parent: animationController, curve: Curves.bounceIn));

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                /* Opacity Animation */
                AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: opacity,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(16)),
                    )),
                const SizedBox(
                  height: 16,
                ),
                /* Transition Animation */
                SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                          top: top,
                          left: left,
                          curve: Curves.decelerate,
                          duration: const Duration(seconds: 1),
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(16)),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                /* Rotate Animation */
                AnimatedRotation(
                  duration: Duration(seconds: 1),
                  turns: turns,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                /* Scale Animation */
                AnimatedScale(
                  duration: const Duration(seconds: 1),
                  scale: scale,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                /* Opacity using Animation Controller */
                AnimatedBuilder(
                  builder: (context, child) => Opacity(
                    opacity: animationController.value,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                          color: Colors.lightGreenAccent,
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  animation: animationController,
                ),
                const SizedBox(
                  height: 16,
                ),
                 /* color + scale + opacity */
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) => Opacity(
                    opacity: opacityTween.value,
                    child: Container(
                      width: 140 * scaleTween.value,
                      height: 140 * scaleTween.value,
                      decoration: BoxDecoration(
                          color: colorTween.value,
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            backgroundColor: Colors.teal,
            onPressed: () {
              setState(() {
                opacity = opacity == 1 ? 0 : 1;
              });
            },
            label: const Text('Fade Out Animation'),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.amber,
            onPressed: () {
              setState(() {
                if (top < 350) {
                  top += 50;
                } else {
                  top = 0;
                }

                if (left < 150) {
                  left += 50;
                } else {
                  left -= 50;
                }
              });
            },
            label: const Text('Transaction Animation'),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              setState(() {
                turns += 1;
              });
            },
            label: const Text('Rotate Animation'),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.purple,
            onPressed: () {
              setState(() {
                if (scale < 2) {
                  scale += 0.2;
                } else {
                  scale = 0.2;
                }
              });
            },
            label: const Text('Scale Animation'),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.lightGreenAccent,
            onPressed: () {
              if (!animationController.isCompleted) {
                animationController.forward();
              } else {
                animationController.reverse();
              }
            },
            label: const Text('Opacity using Animation Controller'),
          ),

          FloatingActionButton.extended(
            backgroundColor: Colors.pinkAccent,
            onPressed: () {
              if (!animationController.isCompleted) {
                animationController.forward();
              } else {
                animationController.reverse();
              }
            },
            label: const Text('Color + Scale + Opacity'),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
