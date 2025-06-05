import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas/models/recipe_type_model.dart';
import 'package:recetas/pages/detail_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recetas/providers/recipe_type_provider.dart';

class RecipeTypeSlider extends StatelessWidget {
  final String nombreCategoria;
  final String flag;
  final String value;

  const RecipeTypeSlider({
    super.key,
    required this.nombreCategoria,
    required this.flag,
    required this.value,
  });

  Future<List<RecipeType>> fetchRecipes() async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?$flag=$value');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return List<RecipeType>.from(
          data['meals'].map((json) => RecipeType.fromJson(json)),
        );
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecipeType>>(
      future: fetchRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final recipes = snapshot.data ?? [];

        if (recipes.isEmpty) {
          return const SizedBox(
            height: 220,
            child: Center(child: Text('No hay recetas')),
          );
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  nombreCategoria,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: recipes.length,
                  itemBuilder: (_, int index) {
                    final receta = recipes[index];
                    return _RecipePoster(receta);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RecipePoster extends StatelessWidget {
  final RecipeType receta;
  const _RecipePoster(this.receta);

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<RecipeTypeProvider>(context);
    final isFav = favProvider.isFavorite(receta.idMeal);

    return Container(
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(
                        idMeal: receta.idMeal,
                        heroTag: receta.idMeal,
                        imageUrl: receta.strMealPhoto,
                        mealName: receta.strMeal,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: receta.idMeal,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      receta.strMealPhoto,
                      height: 120,
                      width: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                receta.strMeal,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                favProvider.toggleFavorite(receta);
              },
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : Colors.grey,
                size: 24,
                semanticLabel: isFav ? 'Quitar de favoritos' : 'Agregar a favoritos',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
