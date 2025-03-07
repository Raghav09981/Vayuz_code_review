import 'package:flutter/material.dart';
import 'package:ui_design/ui_pages/data_show.dart';
import 'package:ui_design/ui_pages/form.dart';
import 'package:ui_design/ui_pages/update_form.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) =>XYZScreen(),
        '/update_data':(context) => UpdateFormScreen(),
        '/add_data':(context) => UserFormScreen()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
