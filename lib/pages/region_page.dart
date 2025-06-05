import 'package:flutter/material.dart';
import 'package:recetas/widgets/background.dart';
import 'package:recetas/widgets/recipe_type_slider.dart';

class RegionPage extends StatelessWidget {
  const RegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recetas por Área',
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
                    nombreCategoria: 'Mexicana',
                    flag: 'a',
                    value: 'Mexican',
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Italiana',
                    flag: 'a',
                    value: 'Italian',
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Japonesa',
                    flag: 'a',
                    value: 'Japanese',
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