import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas/widgets/background.dart';
import 'package:recetas/providers/recipe_type_provider.dart';

class FavsPage extends StatelessWidget {
  const FavsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Favoritos',
          style: TextStyle(
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
          Consumer<RecipeTypeProvider>(
            builder: (context, provider, _) {
              final favoritos = provider.favoriteRecipes;
              if (favoritos.isEmpty) {
                return const Center(
                  child: Text(
                    'No tienes recetas favoritas aún.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const FraseIntroduccion(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: favoritos.length,
                      itemBuilder: (context, index) {
                        final receta = favoritos[index];
                        return Card(
                          color: Colors.white.withOpacity(0.92),
                          elevation: 6,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                                child: Hero(
                                  tag: receta.idMeal,
                                  child: Image.network(
                                    receta.strMealPhoto,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        receta.strMeal,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6D4C41),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Receta guardada',
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              provider.toggleFavorite(receta);
                                            },
                                          ),
                                        ],
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
            },
          ),
        ],
      ),
    );
  }
}

// Diseño de la frase de introducción
class FraseIntroduccion extends StatelessWidget {
  const FraseIntroduccion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.star_rounded, color: Colors.white, size: 40),
          SizedBox(height: 8),
          Text(
            '"Aquí encontrarás todas tus recetas favoritas reunidas en un solo lugar. ¡Descubre y revive tus platillos preferidos!"',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
