import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function isMealFovorite;

  MealDetailScreen(this.toggleFavorite, this.isMealFovorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context)!.settings.arguments as String;
    final Meal selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => (meal.id == mealId));
    int i = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            Wrap(
              children: [
                ...selectedMeal.ingredients
                    .map((e) => Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(e),
                          ),
                        ))
                    .toList()
              ],
            ),
            SizedBox(height: 10),
            buildSectionTitle(context, 'Steps'),
            ...selectedMeal.steps.map((e) {
              i++;
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('$i'),
                      maxRadius: 15,
                    ),
                    title: Text(e),
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: isMealFovorite(mealId)
            ? Icon(Icons.star)
            : Icon(Icons.star_border),
      ),
    );
  }
}
