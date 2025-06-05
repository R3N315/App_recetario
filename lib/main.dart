import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recetas/widgets/main_scaffold.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown // Solo permitir la orientación vertical
    ]).then((_) {
        runApp(MyApp());
    });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recetario JR',
      home: MainScaffold(),
    );
  }
}
