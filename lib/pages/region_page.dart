import 'package:flutter/material.dart';
import 'package:recetas/widgets/background.dart';
import 'package:recetas/widgets/recipe_type_slider.dart';
import '../models/class_comida.dart';

class RegionPage extends StatelessWidget {
  const RegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Comida> mexicana = [
          Comida(
            nombre: 'Tacos',
            imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
            ingredientes: ['Tortillas', 'Carne', 'Cilantro', 'Cebolla', 'Salsa'],
            instrucciones: 'Cocina la carne.\nCalienta las tortillas.\nArma los tacos con carne, cilantro, cebolla y salsa.',
          ),
          Comida(
            nombre: 'Enchiladas bien picantes',
            imagenUrl: 'https:example.com/enchiladas.jpg',
            ingredientes: ['Tortillas', 'Pollo', 'Salsa de chile', 'Queso'],
            instrucciones: 'Rellena las tortillas con pollo.\nCúbrelas con salsa de chile.\nHornea y agrega queso al final.',
          ),
        ];

        final List<Comida> italiana = [
          Comida(
            nombre: 'Pasta',
            imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
            ingredientes: ['Pasta', 'Salsa de tomate', 'Queso parmesano', 'Albahaca'],
            instrucciones: 'Hierve la pasta.\nPrepara la salsa.\nMezcla pasta con salsa y agrega queso.',
          ),
          Comida(
            nombre: 'Pizza',
            imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
            ingredientes: ['Masa', 'Salsa de tomate', 'Queso mozzarella', 'Ingredientes al gusto'],
            instrucciones: 'Extiende la masa.\nAgrega salsa y queso.\nHornea hasta dorar.',
          ),
        ];

        final List<Comida> japonesa = [
          Comida(
            nombre: 'Sushi',
            imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
            ingredientes: ['Arroz', 'Nori', 'Pescado fresco', 'Wasabi'],
            instrucciones: 'Prepara el arroz.\nCorta el pescado.\nArma los rolls con nori.',
          ),
          Comida(
            nombre: 'Ramen',
            imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
            ingredientes: ['Fideos', 'Caldo', 'Huevo', 'Cebollín'],
            instrucciones: 'Prepara el caldo.\nCuece los fideos.\nSirve con huevo y cebollín.',
          ),
          Comida(
            nombre: 'Ramen1',
            imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
            ingredientes: ['Fideos', 'Caldo', 'Huevo', 'Cebollín'],
            instrucciones: 'Prepara el caldo.\nCuece los fideos.\nSirve con huevo y cebollín.',
          ),
          Comida(
            nombre: 'Ramen2',
            imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
            ingredientes: ['Fideos', 'Caldo', 'Huevo', 'Cebollín'],
            instrucciones: 'Prepara el caldo.\nCuece los fideos.\nSirve con huevo y cebollín.',
          ),
        ];

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
                children: [
                  RecipeTypeSlider(
                    nombreCategoria:'Mexicana',
                    comidas: mexicana,
                  ),
                  RecipeTypeSlider(
                    nombreCategoria:'Italiana',
                    comidas: italiana,
                  ),
                  RecipeTypeSlider(
                    nombreCategoria:'Japonesa',
                    comidas: japonesa,
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}