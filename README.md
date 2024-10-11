# Crypto Exchange

Este proyecto es una API de transacciones que permite a los usuarios autenticarse, gestionar transacciones en diferentes monedas, y consultar el precio del Bitcoin. La API está protegida mediante autenticación JWT y ofrece endpoints para registro, autenticación y operaciones con transacciones.

## Características

- Autenticación de usuarios con JWT.
- Gestión de transacciones en distintas monedas (USD, BTC).
- Consulta del precio actual de Bitcoin en USD.
- Documentación interactiva de la API mediante Swagger.

---

## Requisitos previos

### Para ejecutar sin Docker:

1. **Ruby**: Asegúrate de tener instalado Ruby (versión 3.0.0 o superior).
2. **Rails**: Necesitas tener instalado Rails (versión 6.1 o superior).
3. **PostgreSQL**: Asegúrate de tener PostgreSQL instalado y en ejecución.

### Para ejecutar con Docker:

1. **Docker**: Debes tener instalado Docker y Docker Compose.
2. **Docker Compose**: Usaremos `docker-compose` para construir y ejecutar los contenedores de la aplicación.

---

## Instrucciones para ejecutar el proyecto

### Sin Docker

1. Clona el repositorio:

   ```bash
   git clone https://github.com/andresguaita/crypto-transaction-api.git
   cd crypto-transaction-api
   ```

2. Instala las dependencias:

   ```bash
   bundle install
   ```

3. Configura las variables de entorno:

   Crea un archivo `.env` basado en el archivo `.env.example` y completa las variables de entorno necesarias, como las credenciales de la base de datos PostgreSQL y claves secretas.

4. Crea y migra la base de datos:

   ```bash
   rails db:create
   rails db:migrate
   ```

5. Inicia el servidor:

   ```bash
   rails s
   ```

6. Accede a la API:

   La API estará disponible en `http://localhost:3000`.

### Con Docker

1. Clona el repositorio:

   ```bash
   git clone https://github.com/andresguaita/crypto-transaction-api.git
   cd crypto-transaction-api
   ```

2. Configura las variables de entorno:

   Crea un archivo `.env` basado en el archivo `.env.example` y completa las variables de entorno necesarias.

3. Construye y levanta los contenedores:

   ```bash
   docker-compose up --build
   ```

4. Accede a la API:

   La API estará disponible en `http://localhost:3000` dentro del contenedor.

---

## Datos de prueba para login

### Usuario de prueba:

- **Email**: `john.doe@example.com`
- **Password**: `password123`

Puedes usar estos datos para autenticarte y obtener un **Bearer Token**. A continuación te mostramos cómo probar los endpoints.

---

## Endpoints disponibles

1. **Autenticación (Login)**:

   - **POST** `/login`
   - Parámetros:
     ```json
     {
       "email": "john.doe@example.com",
       "password": "password123"
     }
     ```
   - **Respuesta exitosa**:
     ```json
     {
       "token": "Bearer <JWT_TOKEN>"
     }
     ```

2. **Registro (Register)**:

   - **POST** `/register`
   - Parámetros:
     ```json
     {
       "name": "John Doe",
       "email": "john.doe@example.com",
       "password": "password123",
       "password_confirmation": "password123"
     }
     ```
   - **Respuesta exitosa**:
     ```json
     {
       "user": {
         "id": 1,
         "name": "John Doe",
         "email": "john.doe@example.com"
       },
       "token": "Bearer <JWT_TOKEN>"
     }
     ```

3. **Consultar transacciones por usuario**:

   - **GET** `/users/:user_id/transactions`
   - **Headers**: Necesita el header `Authorization: Bearer <JWT_TOKEN>`
   - **Respuesta exitosa**:
     ```json
     [
       {
         "id": 1,
         "user_id": 1,
         "currency_sent": "USD",
         "currency_received": "BTC",
         "amount_sent": "1000.0",
         "amount_received": "0.02",
         "finalize_at": "2024-10-10",
         "created_at": "2024-10-10T15:37:38.315Z",
         "updated_at": "2024-10-10T15:37:38.315Z"
       },
       {
         "id": 2,
         "user_id": 1,
         "currency_sent": "USD",
         "currency_received": "BTC",
         "amount_sent": "1000.0",
         "amount_received": "0.02",
         "finalize_at": "2024-10-10",
         "created_at": "2024-10-10T17:03:58.510Z",
         "updated_at": "2024-10-10T17:03:58.510Z"
       }
     ]
     ```

4. **Crear una transacción**:

   - **POST** `/transactions`
   - **Headers**: Necesita el header `Authorization: Bearer <JWT_TOKEN>`
   - **Respuesta exitosa**:
     ```json
     {
       "id": 1,
       "user_id": 1,
       "currency_sent": "USD",
       "currency_received": "BTC",
       "amount_sent": "1000.0",
       "amount_received": "0.01650344",
       "finalize_at": "2024-10-11",
       "created_at": "2024-10-11T06:08:24.649Z",
       "updated_at": "2024-10-11T06:08:24.649Z"
     }
     ```

5. **Consultar una transaccion**:

   - **GET** `/transactions/:transaction_id`
   - **Headers**: Necesita el header `Authorization: Bearer <JWT_TOKEN>`
   - **Respuesta exitosa**:
     ```json
     {
       "id": 1,
       "user_id": 1,
       "currency_sent": "USD",
       "currency_received": "BTC",
       "amount_sent": "1000.0",
       "amount_received": "0.02",
       "finalize_at": "2024-10-10",
       "created_at": "2024-10-10T15:37:38.315Z",
       "updated_at": "2024-10-10T15:37:38.315Z"
     }
     ```

6. **Consultar el precio de Bitcoin**:
   - **GET** `/bitcoin_price`
   - **Respuesta exitosa**:
     ```json
     {
       "btc_price_in_usd": 50000
     }
     ```

---

## Documentación de la API

La documentación completa de la API está disponible en la siguiente ruta:

- **Swagger UI**: `http://localhost:3000/api-docs`


Desde la interfaz de Swagger UI, puedes probar cada endpoint de manera interactiva.

---
