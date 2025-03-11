packages <- c("tidyr",
              "dplyr",
              "stringr",
              "checkmate",
              "lubridate",
              "ggplot2",
              "purrr",
              "readr")

for (p in packages) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p)
    library(p, character.only = TRUE)
  }
#raw data
data <- read_delim("data.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
data <- data[, -1]
saveRDS(data, file = "raw_Data.RDS")

# Grundlegende Statistik zu "lastpage"
summary(df$lastpage)

# Häufigkeitsverteilung von "lastpage" berechnen
lastpage_counts <- table(df$lastpage)

# ggplot2 für Visualisierung laden
library(ggplot2)

# Balkendiagramm erstellen
ggplot(data.frame(lastpage=names(lastpage_counts), count=as.numeric(lastpage_counts)),
       aes(x=as.numeric(lastpage), y=count)) +
  geom_bar(stat="identity", fill="skyblue", color="black") +
  theme_minimal() +
  labs(title="Fragebogenabschluss",
       x="Letzte abgeschlossene Seite",
       y="Anzahl der Personen") +
  scale_x_continuous(breaks=seq(min(df$lastpage, na.rm=TRUE),
                                max(df$lastpage, na.rm=TRUE), 1))
