import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas/widgets/background.dart';
import '../providers/recipes_provier.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatelessWidget {
  final String idMeal;
  final String heroTag;
  final String imageUrl;
  final String mealName;

  const DetailPage({
    super.key,
    required this.idMeal,
    required this.heroTag,
    required this.imageUrl,
    required this.mealName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mealName,
          style: const TextStyle(
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
          FutureBuilder(
            future: Provider.of<RecipeProvider>(context, listen: false)
                .fetchRecipeById(idMeal),
            builder: (context, snapshot) {
              final recipe = Provider.of<RecipeProvider>(context).recipe;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (recipe == null) {
                return const Center(child: Text('No se encontró la receta'));
              }
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RecipeHeroImage(
                      heroTag: heroTag,
                      imageUrl: recipe.strMealPhoto,
                    ),
                    const SizedBox(height: 24),
                    _IngredientesCard(ingredientes: recipe.ingredientes),
                    const SizedBox(height: 20),
                    _InstruccionesCard(instrucciones: recipe.strInstructions),
                    // MOSTRAR VIDEO SOLO SI EXISTE
                    if (recipe.strYoutube != null && recipe.strYoutube!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _YoutubeVideoPlayer(
                              url: recipe.strYoutube!,
                            ),
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
  }
}

// Widget para la imagen principal con Hero
class _RecipeHeroImage extends StatelessWidget {
  final String heroTag;
  final String imageUrl;
  const _RecipeHeroImage({required this.heroTag, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Hero(
        tag: heroTag,
        child: Image.network(
          imageUrl,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Widget para la card de ingredientes
class _IngredientesCard extends StatelessWidget {
  final List<String> ingredientes;
  const _IngredientesCard({required this.ingredientes});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
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
            const SizedBox(height: 10),
            ...ingredientes.map(
              (ing) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 8, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(child: Text(ing)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para la card de instrucciones
class _InstruccionesCard extends StatelessWidget {
  final String instrucciones;
  const _InstruccionesCard({required this.instrucciones});

  @override
  Widget build(BuildContext context) {
    final pasos = _separarInstrucciones(instrucciones);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
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
            const SizedBox(height: 10),
            ...pasos.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.key + 1}. ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(entry.value)),
                      ],
                    ),
                  ),
                ),
          ],
        ),
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

class _YoutubeVideoPlayer extends StatefulWidget {
  final String url;
  const _YoutubeVideoPlayer({required this.url});

  @override
  State<_YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<_YoutubeVideoPlayer> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.url);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) return const SizedBox.shrink();
    return YoutubePlayer(
      controller: _controller!,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.orange,
      width: double.infinity,
    );
  }
}