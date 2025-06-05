import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recetas/models/recipes_model.dart';

class RecipeProvider extends ChangeNotifier {
  Recipe? recipe;

  Future<void> fetchRecipeById(String idMeal) async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$idMeal');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null && data['meals'].isNotEmpty) {
        recipe = Recipe.fromJson(data['meals'][0]);
        notifyListeners();
      }
    }
  }
}