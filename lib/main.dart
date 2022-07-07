import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'home_page.dart';
import 'room_selection_screen.dart';

//import 'package:hive_flutter/hive_flutter.dart';
//import 'package:learning_dart/homepage.dart';
// git branchName: spelling_bee_infographics
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSheetsApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: true, home: RoomSelectionScreen());
  }
}
