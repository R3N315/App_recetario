import 'package:flutter/material.dart';
import 'package:recetas/widgets/background.dart';
import 'package:recetas/widgets/recipe_type_slider.dart';
import '../models/class_comida.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Comida> desayunos = [
      Comida(
        nombre: 'Hotcakes',
        imagenUrl: 'https://example.com/hotcakes.jpg',
        ingredientes: ['Harina', 'Leche', 'Huevo', 'Mantequilla'],
        instrucciones: 'Mezcla los ingredientes y cocina en sartén.',
      ),
      Comida(
        nombre: 'Pasta',
        imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
        ingredientes: ['Pasta', 'Salsa de tomate', 'Queso parmesano', 'Albahaca'],
        instrucciones: 'Hierve la pasta.\nPrepara la salsa.\nMezcla pasta con salsa y agrega queso.',
      ),
    ];

    final List<Comida> pollo = [
      Comida(
        nombre: 'Pollo al horno',
        imagenUrl: 'https://example.com/pollo.jpg',
        ingredientes: ['Pollo', 'Especias', 'Aceite'],
        instrucciones: 'Sazona el pollo y hornea.',
      ),
      // ...más recetas de pollo...
    ];

    final List<Comida> pasta = [
      Comida(
        nombre: 'Pasta Alfredo',
        imagenUrl: 'https://example.com/alfredo.jpg',
        ingredientes: ['Pasta', 'Crema', 'Queso parmesano'],
        instrucciones: 'Cocina la pasta y mezcla con la salsa.',
      ),
      // ...más recetas de pasta...
    ];

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
                children: [
                  RecipeTypeSlider(
                    nombreCategoria: 'Desayunos',
                    comidas: desayunos,
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Pollo',
                    comidas: pollo,
                  ),
                  RecipeTypeSlider(
                    nombreCategoria: 'Pasta',
                    comidas: pasta,
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
