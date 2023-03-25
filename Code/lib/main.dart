import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'View/home_screen.dart';
import 'View/new_diary.dart';
import 'ViewModel/provider.dart';

void main()
{
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) =>DiaryProvider(),
    child: MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/new': (context) => const NewDiary(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
