import 'package:flutter/material.dart';
import 'package:recetas/pages/pag_inicio.dart' as inicio;
import '../models/class_comida.dart';

class PaginaDetalle extends StatelessWidget { 
  final Comida comida;
  final String? heroTagPrefix; // Para distinguir entre categoría y área

  const PaginaDetalle({
    super.key, 
    required this.comida,
    this.heroTagPrefix,
  });

  @override
  Widget build(BuildContext context) {
    // Tag dinámico que funciona tanto para categorías como para áreas
    final String heroTag = heroTagPrefix ?? 'hero_${comida.nombre}_${comida.hashCode}';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          comida.nombre,
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
      body: Stack(
        children: [
          inicio.Background(),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Solo la imagen tiene animación Hero
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: heroTag, // Tag dinámico
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(comida.imagenUrl),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 300),
                        fadeOutDuration: Duration(milliseconds: 100),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/no-image.jpg',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Ingredientes
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
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
                        SizedBox(height: 10),
                        ...comida.ingredientes.map(
                          (ing) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(Icons.circle, size: 8, color: Colors.orange),
                                SizedBox(width: 8),
                                Expanded(child: Text(ing)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Instrucciones
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:[
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
                        SizedBox(height: 10),
                        ..._separarInstrucciones(comida.instrucciones).asMap().entries.map(
                              (entry) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${entry.key + 1}. ',
                                      style: TextStyle(fontWeight: FontWeight.bold),
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