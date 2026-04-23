Documentación de Diseño: Sistema de Análisis Financiero NYSE
1. Definición del Modelo de Datos (Esquema Relacional)
Para cumplir con la Tercera Forma Normal (3NF) y evitar la redundancia de datos derivados, estructuraremos la base de datos en 7 tablas maestras/históricas y 1 vista de inteligencia.

A. Tablas Maestras (Datos Estáticos y de Referencia)
Sectors (Tabla Maestra de Categorización)

id_sector (PK, Serial): Identificador único.

nombre_sector: Ej. "Tecnología", "Energía", "Salud".

Semántica: Permite agrupar empresas para comparar indicadores (un margen del 10% es malo en software pero excelente en supermercados).

Company (Entidad Principal)

symbol (PK, Varchar[10]): El ticker de la bolsa (ej: 'AAPL').

nombre: Nombre legal de la empresa.

pais: Sede principal.

id_sector (FK): Relación 1:N con Sectores.

Leadership (Gobernanza)

id_ceo (PK, Serial).

symbol (FK): Empresa a la que pertenece.

nombre_ceo: Nombre del actual directivo.

fecha_inicio: Fecha en que asumió el cargo.

B. Tablas Históricas (Series de Tiempo)
Financial_Reports (Resultados Operativos)

id_reporte (PK).

symbol (FK).

fecha (Date): Fecha de cierre del trimestre o año.

ingresos (Numeric): Facturación total.

ganancias (Numeric): Utilidad neta.

activos (Numeric): Valor total de bienes de la empresa.

Debt_Structure (Solvencia)

id_deuda (PK).

symbol (FK).

fecha (Date).

deuda_total (Numeric).

cash_equivalents (Numeric): Dinero disponible de inmediato.

Dividends (Flujo al Accionista)

id_div (PK).

symbol (FK).

fecha_ex (Date): Fecha límite para tener la acción y cobrar.

monto (Numeric): Pago por acción.

frecuencia: Mensual, trimestral, anual.

Market_Data (Datos Volátiles)

symbol (FK).

fecha (Date).

market_cap (Numeric): Valor de mercado.

num_empleados (Int).

precio_cierre (Numeric).

Nota: Clave primaria compuesta por (symbol, fecha).

2. Descripción Semántica del Problema
Para el desarrollo del software, debemos entender qué significan los datos en el mundo real (Reglas de Negocio):

Atomicidad: Los datos se guardan en su estado más puro. No guardamos "Margen Neto", guardamos ganancias e ingresos. El margen se calcula al consultar para evitar que un cambio en los datos base deje un cálculo desactualizado.

Cardinalidad:

Company (1) : (N) Financial_Reports: Permite ver la evolución histórica.

Sectors (1) : (N) Company: Permite promediar el rendimiento por industria.

Restricciones de Integridad:

NOT NULL en montos financieros para evitar cálculos erróneos.

CHECK (deuda_total >= 0) para asegurar la calidad del dato.

ON DELETE CASCADE en las tablas históricas para limpiar datos si una empresa deja de existir.

3. Lógica de Desarrollo (Capa de Aplicación)
La Capa de "Inteligencia" (Cálculos Derivados)
Al no guardar los indicadores, el desarrollo se facilita creando una Vista SQL (View). Esto permite que tu código de Python/Java/JS solo tenga que hacer un SELECT * FROM vista_inversion.

Fórmulas que debe procesar la vista:

Crecimiento: (Ingreso_Actual - Ingreso_Anterior) / Ingreso_Anterior.

Margen de Beneficio: Ganancias / Ingresos.

Ratio Deuda/Caja: Deuda_Total / Cash_Equivalents.

Criterio de "Buena Inversión"
Semánticamente, el sistema filtrará como "Buena" una fila que cumpla:

Crecimiento > 0.10 (Crece más del 10%).

Ratio Deuda/Caja < 1.5 (Tiene liquidez para pagar su deuda).

Market_Cap < Activos (Opcional: Valoración de oportunidad).

4. Hoja de Ruta para Implementación Rápida
Creación de Tablas: Empezar por Sectors y Company (las bases).

Carga de Datos: Importar datos históricos en las 4 tablas temporales (Finanzas, Deuda, Dividendos, Mercado).

Construcción de la Vista: Crear el objeto SQL que una las tablas y realice las divisiones de los indicadores.

Interfaz de Consulta: Crear una función que reciba un id_sector y devuelva las 5 mejores empresas según el filtro de la vista.