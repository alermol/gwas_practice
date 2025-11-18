# 1. Установка пакета GAPIT

В терминале R ввести

[Ссылка на Github GAPIT](https://github.com/jiabowang/GAPIT)

```R
install.packages("devtools")
devtools::install_github("jiabowang/GAPIT", force=TRUE)
```

# 2. Скачивание PLINK2

[Ссылка на сайт PLINK2](https://www.cog-genomics.org/plink/2.0/)

# 3. Знакомство с форматом файла VCF

VCF значит **V**ariant **C**all **F**ormat

[Ссылка](https://samtools.github.io/hts-specs/VCFv4.2.pdf) на подробную спецификацию формата VCF

# 4. Визуализация структуры популяции с помощью PCA

## 4.1 Извлечение набора несцепленных вариантов с помощью PLINK2

1. Поместить файл plink2.exe в директорию с VCF
2. Открыть командную строку (Win+R) и перейти в папку с VCF и PLINK2
3. Ввести в терминале команды:

```bash
# извлечение списка ID слабо коррелируемых вариантов
plink2.exe --vcf genotype.vcf --allow-extra-chr --indep-pairwise 500kb 0.8 --out genotype

# извлечение набора слабо коррелируемых вариантов в отдельный VCF
plink2.exe --vcf genotype.vcf --allow-extra-chr --extract genotype.prune.in --export vcf --out genotype_pruned

# расчет 10 главных компонент структуры популяции
plink2.exe --vcf genotype_pruned.vcf --pca 10 --out genotype_pruned
```

## 4.2 Создание графика структуры популяции

Скрипт 01_PCA.R

# 5. Проведение GWAS с помощью GAPIT

Скрипт 02_GWAS.R

# 6. Интерпретация результатов

