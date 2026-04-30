import yfinance as yf
import pandas as pd
from datetime import datetime

# Lista de empresas que quieres consultar
tickers = ["AAPL", "MSFT", "GOOGL", "AMZN"]
lista_datos = []

for t in tickers:
    stock = yf.Ticker(t)
    info = stock.info
    
    # Extraer variables solicitadas
    datos = {
        "Symbol": info.get("symbol"),
        "Nombre": info.get("longName"),
        "Industria": info.get("industry"),
        "Pais": info.get("country"),
        "Actual CEO": info.get("companyOfficers", [{}])[0].get("name", "N/A"),
        "Ingresos Netos Anuales": info.get("netIncomeToCommon"),
        "Ganancias": info.get("grossProfits"),
        "Activos": info.get("totalAssets"),
        "Deuda Total": info.get("totalDebt"),
        "Cash": info.get("totalCash"),
        "Monto Dividendos": info.get("dividendRate"),
        "Market Cap": info.get("marketCap"),
        "Num Empleados": info.get("fullTimeEmployees"),
        "Precio Cierre": info.get("previousClose"),
        "Fecha Consulta Market Cap": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    }
    lista_datos.append(datos)

# Crear tabla y guardar a CSV
df = pd.DataFrame(lista_datos)
df.to_csv("datos_bolsa.csv", index=False, encoding='utf-8')
print("¡Archivo datos_bolsa.csv creado con éxito!")



'''

import yfinance as yf
import pandas as pd
from datetime import datetime

# 1. Obtener automáticamente la lista de tickers del S&P 500 desde Wikipedia
print("Obteniendo lista del S&P 500...")
url = 'https://wikipedia.org'
tabla = pd.read_html(url)
df_sp500 = tabla[0]
tickers = df_sp500['Symbol'].tolist()

lista_datos = []

# 2. Recorrer cada empresa y extraer los datos
print(f"Iniciando extracción de {len(tickers)} empresas. Esto puede tardar...")

for t in tickers:
    try:
        # Reemplazar puntos por guiones (ej. BRK.B a BRK-B) para que yfinance lo entienda
        t = t.replace('.', '-')
        stock = yf.Ticker(t)
        info = stock.info
        
        # Extraer variables principales
        datos = {
            "Symbol": t,
            "Nombre": info.get("longName"),
            "Industria": info.get("industry"),
            "Pais": info.get("country"),
            "CEO": info.get("companyOfficers", [{}])[0].get("name", "N/A"),
            "Ingresos Netos": info.get("netIncomeToCommon"),
            "Deuda Total": info.get("totalDebt"),
            "Cash": info.get("totalCash"),
            "Market Cap": info.get("marketCap"),
            "Precio Cierre": info.get("previousClose"),
            "Monto Dividendo": info.get("dividendRate"),
            "Ultima Fecha Div": info.get("exDividendDate"), # Fecha en formato timestamp
            "Fecha Consulta": datetime.now().strftime("%Y-%m-%d")
        }
        lista_datos.append(datos)
        print(f"Ok: {t}")
    except Exception as e:
        print(f"Error con {t}: {e}")

# 3. Guardar todo en el CSV
df_final = pd.DataFrame(lista_datos)
df_final.to_csv("sp500_completo.csv", index=False, encoding='utf-8')

print("¡Proceso terminado! Busca el archivo 'sp500_completo.csv'.")


'''