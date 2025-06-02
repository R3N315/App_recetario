import 'package:flutter/material.dart';
import 'package:recetas/pages/detalles_platillo.dart';
import 'package:recetas/pages/pag_inicio.dart' as inicio;
import '../models/class_comida.dart';

class Area {
  final String nombre;
  final List<Comida> comidas;

  Area({required this.nombre, required this.comidas});
}

class Pag_area extends StatelessWidget {
  const Pag_area({super.key});

  @override
  Widget build(BuildContext context) {
    final areas = [
      Area(
        nombre: 'Mexicana',
        comidas: [
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
        ]
      ),
      Area(
        nombre: 'Italiana',
        comidas: [
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
        ]
      ),
      Area(
        nombre: 'Japonesa',
        comidas: [
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
        ]
      ),
    ];
  
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recetas por Area',
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
          inicio.Background(),
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: areas
                    .map((area) => AreaSlider(area: area))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AreaSlider extends StatelessWidget {
  final Area area;

  const AreaSlider({Key? key, required this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              area.nombre,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: area.comidas.length,
              itemBuilder: (_, int index) {
                return _ComidaPoster(
                  area.comidas[index],
                  areaIndex: area.nombre,
                  itemIndex: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ComidaPoster extends StatefulWidget {
  final Comida comida;
  final String areaIndex;
  final int itemIndex;

  const _ComidaPoster(
    this.comida, {
    Key? key,
    required this.areaIndex,
    required this.itemIndex,
  }) : super(key: key);

  @override
  State<_ComidaPoster> createState() => _ComidaPosterState();
}

class _ComidaPosterState extends State<_ComidaPoster> {
  bool esFavorita = false;

  @override
  Widget build(BuildContext context) {
    // Tag único para Hero que incluye area e índice
    final String heroTag = 'hero_${widget.areaIndex}_${widget.itemIndex}_${widget.comida.nombre}';
    
    return Container(
      width: 110,
      margin: EdgeInsets.symmetric(horizontal: 10),
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
                        transitionDuration: Duration(milliseconds: 300),
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
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
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
                          style: const TextStyle(
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
                    duration: 
                    Duration(milliseconds: 300),
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