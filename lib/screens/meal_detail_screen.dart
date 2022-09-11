import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorite;
  final Function isFaforite;
  static const routeName = '/meal-detail';
  MealDetailScreen(this.toggleFavorite, this.isFaforite);

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _buildContainer(
    Widget child,
  ) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 1),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white),
      padding: EdgeInsets.all(10),
      height: 180,
      width: 330,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          _buildSectionTitle('Ingredients', context),
          _buildContainer(
            ListView.builder(
              itemBuilder: (context, index) => Card(
                color: Colors.lightBlue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(selectedMeal.ingredients[index]),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          _buildSectionTitle('Steps', context),
          _buildContainer(
            ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      child: Text(
                        '${(index + 1)}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    title: Text(
                      selectedMeal.steps[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const Divider()
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: Icon(isFaforite(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
