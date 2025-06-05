class Recipe {
  final String idMeal;
  final String strMeal;
  final String? strMealAlternate;
  final String strInstructions;
  final String strMealPhoto;
  final String? strYoutube;
  final List<String> ingredientes; // Lista combinada de ingrediente + medida

  Recipe({
    required this.idMeal,
    required this.strMeal,
    this.strMealAlternate,
    required this.strInstructions,
    required this.strMealPhoto,
    this.strYoutube,
    required this.ingredientes,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    // Combinar ingredientes y medidas en una lista
    List<String> ingredientesCombinados = [];
    for (int i = 1; i <= 10; i++) {
      final ingrediente = json['strIngredient$i'];
      final medida = json['strMeasure$i'];
      if (ingrediente != null &&
          ingrediente.toString().trim().isNotEmpty) {
        String combinado = medida != null && medida.toString().trim().isNotEmpty
            ? '$ingrediente - $medida'
            : ingrediente;
        ingredientesCombinados.add(combinado);
      }
    }

    return Recipe(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strMealAlternate: json['strMealAlternate'] as String?,
      strInstructions: json['strInstructions'] as String,
      strMealPhoto: json['strMealThumb'] as String,
      strYoutube: json['strYoutube'] as String?,
      ingredientes: ingredientesCombinados,
    );
  }

  Map<String, dynamic> toJson() {
    // No es necesario convertir ingredientes combinados de vuelta al JSON original
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealAlternate': strMealAlternate,
      'strInstructions': strInstructions,
      'strMealThumb': strMealPhoto,
      'strYoutube': strYoutube,
      // ingredientes combinados no se incluyen en el JSON original
    };
  }
}