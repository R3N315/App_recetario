import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recetas/models/recipe_type_model.dart';

class RecipeTypeProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  List<RecipeType> _allLoadedRecipes = [];

  List<RecipeType> get favoriteRecipes => _allLoadedRecipes
      .where((r) => _favoriteIds.contains(r.idMeal))
      .toList();

  bool isFavorite(String idMeal) => _favoriteIds.contains(idMeal);

  void toggleFavorite(RecipeType recipe) {
    if (_favoriteIds.contains(recipe.idMeal)) {
      _favoriteIds.remove(recipe.idMeal);
      _allLoadedRecipes.removeWhere((r) => r.idMeal == recipe.idMeal);
    } else {
      _favoriteIds.add(recipe.idMeal);
      // Solo agrega si no existe ya
      if (!_allLoadedRecipes.any((r) => r.idMeal == recipe.idMeal)) {
        _allLoadedRecipes.add(recipe);
      }
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
        _allLoadedRecipes = List<RecipeType>.from(
          data['meals'].map((json) => RecipeType.fromJson(json)),
        );
        notifyListeners();
      }
    }
  }
}