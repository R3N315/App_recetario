import 'package:flutter/material.dart';
import 'package:recetas/widgets/background.dart';
import '../models/class_comida.dart';

class Pag_favoritos extends StatelessWidget {
  // ejemplo de lista de recetas favoritas
  final List<Comida> recetasFavoritas = [
    Comida(
      nombre: 'Tacos al Pastor',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
      ingredientes: ['Carne de cerdo', 'Piña', 'Cilantro', 'Cebolla'],
      instrucciones: '',
    ),
    Comida(
      nombre: 'Enchiladas Verdes',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWyIbkLV1spe-mevEdh8YLwnzNHa3w9vrMYw&s',
      ingredientes: ['Tortillas', 'Salsa verde', 'Pollo', 'Queso'],
      instrucciones: '',
    ), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Favoritos',
          style: TextStyle(
            color: Color.fromARGB(255, 231, 119, 26),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      body: Container(
        child: Stack(
          children: [
            Background(),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  frase_introduccion(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    itemCount: recetasFavoritas.length,
                    itemBuilder: (context, index) {
                      final receta = recetasFavoritas[index];
                      return Card(
                        color: Colors.white.withOpacity(0.92),
                        elevation: 6,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: Hero(
                                tag: receta.nombre,
                                child: Image.network(
                                  receta.imagenUrl,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      receta.nombre,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF6D4C41),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Receta guardada',
                                          style: TextStyle(
                                            color: Colors.orange[700],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            // Acción para eliminar de favoritos
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
            ),
          ],
        ),
      ),
    );
  }
}

// Diseño de la frase de introducción
class frase_introduccion extends StatelessWidget {
  const frase_introduccion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
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
      ),
    );
  }
}
