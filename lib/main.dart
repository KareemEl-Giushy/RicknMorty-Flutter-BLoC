import 'app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RicknMortyApp());
}

class RicknMortyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();
  RicknMortyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.charactersScreen,
      onGenerateRoute: appRouter.generateRoutes,
    );
  }
}
