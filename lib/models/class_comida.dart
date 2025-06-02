class Comida {
  final String nombre;
  final String imagenUrl;
  final List<String> ingredientes;
  final String instrucciones;
  //bool esFavorita;

  Comida({
    required this.nombre,
    required this.imagenUrl,
    required this.ingredientes,
    required this.instrucciones,
    //this.esFavorita = false,
  });
}