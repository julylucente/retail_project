# Retail Project

Proyecto realizado en PostgreSQL para la materia.

## Contenido

- Creación de la base de datos retail_project.
- Creación de las tablas clientes, productos y ventas.
- Uso de PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK y NOT NULL.
- Carga inicial de datos mediante una transacción (BEGIN ... COMMIT).
- Actualización de precios mediante UPDATE.
- Eliminación de una venta específica mediante DELETE.

## Cómo ejecutar

1. Crear la base de datos.
2. Ejecutar el archivo retail_project.sql.


## Pre-entrega Módulo 4

El archivo `pre-entrega-modulo4.sql` contiene tres consultas orientadas a resolver problemas de negocio:

- *Rentabilidad por categoría:* identifica las categorías con mayores ingresos y unidades vendidas, utilizando un umbral comercial para priorizar decisiones de reposición de stock.
- *Clientes sin compras:* identifica clientes registrados que todavía no realizaron compras y utiliza `COALESCE` para mostrar 0 en lugar de valores nulos.
- *Top de compras por cliente:* identifica el producto más comprado por cada cliente y la fecha de su última transacción.

Las consultas utilizan JOINs, funciones agregadas, GROUP BY, HAVING, CTEs, funciones de ventana y alias de tablas.

### Cómo ejecutar la pre-entrega

1. Crear y cargar previamente la base de datos ejecutando `retail_project.sql`.
2. Ejecutar el archivo `pre-entrega-modulo4.sql` sobre la base de datos `retail_project`.
