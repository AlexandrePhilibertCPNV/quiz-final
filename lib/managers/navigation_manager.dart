import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NavigationManager {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateToNamed(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToReplacement(MaterialPageRoute route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }

  void navigateBack() {
    navigatorKey.currentState?.pop();
  }

  static void register() {
    GetIt.I.registerLazySingleton(() => NavigationManager());
  }

  static NavigationManager get instance => GetIt.I.get<NavigationManager>();
}
