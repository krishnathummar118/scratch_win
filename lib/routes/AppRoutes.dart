import 'package:get/get.dart';
import 'package:scratch_win/main.dart';
import 'package:scratch_win/presentation/scratch_screen.dart';

import '../presentation/home_screen.dart';

class AppRoutes
{
  static String shomeScreen="/scratchHomeScreenWidget";
  static String scratchScreen="/scratchScreenWidget";



  static String getHomePageRoute() => shomeScreen;
  static String getScratchCardRoute(int page) => '$scratchScreen?id=$page';


  static List<GetPage>  getRoutes=[
    GetPage(name: shomeScreen, page: () => const HomePage()),
    GetPage(name: scratchScreen, page: () => ScratchScreen(item: int.parse(Get.parameters['id']??"0"),),)
  ];
}