import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas/widgets/background.dart';
import '../providers/recipes_provier.dart';

class DetailPage extends StatelessWidget {
  final String idMeal;
  final String heroTag;
  final String imageUrl;
  final String mealName;

  const DetailPage({
    super.key,
    required this.idMeal,
    required this.heroTag,
    required this.imageUrl,
    required this.mealName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mealName,
          style: const TextStyle(
            color: Color.fromARGB(255, 231, 119, 26),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.orange),
      ),
      body: Stack(
        children: [
          Background(),
          FutureBuilder(
            future: Provider.of<RecipeProvider>(context, listen: false)
                .fetchRecipeById(idMeal),
            builder: (context, snapshot) {
              final recipe = Provider.of<RecipeProvider>(context).recipe;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (recipe == null) {
                return const Center(child: Text('No se encontró la receta'));
              }
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Hero(
                        tag: heroTag,
                        child: Image.network(
                          recipe.strMealPhoto,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Ingredientes
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.shopping_basket, color: Colors.orange),
                                SizedBox(width: 8),
                                Text(
                                  'Ingredientes',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ...recipe.ingredientes.map(
                              (ing) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle, size: 8, color: Colors.orange),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(ing)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Instrucciones
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.menu_book, color: Colors.orange),
                                SizedBox(width: 8),
                                Text(
                                  'Instrucciones',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ..._separarInstrucciones(recipe.strInstructions).asMap().entries.map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${entry.key + 1}. ',
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(child: Text(entry.value)),
                                      ],
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static List<String> _separarInstrucciones(String texto) {
    return texto
        .split(RegExp(r'\n+|\. '))
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.trim())
        .toList();
  }
}