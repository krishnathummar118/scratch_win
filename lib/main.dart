import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scratch_win/presentation/home_screen.dart';
import 'package:scratch_win/routes/AppRoutes.dart';
import 'package:showcaseview/showcaseview.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Practical',
      theme: ThemeData(
        primaryColor: const Color(0xff2D74FF),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.getHomePageRoute(),
      getPages: AppRoutes.getRoutes,
      home: Scaffold(
        body: ShowCaseWidget(
          onStart: (index, key) {},
          onComplete: (index, key) {},
          blurValue: 1,
          builder: Builder(builder: (context) => const HomePage()),
          autoPlayDelay: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
