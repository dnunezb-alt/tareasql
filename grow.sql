CREATE OR REPLACE VIEW View_Crecimiento_Riesgo_Operativo AS 
WITH Base_Datos AS (
    SELECT 
        C.symbol,
        C.nombre AS empresa,
        F.fecha,
        F.Ingresos,
        F.Ganancias,
        (F.Ingresos - F.Ganancias) AS Gastos_Derivados,
        D.DeudaTotal,
        M.PrecioCierre,
        M.MarketCap,
        -- Traer valores del periodo anterior (Todos deben estar aquí)
        LAG(F.Ingresos) OVER (PARTITION BY C.symbol ORDER BY F.fecha) AS ingresos_prev,
        LAG(F.Ganancias) OVER (PARTITION BY C.symbol ORDER BY F.fecha) AS ganancias_prev,
        LAG(F.Ingresos - F.Ganancias) OVER (PARTITION BY C.symbol ORDER BY F.fecha) AS gastos_prev,
        LAG(D.DeudaTotal) OVER (PARTITION BY C.symbol ORDER BY D.fecha) AS deuda_prev,
        LAG(M.PrecioCierre) OVER (PARTITION BY C.symbol ORDER BY M.fecha) AS precio_prev,
        LAG(M.MarketCap) OVER (PARTITION BY C.symbol ORDER BY M.fecha) AS marketcap_prev
    FROM Company C
    JOIN Financial_Reports F ON C.symbol = F.symbol
    JOIN Debt_Structure D ON F.symbol = D.symbol AND F.fecha = D.fecha
    JOIN Market_Data M ON F.symbol = M.symbol AND F.fecha = M.fecha
) 
SELECT 
    symbol,
    empresa,
    fecha,
    -- 1. Crecimiento de lo "Bueno"
    ROUND(((Ingresos - ingresos_prev) / NULLIF(ingresos_prev, 0)) * 100, 2) AS Crecimiento_Ingresos_Pct,
    ROUND(((Ganancias - ganancias_prev) / NULLIF(ganancias_prev, 0)) * 100, 2) AS Crecimiento_Ganancias_Pct,
    ROUND(((PrecioCierre - precio_prev) / NULLIF(precio_prev, 0)) * 100, 2) AS Crecimiento_Precio_Pct,
    ROUND(((MarketCap - marketcap_prev) / NULLIF(marketcap_prev, 0)) * 100, 2) AS Crecimiento_MarketCap_Pct,
    
    -- 2. Crecimiento de lo "Malo"
    ROUND(((Gastos_Derivados - gastos_prev) / NULLIF(gastos_prev, 0)) * 100, 2) AS Crecimiento_Gastos_Pct,
    ROUND(((DeudaTotal - deuda_prev) / NULLIF(deuda_prev, 0)) * 100, 2) AS Crecimiento_Deuda_Pct,
    
    -- 3. Indicador de Alerta (Diferencial)
    ROUND(
        (((Gastos_Derivados - gastos_prev) / NULLIF(gastos_prev, 0)) * 100) - 
        (((Ingresos - ingresos_prev) / NULLIF(ingresos_prev, 0)) * 100)
    , 2) AS Alerta_Eficiencia_Negativa
FROM Base_Datos;                                                                             