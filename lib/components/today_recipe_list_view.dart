import 'package:ellafoods/components/card2.dart';
import 'package:ellafoods/components/card3.dart';

import '../models/explore_recipe.dart';
import '../models/explore_data.dart';
import 'package:flutter/material.dart';
import 'card1.dart';

class TodayRecipeListView extends StatelessWidget {
  final List<ExploreRecipe> recipes;
  const TodayRecipeListView({
    super.key,
  required this.recipes});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recipes of the Day',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            height: 400,
            color: Colors.transparent,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recipes.length,
                itemBuilder: (context,index){
                  final recipe = recipes[index];
                  return buildCard(recipe);
                },
                separatorBuilder: (context,index){
                  return const SizedBox(width: 16);
                },
                ),
          ),

        ],
      ),
    );
  }

  Widget buildCard(ExploreRecipe recipe) {
    if(recipe.cardType==RecipeCardType.card1){
      return Card1(recipe:recipe);
    }
    else if(recipe.cardType==RecipeCardType.card2){
      return Card2(recipe: recipe);
    }
    else if(recipe.cardType==RecipeCardType.card3){
      return Card3(recipe: recipe);
    }
    else{
      throw Exception('This card doesn\'t exist yet');
    }
  }
}
