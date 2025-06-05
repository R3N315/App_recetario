class RecipeType {
  final String strMeal;
  final String strMealPhoto;
  final String idMeal;

  RecipeType({
    required this.strMeal,
    required this.strMealPhoto,
    required this.idMeal,
  });

  factory RecipeType.fromJson(Map<String, dynamic> json) {
    return RecipeType(
      strMeal: json['strMeal'] as String,
      strMealPhoto: json['strMealThumb'] as String,
      idMeal: json['idMeal'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'strMeal': strMeal,
      'strMealThumb': strMealPhoto,
      'idMeal': idMeal,
    };
  }

  @override
  String toString() {
    return 'RecipeType(strMeal: $strMeal, strMealThumb: $strMealPhoto, idMeal: $idMeal)';
  }
}