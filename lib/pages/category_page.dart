import 'package:flutter/material.dart';
import 'package:recetas/widgets/background.dart';
import 'package:recetas/widgets/recipe_type_slider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recetas por Categoría',
          style: TextStyle(
            color: Color.fromARGB(255, 231, 119, 26),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Background(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: const [
                  RecipeTypeSlider(
                    nombreCategoria: 'Desayunos',
                    flag: 'c',
                    value: 'Breakfast',
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Pollo',
                    flag: 'c',
                    value: 'Chicken',
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Pasta',
                    flag: 'c',
                    value: 'Pasta',
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Reses',
                    flag: 'c',
                    value: 'Beef',
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Vegetariana',
                    flag: 'c',
                    value: 'Vegetarian',
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Postres',
                    flag: 'c',
                    value: 'Dessert',
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Diversos',
                    flag: 'c',
                    value: 'Miscellaneous',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
