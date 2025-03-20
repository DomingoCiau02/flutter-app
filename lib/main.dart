import 'package:flutter/material.dart';
import 'package:app/provider/granja_provider.dart';
import 'package:app/router/routers.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GranjaProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Granja',
        initialRoute: AppRoutes.rutaInicial,
        routes: AppRoutes.getAppRutas(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
