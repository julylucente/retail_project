-- PRE-ENTREGA: ANÁLISIS AVANZADO CON WINDOW FUNCTIONS
-- Reporte de ventas mensuales por categoría.


-- 1. VENTAS MENSUALES
-- Agrupa las ventas por mes y categoría, calculando el monto total vendido.

WITH ventas_mensuales AS (
    SELECT
        DATE_TRUNC('month', v.fecha_venta) AS mes,
        p.categoria,
        SUM(v.cantidad * p.precio) AS venta_total
    FROM ventas v
    JOIN productos p
        ON v.id_producto = p.id_producto
    GROUP BY
        DATE_TRUNC('month', v.fecha_venta),
        p.categoria
),

-- 2. MÉTRICAS DE VENTANA
-- Calcula el ranking mensual y el acumulado de ventas por categoría.

metricas_ventana AS (
    SELECT
        mes,
        categoria,
        venta_total,

        RANK() OVER (
            PARTITION BY mes
            ORDER BY venta_total DESC
        ) AS ranking,

        SUM (venta_total) OVER (
            PARTITION BY categoria
            ORDER BY mes
        ) AS acumulado
    FROM ventas_mensuales
)

-- 3. COMPARACIÓN CON EL PROMEDIO HISTÓRICO
-- Compara la venta mensual con el promedio de ventas de la misma categoría.

SELECT
    mes,
    categoria,
    venta_total,
    ranking,
    acumulado,
    CASE
        WHEN venta_total >= AVG (venta_total) OVER (
            PARTITION BY categoria
        ) THEN 'Exitoso'
        ELSE 'Bajo el promedio'
    END AS comparativa
FROM metricas_ventana
ORDER BY mes, ranking;