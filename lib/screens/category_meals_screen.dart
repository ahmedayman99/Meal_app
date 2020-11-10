import 'package:flutter/material.dart';
import 'package:meal_app/3.2%20dummy_data.dart';
import 'package:meal_app/model/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {

  static const routeName = 'Category_Meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String categoryTitle;
  List <Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initState
    

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_loadedInitData){
      final routeArg = ModalRoute.of(context).settings.arguments as Map<String,String>;
      categoryTitle = routeArg['title'];
      final categoryId = routeArg['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}