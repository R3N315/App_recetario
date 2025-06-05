import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recetas/models/recipe_type_model.dart';
import 'package:recetas/models/recipes_model.dart';

class RecipeTypeProvider extends ChangeNotifier {
  List<RecipeType> categoryRecipes = [];
  List<RecipeType> regionReciperes = [];
  List<Recipe> favoriteRecipes = [];

  String recipeType = '';

  List<RecipeType> recipes = [];

  /// flag: 'c' para categoría, 'a' para región
  /// value: el valor a buscar (ej: 'breakfast', 'mexican')
  Future<void> fetchRecipesByType({required String flag, required String value}) async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?$flag=$value');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        recipes = List<RecipeType>.from(
          data['meals'].map((json) => RecipeType.fromJson(json)),
        );
        notifyListeners();
      }
    }
  }
}