# clase_03.R

rm(list = ls())
options(scipen = 999)

# Obtener directorio del script actual y modificar el working directory
# install.packages(rstudioapi)
library("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# ----------------------------------------
# Módulo 3: Programación en R
# ----------------------------------------

# 1. Estructuras de control
# -------------------------

# Ejemplo 1: Estructura condicional if-else
x <- 10
if (x > 5) {
  print("x es mayor que 5")
} else {
  print("x es menor o igual a 5")
}

# Ejemplo 2: Estructura iterativa for
for (i in 1:5) {
  print(paste("Iteración:", i))
}

for (i in seq(1,10, by=3)) {
  print(paste("Iteración:", i))
}
?seq

# 2. Familia de funciones apply
# -----------------------------

# Ejemplo 1: Usar apply para calcular la suma de filas en una matriz
?apply

?sapply

matriz <- matrix(data=seq(1,9,1), nrow = 3, ncol = 3, byrow = TRUE)

class(matriz)

nrow(matriz)
ncol(matriz)
dim(matriz)


for (fila in 1:nrow(matriz)) {
  for (colu in 1:ncol(matriz)) {
    cat(matriz[fila, colu], " - ", is.numeric(matriz[fila, colu]),  "\n")
  }
}

?apply

# apply(matriz, is.numeric)
isnumeric <- apply(matriz, c(1,2), is.numeric)


sumas_por_fila <- apply(matriz, 1, sum)  # 1 indica operación por filas
sumas_po _fila
sumas_por_col <- apply(matriz, 2, sum)  # 2 indica operación por col

sumas_por_fila
sumas_por_col

function

prod_fila <- apply(matriz, 1, prod)  # 1 indica operación por columnas
prod_cols <- apply(matriz, 2, prod)  # 1 indica operación por columnas

# 3. Funciones definidas por el usuario
# -------------------------------------

# Ejemplo 1: Crear una función para calcular el área de un círculo
area_circulo = function(radio) {
  cat ("Calculando el area de un circulo de radio =", radio, "\n")
  
  calculo = pi * (radio^2)
  
  cat("Devolviendo el valor del cálculo: ", calculo, "\n")
  return(calculo)
}

radio = 5

cat("El área de un círculo de radio", radio, "es", area_circulo(radio))

# función que calcula el cuadrado de un número
cuadrado = function(x) {
  return (x^3)
}

cuadrado(5)


# Función que calcula la circunferencia de un círculo
cincunf_circulo = function(radio) {
  return (2 * pi * radio)
}

cincunf_circulo(5)


# Ejemplo 2: Crear una función con múltiples argumentos y múltiples valores de retorno
calcular_estadisticas <- function(vector) {
  media <- mean(vector)
  desviacion <- sd(vector)
  return(list(promedio = media, desv_std = desviacion))
}

vector = c(1, 2, 3, 4, 5)

resultados <- calcular_estadisticas(vector)

print("Estadísticas del vector:")
print(resultados)


# 4. Listas
# ---------

# Creamos vector de hobbies
hobbies = c("correr", "leer")

# Ejemplo 1: Crear una lista y acceder a sus elementos
mi_lista <- list(nombre = "Juan", edad = 25, hobbies = hobbies)

cat("Edad de Juan:", mi_lista$edad)

# Mostrar los hobbies
mi_lista$hobbies

# Mostrar el segundo hobbie (leer)
mi_lista$hobbies[2]

# Ejemplo 2: Modificar una lista
mi_lista$edad <- 26  # Actualizar la edad
mi_lista$hobbies <- c(mi_lista$hobbies, "cocinar")  # Agregar un hobby

cat("Edad de Juan:", mi_lista$edad)

mi_lista$nombre = "Pedro"

lista_sin_nombres = list(2, "Pepe", c(45,56), list(1,2))


# 5. Lectura de archivos
# 5.1 Leer un archivo CSV separado por comas

df <- read.csv("datos/datos.csv")

df <- read.csv("datos/datos_comillas.csv")

df_con_indice <- read.csv("datos/datos_con_indice.csv", row.names="id", blank.lines.skip = TRUE)

class(df)

# Rutas absolutas y rutas relativas

# ruta_absoluta = "C:\\Users\\Pepito\\datos\\datos.csv"
# ruta_relativa = "datos/datos.csv"

# 5.2 Leer un archivo CSV separado por punto y coma
datos_csv_punto_coma <- read.csv2("datos/datos_punto_coma.csv")

# 5.3 Leer un archivo CSV desde una URL (Uniform Resource Locator) - URI
iris_url = "https://gist.githubusercontent.com/curran/a08a1080b88344b0c8a7/raw/0e7a9b0a5d22642a06d3d5b9bcbad9890c8ee534/iris.csv"
iris_web <- read.csv(iris_url)
head(iris_web)
tail(iris_web)
summary(ir)

# 5.4 Leer un archivo Excel
install.packages("readxl")
library(readxl)
datos_excel <- read_excel("datos/datos.xlsx", sheet = "Hoja1")
print(datos_excel)

# 5.5 Leer un archivo de texto plano
datos_txt <- read.table("datos/datos.txt", header = TRUE)
print(datos_txt)

# 5.6 Leer un archivo de texto con separador personalizado (tabulador)
datos_txt_tab <- read.table("datos/datos_tab.txt", header = TRUE, sep = "\t")
print(datos_txt_tab)

# 6. Lectura de múltiples archivos
# --------------------------------

# Ejemplo 1: Leer múltiples archivos CSV y combinarlos en un solo data frame
# archivos <- list.files(pattern = "*.csv")  # Listar archivos con "csv" en el directorio

# Listar los archivos CSV que comienzan con "titanic_" y terminan en ".csv"
archivos_titanic <- list.files(pattern = "^titanic_.*\\.csv$")

# Leer y combinar los archivos en un solo dataframe
titanic_completo <- do.call(rbind, lapply(archivos_titanic, read.csv))

# Verificar las primeras 10 filas del dataframe combinado
head(titanic_completo, 10)

# Verificar las últimas 10 filas del dataframe combinado
tail(titanic_completo, 10)


# Instalar si no lo tienes: install.packages("vroom")
library(vroom)

# Especificando una carpeta:
# titanic_completo_vroom <- vroom("ruta/a/tu/carpeta/titanic_*.csv")

archivos_titanic <- list.files(pattern = "^titanic_.*\\.csv$", full.names = TRUE)
titanic_completo_vroom <- vroom(archivos_titanic)
# vroom automáticamente añade una columna 'id' indicando el archivo de origen


###############################################
# OPCIONAL PERO RECOMENDADO
###############################################
# Usar librería readr (parte de tidyverse)
# Usar readr
library(readr)
iris_web_readr <- read_csv(iris_url)
head(iris_web_readr)

# USO DE FORMATOS MÁS AVANZADOS
# PARQUET
# JSON
# ARROW
# DUCKPLYR

# ----------------------------------------
# Ejercicios
# ----------------------------------------

# 1. Escribir una función que tome un número y devuelva "Par" si es par o "Impar" si es impar.


# 2. Usar sapply para aplicar la función anterior a un vector de números del 1 al 10.


# 3. Crear una lista que contenga un data frame, un vector y una matriz, y acceder a cada elemento.


# 4. Leer todos los archivos "titanic_*\\.csv" y calcular la media de la columna "Age" en cada uno.


# 5. Escribir un bucle for que imprima los números del 1 al 100, pero solo si son divisibles por 3.
