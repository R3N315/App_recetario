import 'package:flutter/material.dart';
import 'package:recetas/widgets/background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        const HomeBody(),
      ],
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Header(),
            RecipeImage(),
            Subtitle(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: const [
          Icon(
            Icons.food_bank,
            color: Color.fromARGB(255, 229, 116, 18),
            size: 50,
          ),
          SizedBox(height: 8),
          Text(
            'Recetario JR',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              //color: Color.fromARGB(255, 231, 119, 26),
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RecipeImage extends StatelessWidget {
  const RecipeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'assets/recetas.jpeg',
          height: 500,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '"Descubre sabores únicos en cada plato"',
      style: TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
        color: Colors.white70,
      ),
      textAlign: TextAlign.center,
    );
  }
}
