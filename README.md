# Fake Store API - Dart Client

Aplicación de consola en Dart que consume la [Fake Store API](https://fakestoreapi.com/) para obtener datos ficticios de una tienda en línea. Implementa Clean Architecture, modelos inmutables con Freezed y manejo funcional de errores con Either de Dartz.

---

## Estructura del proyecto

```
bin/
  main.dart             # Punto de entrada, orquesta dependencias y muestra resultados
lib/
  core/
    api/                # Configuración de endpoints y base URL
    errors/             # Failure, executeApiCall y typedef Result<T>
  domain/
    entities/           # Clases puras sin dependencias externas
    repositories/       # Contratos abstractos de cada repositorio
  data/
    models/             # Modelos con fromJson, toJson y toEntity()
    datasources/        # Llamadas HTTP con Dio
    repositories/       # Implementaciones concretas de los contratos
test/
  core/
    errors/             # Tests de executeApiCall y Failure
```

---

## Endpoints consumidos

| Endpoint | Descripción |
|---|---|
| `GET /products` | Lista todos los productos disponibles |
| `GET /products/{id}` | Retorna el detalle de un producto específico |
| `GET /carts` | Lista todos los carritos de compra |
| `GET /users` | Lista todos los usuarios |
---

## Diseño de los modelos de datos

Se aplicó una separación entre **Entity** y **Model** siguiendo los principios de Clean Architecture:

- **Entity** vive en la capa `domain` y es una clase pura sin ninguna dependencia externa. Representa el dato tal como lo entiende la lógica de negocio.
- **Model** vive en la capa `data` y extiende la responsabilidad de la entity añadiendo `fromJson` para parsear la respuesta HTTP y `toEntity()` para convertirse en la entity correspondiente.

Todos los modelos y entities son **inmutables**, implementados con [Freezed](https://pub.dev/packages/freezed). Esto garantiza que ningún objeto puede ser modificado después de su creación. Cualquier cambio produce una nueva instancia a través de `copyWith`, dejando el original intacto.

Los modelos anidados como `CartProduct` dentro de `Cart` también siguen este patrón, mapeando la lista anidada en el `toEntity()` del modelo padre.

El campo `date` de `Cart` se parsea como `DateTime` en lugar de `String` para aprovechar el tipado fuerte de Dart.

---

## Solicitudes a la API

Se utilizó [Dio](https://pub.dev/packages/dio) configurado con `BaseOptions` para centralizar la URL base:

```
https://fakestoreapi.com
```

La responsabilidad está dividida en dos capas:

- **Datasource**: únicamente realiza la llamada HTTP y parsea el JSON hacia un Model. No conoce nada sobre errores de negocio ni Either.
- **Repository**: recibe los datos del datasource, los convierte a entities con `toEntity()` y delega el manejo de errores a `executeApiCall`.

---

## Control de errores con Either

Se utilizó [Dartz](https://pub.dev/packages/dartz) para manejar errores de forma funcional sin excepciones.

### typedef Result\<T\>

Para evitar repetir `Future<Either<Failure, T>>` en cada contrato, se definió un typedef:

```dart
typedef Result<T> = Future<Either<Failure, T>>;
```

### executeApiCall

Función genérica que envuelve cualquier llamada asíncrona y retorna un `Either`:

- Si la llamada es exitosa retorna `Right` con el dato.
- Si ocurre un `DioException` mapea el código HTTP a un `Failure` específico.
- Cualquier otra excepción retorna `Failure.unknown` con el mensaje del error.

| Código HTTP | Failure |
|---|---|
| `null` (sin respuesta) | `Failure.network()` |
| 401 | `Failure.unauthorized()` |
| 404 | `Failure.notFound()` |
| 500+ | `Failure.serverError()` |
| Otro | `Failure.unknown()` |

### Failure

Implementado como union type con Freezed, lo que permite manejar cada caso de forma exhaustiva con `when`. Incluye un getter `userMessage` con un mensaje legible por humanos para cada tipo de error.

---

## Cómo ejecutar el proyecto

```bash
# Instalar dependencias
dart pub get

# Generar código de Freezed
dart run build_runner build --delete-conflicting-outputs

# Ejecutar
dart run bin/main.dart
```

---

## Cómo ejecutar los tests

```bash
dart test
```