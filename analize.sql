USE tarea;
CREATE OR REPLACE VIEW View_Analisis_Cuantitativo AS
SELECT 
    C.symbol,
    C.nombre AS empresa,
    S.nombre AS sector,
    F.fecha,
    
    -- 1. VALORACIÓN
    M.MarketCap,
    (M.MarketCap / NULLIF(F.Ganancias, 0)) AS PER,
    (M.MarketCap / NULLIF(F.Ingresos, 0)) AS Price_to_Sales,
    -- Book Value simplificado como Activos - DeudaTotal
    (M.MarketCap / NULLIF(F.Activos - D.DeudaTotal, 0)) AS P_BV,

    -- 2. RENTABILIDAD
    (F.Ganancias / NULLIF(F.Ingresos, 0)) AS Margen_Neto,
    (F.Ganancias / NULLIF(F.Activos - D.DeudaTotal, 0)) AS ROE,
    (F.Ganancias / NULLIF(F.Activos, 0)) AS ROA,

    -- 3. SALUD FINANCIERA
    (D.DeudaTotal / NULLIF(F.Activos - D.DeudaTotal, 0)) AS Debt_to_Equity,
    (D.Cash / NULLIF(D.DeudaTotal, 0)) AS Cash_to_Debt,
    
    -- 4. DIVIDENDOS
    (Div.Monto / NULLIF(M.MarketCap, 0)) AS Dividend_Yield,
    (Div.Monto / NULLIF(F.Ganancias, 0)) AS Payout_Ratio

FROM Company C
JOIN Sectors S ON C.id_sector = S.id_sector
JOIN Financial_Reports F ON C.symbol = F.symbol
JOIN Debt_Structure D ON F.symbol = D.symbol AND F.fecha = D.fecha
JOIN Market_Data M ON F.symbol = M.symbol AND F.fecha = M.fecha
LEFT JOIN Dividends Div ON F.symbol = Div.symbol AND F.fecha = Div.fecha;