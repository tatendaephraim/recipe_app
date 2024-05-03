import 'package:ellafoods/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'home.dart';

void main() {
  runApp(const FooderLich());
}

class FooderLich extends StatefulWidget {
  const FooderLich({super.key});

  @override
  State<FooderLich> createState() => _FooderLichState();
}

class _FooderLichState extends State<FooderLich> {
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.pink;

  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode
          ? ThemeMode.light //
          : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'FooderLich';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false, // Uncomment to remove Debug banner
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>TabManager()),
          ChangeNotifierProvider(create: (context)=>GroceryManager()),
        ],
        child:  Home(
          appTitle: appTitle, //todo: stef delete this?

          changeTheme: changeThemeMode,
          changeColor: changeColor,
          colorSelected: colorSelected,
        ),
      ),
    );
  }
}
