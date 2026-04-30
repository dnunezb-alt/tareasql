SELECT 
    empresa, 
    symbol,
    PrecioCierre, -- Para mostrar el precio actual
    PER, 
    Price_to_Sales
FROM View_Analisis_Cuantitativo
WHERE PER > 0  -- Filtramos empresas con pérdidas para evitar distorsiones
ORDER BY PER ASC
LIMIT 5;
SELECT 
    empresa, 
    symbol,
    PrecioCierre,
    PER, 
    Price_to_Sales
FROM View_Analisis_Cuantitativo
ORDER BY PER DESC
LIMIT 5;
SELECT 
    empresa, 
    symbol,
    PrecioCierre,
    Dividend_Yield * 100 AS Rentabilidad_Dividendo_Pct,
    Payout_Ratio
FROM View_Analisis_Cuantitativo
WHERE Dividend_Yield IS NOT NULL
ORDER BY Dividend_Yield DESC
LIMIT 5;