import '../api/mock_fooderlich_service.dart';
import '../components/recipe_grid_view.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';
class RecipesScreen extends StatelessWidget {
  final exploreService = MockFooderlichService();
  RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: exploreService.getRecipes(),
        builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            return RecipesGridView(recipes: snapshot.data??[]);

          }
          else{
            return const Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...')
                ],
              ),

            );
          }
    },
    );
  }
}
