import 'package:flutter/material.dart';
import 'package:recetas/models/class_comida.dart';
import 'package:recetas/pages/detalles_platillo.dart';

class RecipeTypeSlider extends StatelessWidget {
  final String nombreCategoria;
  final List<Comida> comidas;

  const RecipeTypeSlider({
    super.key,
    required this.nombreCategoria,
    required this.comidas,
  });

  @override
  Widget build(BuildContext context) {
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
              itemCount: comidas.length,
              itemBuilder: (_, int index) {
                return RecipePoster(
                  comidas[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class RecipePoster extends StatefulWidget {
  final Comida comida;

  const RecipePoster(
    this.comida, {
    super.key,
  });

  @override
  State<RecipePoster> createState() => RecipePosterState();
}

class RecipePosterState extends State<RecipePoster> {
  bool esFavorita = false;

  @override
  Widget build(BuildContext context) {
    // Tag único para Hero que incluye categoría e índice
    final String heroTag = 'hero_${widget.comida.nombre}';
    
    return Container(
      width: 110,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  try {
                    await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PaginaDetalle(comida: widget.comida),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  } catch (e) {
                    debugPrint('Error en navegación: $e');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Hero(
                            tag: heroTag, // Usar el tag único
                            child: Image.network(
                              widget.comida.imagenUrl,
                              width: 110,
                              height: 160,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.orange,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 110,
                                  height: 160,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          widget.comida.nombre,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      esFavorita = !esFavorita;
                    });
                  },
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      esFavorita ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey<bool>(esFavorita),
                      color: esFavorita ? Colors.red : Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
