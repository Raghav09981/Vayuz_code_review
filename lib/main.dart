import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ui_design/data_models/message.dart';
import 'package:ui_design/ui_pages/day_1_task/inbox.dart';
import 'package:ui_design/ui_pages/day_2&3_task/form.dart';
import 'package:ui_design/ui_pages/day_2&3_task/update_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  await Hive.openBox<Message>('messages');
  runApp(
    const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => InboxPage(),
        '/update_data': (context) => UpdateFormScreen(),
        '/add_data': (context) => UserFormScreen()
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
