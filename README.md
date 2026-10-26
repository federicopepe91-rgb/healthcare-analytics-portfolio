# 🏥 Healthcare Analytics Executive Dashboard

Un progetto end-to-end di **Data Engineering, Data Analysis e Business Intelligence** applicato al settore sanitario. L'obiettivo della pipeline è gestire l'intera filiera del dato — dalla pulizia e trasformazione con PySpark alla modellazione su SQL Server — per alimentare una dashboard direzionale (Executive) in Power BI orientata al monitoraggio dei costi, dei volumi di ricovero e delle performance ospedaliere.

---

## 🚀 Architettura e Tech Stack

Il progetto copre l'intero ciclo di vita del dato (*Data Pipeline*):
* **Data Engineering & ETL:** `PySpark` (gestione, pulizia da valori nulli e duplicati, e creazione della Fact Table con chiave progressiva).
* **Data Warehouse & SQL:** `SQL Server` (modellazione a stella / *Star Schema* con tabelle dimensionali e query di aggregazione economica).
* **Business Intelligence & UI:** `Power BI` (dashboard interattiva a sviluppo multilivello con un forte focus sulla UX di tipo *Executive*).

---

## 📊 KPI e Indicatori Chiave di Performance
La dashboard monitora in tempo reale i seguenti indicatori macroeconomici e clinici:
* **Pazienti Unici:** 50.000+
* **Fatturato Totale Monitorato:** ~$1,3 Miliardi
* **Degenza Media:** 15,5 giorni stabili
* **Tipologie di Ricovero:** Classificate in *Elective*, *Emergency* e *Urgent*.

---

## 🖥️ Struttura delle Pagine della Dashboard

### 1. Panoramica Ospedaliera (Executive Summary)
* **Funzionalità:** Vista d'insieme con card KPI globali, filtri interattivi per tipologia di ricovero e condizione medica, ranking dei top ospedali per fatturato e trend temporale pluriennale.
* **UX:** Layout pulito basato su container di sfondo e gerarchia visiva coerente.

### 2. Dettaglio Pazienti & Analisi Economica
* **Funzionalità:** Matrice finanziaria avanzata incrociata per patologia (*Medical Condition*) e tipologia di ricovero. Ordinata automaticamente per impatto economico decrescente (evidenziando in cima *Diabetes* e *Arthritis*).
* **Navigazione:** Sistema di drill-through con pulsante di ritorno (*indietro*) posizionato nell'header in modo coerente e integrato.

---

## 📂 Struttura del Repository

```text
healthcare-analytics-portfolio/
│
├── README.md               # Documentazione principale del progetto
├── assets/                 # Screenshot e risorse visive della dashboard
├── pyspark/                # Script ETL e di pulizia dati in PySpark (.py / .ipynb)
├── sql/                    # Query di aggregazione e script per lo Star Schema (.sql)
└── powerbi/                # Report Power BI (.pbix) della dashboard executive
```

---

## ⚙️ Dettagli dei Componenti

### 1. Data Engineering (PySpark)
Il codice si occupa di:
- Caricamento del dataset grezzo ospedaliero.
- Pulizia automatica tramite rimozione di record duplicati e valori nulli (`dropDuplicates` + `dropna`).
- Generazione di una chiave sintetica progressiva (`VisitKey`) tramite `monotonically_increasing_id()`.
- Esportazione della Tabella Fatti pulita in formato strutturato.

### 2. Database & SQL Queries
All'interno della cartella `sql/` sono presenti le query per interrogare il Data Warehouse (`HealthcareDW`), inclusi:
- Il calcolo dei volumi e del fatturato aggregato per singolo ospedale tramite JOIN sulle dimensioni.
- La matrice pivot in SQL per il calcolo dei costi ripartiti per tipologia di trattamento (*Elective*, *Emergency*, *Urgent*).

---

## 🖼️ Anteprima della Dashboard

*(Inserisci qui i tuoi screenshot salvati nella cartella assets)*
- **Panoramica Ospedaliera:** `assets/screenshot_home.png`
- **Dettaglio Pazienti:** `assets/screenshot_dettaglio.png`

---
*Progetto sviluppato a scopo di portfolio professionale.*
