-- CREACIÓN DE TABLA CATEGORÍAS

CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);


-- CARGA DE DATOS EN CATEGORÍAS

INSERT INTO categorias (nombre)
VALUES
    ('Bazar'),
    ('Tecnologia'),
    ('Libreria');


-- AGREGAR RELACIÓN ENTRE PRODUCTOS Y CATEGORÍAS

ALTER TABLE productos
ADD COLUMN id_categoria INTEGER;


-- ASIGNACIÓN DE CATEGORÍAS A PRODUCTOS

UPDATE productos p
SET id_categoria = c.id_categoria
FROM categorias c
WHERE p.categoria = c.nombre;


-- 1. RENTABILIDAD POR CATEGORÍA
-- Permite identificar las categorías que generan mayores ingresos y unidades vendidas.
-- Se establece un umbral de ingresos superior a $10.000 para identificar las categorías
-- de mayor impacto comercial y priorizarlas en decisiones de reposición de stock.

SELECT
    c.nombre AS categoria,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio) AS ingresos_totales
FROM ventas v
JOIN productos p
    ON v.id_producto = p.id_producto
JOIN categorias c
    ON p.id_categoria = c.id_categoria
GROUP BY c.nombre
HAVING SUM(v.cantidad * p.precio) > 10000;


-- 2. CLIENTES SIN COMPRAS
-- Permite identificar clientes registrados que todavía no realizaron compras,
-- para detectar oportunidades de activación o seguimiento comercial.
-- COALESCE permite mostrar 0 en lugar de NULL para los clientes sin compras.

SELECT
    c.nombre AS cliente,
    COALESCE(SUM(v.cantidad), 0) AS total_compras
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
GROUP BY c.id_cliente, c.nombre;


-- 3. TOP DE COMPRAS POR CLIENTE
-- Permite identificar el producto que más compra cada cliente
-- y conocer la fecha de su última transacción.

WITH compras_cliente AS (
    SELECT
        c.id_cliente,
        c.nombre AS cliente,
        p.nombre AS producto,
        SUM(v.cantidad) AS cantidad_comprada,
        MAX(v.fecha_venta) AS ultima_transaccion,
        ROW_NUMBER() OVER (
            PARTITION BY c.id_cliente
            ORDER BY SUM(v.cantidad) DESC
        ) AS posicion
    FROM clientes c
    JOIN ventas v
        ON c.id_cliente = v.id_cliente
    JOIN productos p
        ON v.id_producto = p.id_producto
    GROUP BY c.id_cliente, c.nombre, p.id_producto, p.nombre
)
SELECT
    cliente,
    producto,
    cantidad_comprada,
    ultima_transaccion
FROM compras_cliente
WHERE posicion = 1;
   
