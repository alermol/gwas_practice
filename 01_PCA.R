# Присоединяем нужные пакеты ----
library(ggplot2)
library(readr)

# Читаем данные ----
pca_data <- read_tsv('data/genotype_pruned.eigenvec')

# Строим базовый график ----
plot(pca_data$PC1, pca_data$PC2, xlab = 'PC1', ylab = 'PC2')

# Строим график с помощью ggplot2 ----
ggplot(pca_data, aes(x = PC1, y = PC2)) + 
    geom_point()
