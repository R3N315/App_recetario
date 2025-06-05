import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas/models/recipe_type_model.dart';
import 'package:recetas/providers/recipe_type_provider.dart';
import 'package:recetas/pages/detail_page.dart'; // <-- Usa la página de detalles correcta

class RecipeTypeSlider extends StatelessWidget {
  final String nombreCategoria;
  final String flag; // 'c' para categoría, 'a' para región
  final String value; // valor de búsqueda

  const RecipeTypeSlider({
    super.key,
    required this.nombreCategoria,
    required this.flag,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<RecipeTypeProvider>(context, listen: false)
          .fetchRecipesByType(flag: flag, value: value),
      builder: (context, snapshot) {
        final recipes = Provider.of<RecipeTypeProvider>(context).recipes;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        }

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
    final provider = Provider.of<RecipeTypeProvider>(context);
    final isFav = provider.isFavorite(receta.idMeal);

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
          // Botón de favorito en la esquina superior derecha
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                provider.toggleFavorite(receta);
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
