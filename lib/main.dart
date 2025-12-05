import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load(fileName: ".env"); // clé API si nécessaire
  //dotenv.env['API_KEY'];

  runApp(const App());
}
