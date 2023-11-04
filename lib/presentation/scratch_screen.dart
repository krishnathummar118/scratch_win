import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import '../utils/scratch_card_view.dart';
import '../utils/widget_util.dart';

class ScratchScreen extends StatefulWidget {
  final int item;

  const ScratchScreen({super.key, required this.item});

  @override
  State<StatefulWidget> createState() {
    return _ScratchScreen();
  }
}

class _ScratchScreen extends State<ScratchScreen> {
  bool isScratched = false;
  double lastX = 0.0;
  double lastY = 0.0;
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();

    super.dispose();
  }

  int getAmountByPos(int index) {
    int i = index;
    int modularVal = i % 5;
    if (modularVal == 1 || modularVal == 2) {
      return 15;
    } else {
      return 10;
    }

  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    initScreenSize(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            buildCard(), // O
            buildConfettiView(),
          ],
        ),
      ),
    );
  }

  Align buildConfettiView() {
    return Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
                confettiController: _controllerTopCenter,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 60
                ),
          );
  }

  Center buildCard() {
    return Center(
            // Same tag as the grid item
            child: Hero(
              tag: 'item_${widget.item}',
              child: Container(
                width: 190.h,
                height: 190.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(assetImagePath + "overlay2.png"),
                        fit: BoxFit.cover,
                        opacity: 0.2),
                    color: getColors(widget.item+1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        offset: const Offset(4, 4), // Offset of the shadow
                        blurRadius: 10, // Spread of the shadow
                        spreadRadius: 0, // Amount of spread
                      ),
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Scratcher(
                    image: Image(
                        image: AssetImage(assetImagePath + "overlay2.png")),
                    color: getColors(widget.item + 1),
                    brushSize: 30,
                    threshold: 50,
                    onScratchEnd: () {
                      _controllerTopCenter.play();
                    },
                    onChange: (value) => print("Scratch progress: $value%"),
                    onThreshold: () => print("Threshold reached, you won!"),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                          child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "You won\n",
                            style: getCustomTextStyle(24.sp, Colors.black,
                                weight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text:
                                      getAmountByPos(widget.item).toString(),
                                  style: getCustomTextStyle(
                                      40.sp, Colors.black,
                                      weight: FontWeight.w700)),
                              TextSpan(
                                  text: " Rs",
                                  style: getCustomTextStyle(
                                      19.sp, Colors.black,
                                      weight: FontWeight.w500))
                            ]),
                      )
                          ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
