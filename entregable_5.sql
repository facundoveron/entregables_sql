-- CREACIÓN DE BASE DE DATOS

CREATE DATABASE retail_project;

-- DDL - CREACIÓN DE TABLAS

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    edad INT CHECK (edad >= 18)
);

CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE ventas (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    fecha DATE NOT NULL,

    CONSTRAINT fk_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(id)
        ON DELETE RESTRICT
);

-- DML - CARGA INICIAL DE DATOS

BEGIN;

-- Clientes
INSERT INTO clientes (nombre, email, edad) VALUES
('Juan Pérez', 'juan@email.com', 25),
('María Gómez', 'maria@email.com', 30),
('Carlos Ruiz', 'carlos@email.com', 42),
('Ana López', 'ana@email.com', 28),
('Lucía Fernández', 'lucia@email.com', 35);

-- Productos
INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Notebook Lenovo', 'Tecnología', 1200.00, 10),
('Mouse Logitech', 'Tecnología', 25.50, 50),
('Teclado Redragon', 'Tecnología', 60.00, 25),
('Silla Gamer', 'Muebles', 350.00, 8),
('Escritorio', 'Muebles', 450.00, 12);

-- Ventas
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES
(1,1,1,'2026-07-01'),
(2,2,2,'2026-07-02'),
(3,3,1,'2026-07-03'),
(4,4,1,'2026-07-04'),
(5,5,2,'2026-07-05');

COMMIT;

-- MANTENIMIENTO

-- Verificar antes de actualizar
SELECT *
FROM productos
WHERE categoria = 'Tecnología';

-- Aumentar un 10% el precio de los productos de Tecnología
UPDATE productos
SET precio = precio * 1.10
WHERE categoria = 'Tecnología';

-- Verificar antes de eliminar
SELECT *
FROM ventas
WHERE id = 5;

-- Eliminar una venta específica
DELETE FROM ventas
WHERE id = 5;
