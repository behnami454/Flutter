import 'package:firstflutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'plugins/input_page.dart';
import 'package:provider/provider.dart';
import 'classes/image_class.dart';
import 'package:firstflutter/pages/details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ImageFile(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.indigo,
            foregroundColor: Colors.white,
          ),
        ),
        title: 'Flutter',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          InputPage.routeName: (ctx) => const InputPage(),
          DetailsPage.routeName: (ctx) => const DetailsPage()
        },
      ),
    );
  }
}
