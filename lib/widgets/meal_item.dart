import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final complexity;
  final affordability;

  const MealItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.id,
  }) : super(key: key);

  void selectMeal(ctx) {
    Navigator.of(ctx)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
  }

  Widget _mealConfiguration(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 7,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 17),
        )
      ],
    );
  }

  String? get complexityText {
    if (complexity == Complexity.Simple) {
      return 'Simple';
    } else if (complexity == Complexity.Challenging) {
      return 'Challanging';
    } else if (complexity == Complexity.Hard) {
      return 'Hard';
    } else {
      return 'Unknown';
    }
  }

  String? get affordabilityText {
    if (affordability == Affordability.Affordable) {
      return 'Cheap';
    } else if (complexity == Affordability.Pricey) {
      return 'Pricey';
    } else if (complexity == Affordability.Luxurious) {
      return 'Luxurious';
    } else {
      return 'Rare';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    color: Colors.black54,
                    width: 220,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _mealConfiguration(Icons.schedule, '$duration min'),
                  _mealConfiguration(Icons.work, '$complexityText'),
                  _mealConfiguration(Icons.attach_money, '$affordabilityText')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
