import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Replace and Build layout widgets
    return  Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO: Add empty image
              Flexible(
                  child: AspectRatio(aspectRatio: 1/1,
                  child: Image.asset('assets/fooderlich_assets/empty_list.png'),
                  )
              ),
              //TODO: Add empty screen title
              const Text('No Groceries',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
              //TODO: Add empty screen subtitle

              const SizedBox(height: 16.0),
              const Text('Shopping for ingredients?\n'
                  'Tap the + button to write them down',
              textAlign: TextAlign.center),
              //TODO: Add browse recipes button
              
              MaterialButton(
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.green,
                  onPressed: (){
                    //Todo:  go to recipes tab
                    Provider.of<TabManager>(context,listen: false).goToRecipes();
                  },
                child: const Text('Browse Recipes'),
              ),
            ],
          ),
        ),
    );
  }
}
