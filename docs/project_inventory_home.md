---
type: study-note
fileClass: study-note
area: learning
status: open
updated: 2026-09-22
url:
hub: "[[learning/Programming/Programming|Programming]]"
---

# Inventory Home

**description:** Documentación de la base de datos para la gestión del almacenamiento de alimentos.

# Proyecto: Gestión de Almacenamiento de Alimentos en el Hogar

## Objetivo del Proyecto
El propósito de este modelo es simplificar la gestión del inventario de alimentos en el hogar para resolver tres problemas pprincipales:

1. **Control de Inventario:** Saber cuánto stock hay de cada producto para evitar compras innecesarias.
2. **Gestión de Ubicación:** Saber en que lugar están los alimentos (Bodega, Refrigerador, Despensa).
3. **Optimización de Procesos:** Estandarizar la entrada de productos para mantener un registro ordenado y evitar errores de duplicidad o ambigüedad.

---

## Modelo de Datos

### 1. Entidad: producto
Es la entidad central que registra los alimentos.
* `id` (PK, integer): Identificador único.
* `nombre` (varchar): Nombre del alimento.
* `categoria_id` (FK, integer): Relación con la entidad categoria. Cardinalidad: N:1 (muchos productos pueden compartir una categoria).
* `unidad_medida_id` (FK, integer): Relación con la entidad unidad_medida. Cardinalidad: N:1 (muchos productos pueden compartir una unidad_medida).
* `tipo_envasado_id` (FK, integer): Relación con la entidad tipo_envasado. Cardinalidad: N:1 (muchos productos pueden compartir un tipo_envasado).

### 2. Entidad: movimiento
Registra cada compra o ingreso de un producto. Es insert-only: nunca se actualiza una fila
existente.
* `id` (PK, integer): Identificador único.
* `producto_id` (FK, integer): Producto relacionado al movimiento.
* `ubicacion_id` (FK, integer): Relación con la entidad ubicacion. Cardinalidad: N:1 (muchos productos pueden compartir una ubicacion).
* `cantidad_compra` (numeric): Cantidad ingresada en esa compra.
* `fecha_compra` (date): Fecha de la compra o ingreso.

### 3. Entidad: consumo
Registra cada consumo (total o parcial) de un producto. Es insert-only, igual que
`movimiento`: consumir en partes es una fila nueva por cada parte, nunca una modificación
de una fila anterior. Referencia `producto_id` directo — resta del stock global de ese
producto, no de un movimiento ni una ubicación puntual.
* `id` (PK, integer): Identificador único.
* `producto_id` (FK, integer): Producto relacionado al consumo.
* `cantidad` (numeric): Cantidad consumida.
* `fecha_consumo` (date): Fecha del consumo.

### 4. Entidad: categoria
Clasifica los alimentos para facilitar la organización.
* `id` (PK, integer): Identificador único.
* `nombre` (varchar): Nombre de la categoría (ej. Lácteos, Granos, Bebidas).

### 5. Entidad: ubicacion
Define los lugares físicos donde se almacenan los productos.
* `id` (PK, integer): Identificador único.
* `nombre` (varchar): Nombre del lugar (ej. Refrigerador, Despensa, Bodega).

### 6. Entidad: unidad_medida
Estandariza las cantidades de los productos.
* `id` (PK, integer): Identificador único.
* `nombre` (varchar): Nombre de la unidad (ej. Kilos, Litros, Unidades).
* `abreviatura` (varchar): Representación corta (ej. kg, L, un).

### 7. Entidad: tipo_envasado
Categoriza el tipo de envase para mejorar el orden y la gestión.
* `id` (PK, integer): Identificador único.
* `nombre` (varchar): Nombre del material o tipo de envase (ej. Lata, Vidrio, Plástico).