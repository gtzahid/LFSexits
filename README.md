# Who Leaves Work and Why: Intersectional Patterns in Post-Pandemic Canada

## Study Description

This study examines how intersecting identities of gender, immigrant status, and family structure shape the reasons for labour market exit. Using pooled **2024 monthly Canadian Labour Force Survey (LFS)** data for respondents aged 15 and over, **weighted multinomial logistic regressions** estimate the likelihood of leaving employment due to:

- layoffs  
- school  
- personal or family responsibilities  
- illness or disability  
- retirement  
- other reasons  

Analyses reveal distinct gender–immigrant–family patterns in job-leaving behaviour, net of age, education, and province.

Below is information on how to use the files provided to reproduce the analyses leading to this conclusion.

---

## Data Description

### Data Source Availability Statement

Data are drawn from the 2024 monthly **Labour Force Survey (LFS)**.  
The microdata are available from Statistics Canada:

🔗 [2024 LFS Microdata (CSV)](https://www150.statcan.gc.ca/n1/pub/71m0001x/2021001/hist/2024-CSV.zip)  
🔗 [LFS Information Page](https://www150.statcan.gc.ca/n1/pub/71m0001x/71m0001x2021001-eng.htm)

The corresponding codebook is included in the same zip file.

### Citation

> Statistics Canada. 2024. *Labour Force Survey (Public Use Microdata File), 2024 [Canada].*  
> Statistics Canada [producer and distributor].  
> Accessed March 5, 2025, from [https://www150.statcan.gc.ca/n1/pub/71m0001x/71m0001x2021001-eng.htm](https://www150.statcan.gc.ca/n1/pub/71m0001x/71m0001x2021001-eng.htm)

---

## Files Included

| File Name | Purpose |
|------------|----------|
| `Who Leaves Work_RR.pdf` | PDF version of replicability steps |
| `LFS_exits.do` | Calls Stata scripts to conduct all analyses |
| `LFS_heatmap.Rmd` | Calls R scripts to create the heatmap |
| `pp_all.dta` | Analysis output containing all predicted probabilities and confidence intervals |

---

## Instructions for Data Preparation and Analysis

To reproduce the analyses conducted here:

1. Download the project’s ZIP file — it will create the folder `LFSexits`, which will serve as the working directory.  
2. Download the LFS dataset ZIP file and extract the data. Rename as preferred.  
3. Open and run the Stata script **`LFS_exits.do`**, which generates `pp_all.dta` in your working directory.  
   - This script calls individual sub-files to clean data, handle missing values, and estimate predicted probabilities with confidence intervals.  
   - Source: [LFS Data Page](https://www150.statcan.gc.ca/n1/pub/71m0001x/71m0001x2021001-eng.htm)
4. Next, open **`LFS_heatmap.Rmd`** in R to load `pp_all.dta` and produce the heatmap visualization.

---

## Software Requirements

The analyses were conducted in **Stata 18.5**, but equivalent analyses can also be reproduced in **R**.  
Stata is therefore *not required* to replicate the results.

### R and RStudio

Tested with **RStudio version 1.4.4** and the following R packages (as of 2025-10-07):

- `haven`  
- `dplyr`  
- `tidyr`  
- `ggplot2`  
- `scales`  
- `RColorBrewer`  
- `stringr`  
- `ggtext`  
- `grid`

---

## Machine Information

Analyses were conducted using the following system:

- **OS:** Windows 11 (version 23H2)  
- **Processor:** 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz  
- **Memory:** 8 GB 1600 MHz DDR3  

---

*Last updated: March 2025*

