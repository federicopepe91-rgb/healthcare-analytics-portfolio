"""
Progetto: Healthcare Analytics - Data Engineering & ETL Pipeline
Descrizione: Script PySpark per l'estrazione, la pulizia e la trasformazione 
             del dataset ospedaliero grezzo.
"""

import os
import zipfile
from pyspark.sql import SparkSession
from pyspark.sql.functions import monotonically_increasing_id

def main():
    # 1. Avvio della sessione Spark
    spark = SparkSession.builder \
        .appName("HealthcareCleaningProject") \
        .getOrCreate()
    
    print("Ambiente Spark inizializzato correttamente.")

    # 2. Creazione delle cartelle di lavoro locali
    os.makedirs("raw_healthcare_files", exist_ok=True)
    os.makedirs("cleaned_healthcare_files", exist_ok=True)

    # 3. Estrazione automatica del dataset
    zip_path = "healthcare_dataset.csv.zip"
    if os.path.exists(zip_path):
        with zipfile.ZipFile(zip_path, "r") as zip_ref:
            zip_ref.extractall(".")
        print("File scompresso con successo!")
    else:
        print(f"Attenzione: {zip_path} non trovato nella directory corrente.")

    # 4. Caricamento del file CSV grezzo
    raw_file_path = "healthcare_dataset.csv"
    df_raw = spark.read.csv(raw_file_path, header=True, inferSchema=True)
    
    print(f"Righe iniziali nel file grezzo: {df_raw.count()}")
    df_raw.printSchema()

    # 5. Pulizia dei dati: Rimozione duplicati e valori nulli
    df_cleaned = df_raw.dropDuplicates().dropna()
    print(f"Righe dopo la pulizia (dropna + dropDuplicates): {df_cleaned.count()}")

    # 6. Creazione della Tabella Fatti con ID progressivo (VisitKey)
    df_fact = df_cleaned.withColumn("VisitKey", monotonically_increasing_id())

    # 7. Esportazione della Fact Table pulita
    output_path = "cleaned_healthcare_files/FactHospitalVisits"
    df_fact.coalesce(1).write.csv(output_path, header=True, mode="overwrite")
    
    print(f"FactHospitalVisits creata ed esportata con successo in '{output_path}'!")

if __name__ == "__main__":
    main()
