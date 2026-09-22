CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);
CREATE TABLE ubicacion (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);
CREATE TABLE unidad_medida (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(15),
    abreviatura VARCHAR(5)
);
CREATE TABLE tipo_envasado (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(15)
);
CREATE TABLE producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria_id INTEGER NOT NULL REFERENCES categoria(id),
    unidad_medida_id INTEGER NOT NULL REFERENCES unidad_medida(id),
    tipo_envasado_id INTEGER NOT NULL REFERENCES tipo_envasado(id)
);
CREATE TABLE movimiento (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER NOT NULL REFERENCES producto(id),
    ubicacion_id INTEGER NOT NULL REFERENCES ubicacion(id),
    cantidad_compra INTEGER NOT NULL,
    fecha_compra DATE NOT NULL
);
CREATE TABLE consumo (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER NOT NULL REFERENCES producto(id),
    cantidad INTEGER NOT NULL,
    fecha_consumo DATE NOT NULL
);