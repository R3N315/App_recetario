import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recetas/models/recipe_type_model.dart';

class RecipeTypeProvider extends ChangeNotifier {
  List<RecipeType> recipes = [];
  final Set<String> _favoriteIds = {}; // Usamos un Set para ids únicos

  List<RecipeType> get favoriteRecipes =>
      recipes.where((r) => _favoriteIds.contains(r.idMeal)).toList();

  bool isFavorite(String idMeal) => _favoriteIds.contains(idMeal);

  void toggleFavorite(RecipeType recipe) {
    if (_favoriteIds.contains(recipe.idMeal)) {
      _favoriteIds.remove(recipe.idMeal);
    } else {
      _favoriteIds.add(recipe.idMeal);
    }
    notifyListeners();
  }

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