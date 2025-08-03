# 🏠 SQL Data Cleaning Project: Nashville Housing Dataset

Este proyecto consiste en limpiar un conjunto de datos inmobiliarios utilizando SQL. Se aplicaron transformaciones comunes para preparar los datos para análisis posteriores, como la corrección de valores nulos, estandarización de formatos y separación de columnas.

---

## 📊 Dataset

El dataset contiene información sobre transacciones de propiedades en Nashville, incluyendo direcciones, precios, fechas de venta y propietarios. Se detectaron varios problemas comunes:

- Fechas en formato inconsistente
- Direcciones faltantes o combinadas
- Valores categóricos no estandarizados (ej. `Y/N`)
- Registros duplicados
- Columnas innecesarias

---

## 🎯 Objetivos del proyecto

- Estandarizar formatos de fecha
- Rellenar direcciones faltantes con self-joins
- Separar campos combinados (dirección, ciudad, estado)
- Estandarizar valores categóricos (como 'Y'/'N')
- Eliminar registros duplicados con CTEs
- Eliminar columnas innecesarias

---

## 🛠 Herramientas utilizadas

- SQL Server
- SQL Management Studio (SSMS)

---

## 🚀 Cómo ejecutar

1. Abre el archivo `Data_Cleaning_Project.sql` en tu cliente SQL.
2. Carga el dataset en una tabla llamada `NashvilleHousing`.
3. Ejecuta el script para aplicar la limpieza paso a paso.

---

## 📁 Archivos incluidos

- `data_cleaning.sql`: Script con todos los pasos de limpieza aplicados
- `README.md`: Documentación del proyecto

---

## 🧠 Lecciones aprendidas

- Limpieza de datos usando SQL sin herramientas externas
- Uso de funciones como `ISNULL`, `CHARINDEX`, `PARSENAME`
- Aplicación de self-joins para rellenar datos faltantes
- Uso de CTEs y `ROW_NUMBER()` para detectar duplicados
- Mejores prácticas para preparar datos para análisis
