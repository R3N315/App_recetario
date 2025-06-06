# Recetario JR

Aplicación Flutter para explorar, buscar y guardar recetas del mundo, con navegación intuitiva, favoritos y detalles enriquecidos.

---

## ✨ Funcionalidades principales

- **Explora recetas por categoría y región:**  
  Navega por sliders de recetas agrupadas por tipo de comida (desayunos, pollo, pasta, etc.) o por país/región (mexicana, italiana, japonesa, etc.).

- **Detalle de receta:**  
  Visualiza ingredientes, instrucciones paso a paso y, si está disponible, un video de YouTube embebido para la preparación.

- **Favoritos:**  
  Marca y desmarca recetas como favoritas desde cualquier slider o desde la página de detalles. Consulta y gestiona tus recetas favoritas en una sección dedicada.

- **Animaciones Hero y sliders:**  
  Transiciones suaves entre la lista y el detalle de cada receta, deslizamiento entre pantallas (home, categorias, paises, favoritos), icono de favoritos animado, deslizamiento en secciones de recetas.

- **Carga de imágenes con placeholder:**  
  Mientras se carga la imagen de una receta, se muestra un asset local (`no-image.jpg`).

- **Videos explicativos de recetas:**  
  Se muestra un video de cómo hacer la receta cuando la API contiene este video.

- **Icono y nombre de la App:**  
  La app contiene un icono y un nombre personalizados.

---

## 🧩 Widgets y componentes personalizados

- `MainScaffold`: Estructura principal con navegación y barra inferior.
- `RecipeTypeSlider`: Slider horizontal reutilizable para mostrar recetas por categoría o región.
- `FavRecipeCard`: Card para mostrar recetas favoritas.
- `DetailPage`: Página de detalle de receta, modularizada en widgets para ingredientes, instrucciones y video.
- `Background`: Fondo decorativo con gradiente y formas.

---

## 📦 Librerías utilizadas

- [`provider`](https://pub.dev/packages/provider): Gestión de estado.
- [`http`](https://pub.dev/packages/http): Consumo de API REST.
- [`youtube_player_flutter`](https://pub.dev/packages/youtube_player_flutter): Reproductor de videos de YouTube embebido.
- [`cupertino_icons`](https://pub.dev/packages/cupertino_icons): Iconos iOS.
- [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons): Personalización de íconos de la app.

---

## 🌐 API utilizada

- [TheMealDB](https://www.themealdb.com/api.php):  
  API pública para obtener recetas, ingredientes, instrucciones, imágenes y videos.

---

## 📁 Estructura de carpetas y archivos

```
lib/
│
├── main.dart
├── models/
│   ├── recipe_type_model.dart      # Modelo para recetas resumidas (sliders)
│   └── recipes_model.dart          # Modelo para detalle de receta
│
├── providers/
│   ├── recipe_type_provider.dart   # Provider global para favoritos
│   └── recipes_provier.dart        # Provider para obtener receta por ID
│
├── widgets/
│   ├── main_scaffold.dart          # Cascarón principal con navegación
│   ├── background.dart             # Fondo decorativo
│   └── recipe_type_slider.dart     # Slider horizontal de recetas
│
├── pages/
│   ├── home_page.dart              # Portada de la app
│   ├── category_page.dart          # Recetas por categoría
│   ├── region_page.dart            # Recetas por región/país
│   ├── favs_page.dart              # Página de favoritos
│   └── detail_page.dart            # Detalle de receta (ingredientes, instrucciones, video)
│
assets/
│   ├── libro-recetas.ico           # Icono para la app
│   ├── recetas.jpeg                # Imagen portada
│   └── no-image.jpg                # Placeholder para imágenes
│
pubspec.yaml
```


---

## 📌 Notas adicionales

- El video de YouTube solo aparece si la receta contiene el campo `strYoutube`.
- El diseño es responsivo y optimizado para móviles.

---

## 📞 Créditos y agradecimientos

- Hecho por: [Gael de Jesús Posada Hernández](https://github.com/GaaloP) y [Rene Tellez Carmona](https://github.com/R3N315)

- API: [TheMealDB](https://www.themealdb.com/api.php)
- Iconos: [Material Icons](https://fonts.google.com/icons)
- Flutter & comunidad open source
