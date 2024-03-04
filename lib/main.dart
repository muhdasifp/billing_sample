import 'package:bill/controller/table_provider.dart';
import 'package:bill/presentation/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Billing App',
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<TableProvider>(
                create: (context) => TableProvider())
          ],
          child: const HomePage(),
        ));
  }
}
