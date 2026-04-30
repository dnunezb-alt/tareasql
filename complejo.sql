SELECT 
    v.empresa, 
    v.symbol, 
    v.PER, 
    r.Crecimiento_Ingresos_Pct,
    v.Debt_to_Equity AS Ratio_Deuda
FROM View_Analisis_Cuantitativo v
JOIN View_Crecimiento_Riesgo_Operativo r ON v.symbol = r.symbol AND v.fecha = r.fecha
WHERE v.PER BETWEEN 1 AND 15
  AND v.Debt_to_Equity < 0.5
  AND r.Crecimiento_Ingresos_Pct > 0
ORDER BY v.Debt_to_Equity ASC
LIMIT 10;
SELECT 
    v.empresa, 
    v.symbol, 
    v.PER, 
    r.Crecimiento_Ingresos_Pct,
    r.Crecimiento_Deuda_Pct
FROM View_Analisis_Cuantitativo v
JOIN View_Crecimiento_Riesgo_Operativo r ON v.symbol = r.symbol AND v.fecha = r.fecha
WHERE v.PER <= 25
  AND r.Crecimiento_Ingresos_Pct > 15
  AND r.Crecimiento_Deuda_Pct > 0 -- Están usando deuda para crecer
ORDER BY r.Crecimiento_Ingresos_Pct DESC
LIMIT 10;
SELECT 
    v.empresa, 
    v.symbol, 
    r.Crecimiento_Ingresos_Pct,
    v.MarketCap,
    v.PER AS PER_Actual -- Probablemente sea NULL o muy alto
FROM View_Analisis_Cuantitativo v
JOIN View_Crecimiento_Riesgo_Operativo r ON v.symbol = r.symbol AND v.fecha = r.fecha
WHERE r.Crecimiento_Ingresos_Pct > 40
ORDER BY r.Crecimiento_Ingresos_Pct DESC
LIMIT 10;