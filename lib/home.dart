import 'package:ellafoods/screens/grocery_screen.dart';
import 'package:provider/provider.dart';
import '../screens/explore_screen.dart';
import '../screens/recipes_screen.dart';
import 'package:flutter/material.dart';
import 'components/color_button.dart';
import 'components/theme_button.dart';
import 'constants.dart';
import 'models/post.dart';
import 'models/models.dart';


class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
    required this.appTitle,
  });

  final ColorSelection colorSelected;
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final String appTitle;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      // TODO: Replace with ExploreScreen
      ExploreScreen(),
      // TODO: Replace with RecipesScreen
      RecipesScreen(),
      const GroceryScreen(),
    ];

    return Consumer<TabManager>(builder: (context,tabManager,child){
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.appTitle),
          elevation: 4.0,
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            ThemeButton(
              changeThemeMode: widget.changeTheme,
            ),
            ColorButton(
              changeColor: widget.changeColor,
              colorSelected: widget.colorSelected,
            ),

          ],
          centerTitle: true,
        ),
        body: pages[tabManager.selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabManager.selectedTab,
          onTap: (index){
            tabManager.goToTab(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Shop',
            ),
          ],

        ),
      );
    },
    );
  }
}
