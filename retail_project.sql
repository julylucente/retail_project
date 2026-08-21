-- Crear la base de datos
CREATE DATABASE retail_project;

-- Crear la tabla de clientes
CREATE TABLE clientes ( 
   id_cliente SERIAL PRIMARY KEY,
   nombre VARCHAR (100) NOT NULL,
   apellido VARCHAR (100) NOT NULL,
   email VARCHAR (150) UNIQUE NOT NULL, 
   edad INTEGER CHECK (edad >= 18)
   );

-- Crear la tabla de productos
CREATE TABLE productos (
   id_producto SERIAL PRIMARY KEY,
   nombre VARCHAR (100) NOT NULL,
   categoria VARCHAR (100) NOT NULL,
   precio DECIMAL(10,2) CHECK (precio > 0),
   stock INT CHECK (stock >= 0)
   );

-- Crear la tabla de ventas
CREATE TABLE ventas (
   id_venta SERIAL PRIMARY KEY,
   id_cliente INTEGER,
   id_producto INTEGER,
   cantidad INTEGER CHECK (cantidad > 0),
   fecha_venta DATE NOT NULL,
  
-- Restricciones de claves foráneas
    CONSTRAINT fk_ventas_clientes
     FOREIGN KEY (id_cliente)
     REFERENCES clientes (id_cliente),
     
    CONSTRAINT fk_ventas_productos
     FOREIGN KEY (id_producto)
     REFERENCES productos (id_producto)
     );
    
-- Carga inicial de datos
    BEGIN;
    INSERT INTO clientes (
       nombre,
       apellido,
       email,
       edad
    )
   VALUES 
     ('Emiliano', 'Martinez', 'emi.martinez@gmail.com', 29),
     ('Juan', 'Carranza', 'carranzaj@gmail.com', 36),
     ('Sofia', 'Calviño', 'soficalvi@gmail.com', 22),
     ('Melissa', 'Torres', 'torresmelissa@gmail.com', 25),
     ('Anibal', 'Carrion', 'carrion.anibal@gmail.com', 27);
    
   INSERT INTO productos (
       nombre, 
       categoria,
       precio,
       stock
    )
    VALUES
       ('Lapiz', 'Libreria', 350, 5),
       ('Vaso plástico', 'Bazar', 3000, 10),
       ('Tijeras', 'Libreria', 2000, 3),
       ('Cable USB', 'Tecnologia', 10000, 7),
       ('Lapicera', 'Libreria', 900, 9);
   
   INSERT INTO ventas (
       id_cliente,
       id_producto,
       cantidad,
       fecha_venta
    )
    VALUES 
       (1, 1, 2, '2026-08-10'),
       (2, 3, 1, '2026-08-11'),
       (3, 2, 4, '2026-08-12'),
       (4, 5, 3, '2026-08-13'),
       (5, 4, 5, '2026-08-14');
   
    COMMIT;
    
-- Verificar productos de la categoria Libreria
    SELECT *
    FROM productos
    WHERE categoria = 'Libreria';
        
-- Actualizar precios de una categoria de productos
    UPDATE productos
    SET precio = precio * 1.10
    WHERE categoria = 'Libreria';


-- Verificar la venta a eliminar
    SELECT *
    FROM ventas
    WHERE id_venta = 5;

-- Eliminar venta específica
   DELETE FROM VENTAS 
   WHERE id_venta = 5;

