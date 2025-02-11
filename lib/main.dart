import 'package:flutter/material.dart';
import 'package:foody_guy/pages/main_bottom_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foody_guy/provider/fav_recipe_provider.dart';
import 'package:hive_flutter/hive_flutter.dart' ;
import 'package:provider/provider.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter("my_box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteRecipeProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // ignore: prefer_const_constructors
        home: const MainBottomBar(),
      ),
    );
  }
}

