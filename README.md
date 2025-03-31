# ProjectRM

Una aplicación iOS construida con SwiftUI basada en la API de **Rick & Morty**. Este proyecto sigue una arquitectura modular y limpia, separando claramente las capas de presentación, dominio y datos.

## 🧠 Arquitectura

Este proyecto está inspirado en principios de **Clean Architecture**, separando responsabilidades en tres capas principales:

- **Features (Presentación)**: Contiene las vistas SwiftUI, los `ViewModels` y componentes reutilizables.
- **Domain**: Define los modelos de dominio y casos de uso (lógica de negocio pura).
- **Data**: Contiene los DTOs, mapeadores, y repositorios que gestionan el acceso a los datos.

## 🚀 Cómo empezar

1. Clona el repositorio.
2. Abre `ProjectRM.xcodeproj` o `.xcworkspace` en Xcode.
3. Ejecuta en el simulador o dispositivo.
