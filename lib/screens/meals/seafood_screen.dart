import 'package:flutter/material.dart';
import 'package:flutter_app/config/future.dart';
import 'package:flutter_app/components/card_meals.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SeafoodScreen extends StatefulWidget {
  @override
  _SeafoodScreenState createState() => _SeafoodScreenState();
}

class _SeafoodScreenState extends State<SeafoodScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllMeals('Seafood'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.meals != null) {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                padding: EdgeInsets.all(20),
                itemCount: snapshot.data.meals.length,
                itemBuilder: (BuildContext context, int index) {
                  var meal = snapshot.data.meals[index];
                  return CardMeals(
                    mealId: meal.idMeal,
                    mealName: meal.strMeal,
                    mealThumbs: meal.strMealThumb,
                    mealPrice: index.isEven ? 12.5 : 15.0,
                    mealRating: index.isEven ? 3.0 : 5.0,
                  );
                },
                staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              );
            }
          } else if (snapshot.hasError) {
            Text('${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
