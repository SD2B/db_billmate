import 'package:db_billmate/constants/theme.dart';
import 'package:db_billmate/helpers/local_storage.dart';
import 'package:db_billmate/route/route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init(); // Initialize the database
  await LocalStorage.ensureAttributesTableExists(); // Ensure the attributes table exists and is populated

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DB-Billmate',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.getThemeData(ThemeMode.light),
      themeMode: ThemeMode.light,
      // themeMode:
      //     ref.watch(mainVM).isLightTheme ? ThemeMode.light : ThemeMode.dark,
      darkTheme: MyTheme.getThemeData(ThemeMode.dark),
      routerConfig: myRoute,
    );
  }
}
