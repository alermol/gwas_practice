# Присоединяем нужные пакеты ----
library(GAPIT)
library(magrittr)
library(readr)
library(tibble)
library(dplyr)
library(tidyr)
library(stringr)

# Задаем пути до файлов ----
vcf_file <- 'data/genotype.vcf'
phenotype <- 'data/phenotype.tsv'
pca_data <- 'data/genotype_pruned.eigenvec'

# Читаем фенотипические данные ----
Y <- read_tsv(phenotype) %>% 
    arrange(sample) %>% 
    as.data.frame()

# Читаем генотипические данные ----
GD <- read_tsv(vcf_file, skip = 8) %>% 
    select(-c('#CHROM', POS, REF, ALT, QUAL, FILTER, INFO, FORMAT)) %>% 
    pivot_longer(-ID) %>% 
    mutate(value = case_match(
        value,
        '0|0' ~ 0,
        c('1|0', '0|1') ~ 1,
        '1|1' ~ 2
    )) %>% 
    pivot_wider(names_from = ID) %>% 
    arrange(name) %>% 
    as.data.frame()

# Читаем данные PCA ----
CV <- read.delim(pca_data) %>% 
    arrange(X.IID) %>% 
    as.data.frame()

# Читаем генотипические данные (но по-другому) ----
GM <- read_tsv(vcf_file, skip = 8) %>% 
    select(c(ID, '#CHROM', POS)) %>% 
    mutate(`#CHROM` = str_remove(`#CHROM`, 'chr')) %>% 
    as.data.frame()

# Запускаем вычисление GWAS ----
GAPIT(
    Y = Y,
    GD = GD,
    GM = GM,
    CV = CV,
    model = 'GLM'
)