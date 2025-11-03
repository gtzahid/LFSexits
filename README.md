# LFSexits

README File: Who Leaves Work and Why: Intersectional Patterns in Post-Pandemic Canada
Study Description
This study examines how intersecting identities of gender, immigrant status, and family structure shape the reasons for labour market exit. Using pooled 2024 monthly Canadian Labour Force Survey data for respondents aged 15 and over, weighted multinomial logistic regressions estimate the likelihood of leaving employment due to layoffs, school, personal or family responsibilities, illness or disability, retirement, or other reasons. Analyses reveal distinct gender–immigrant–family patterns in job-leaving behaviour, net of age, education, and province. Below, information is included about how to use the files provided to reproduce the analyses leading to this conclusion.
Data Description
Data Source Availability Statement
Data are drawn from the 2024 monthly Labour Force Survey (LFS). The microdata are available from Statistics Canada: https://www150.statcan.gc.ca/n1/pub/71m0001x/2021001/hist/2024-CSV.zip
Information about the Labour Force Survey can be found on the Statistics Canada website: https://www150.statcan.gc.ca/n1/pub/71m0001x/71m0001x2021001-eng.htm
The corresponding codebook is included in the same zip file.
Citation Statistics Canada. 2024. Labour Force Survey (Public Use Microdata File), 2024 [Canada]. Statistics Canada [producer and distributor]. Accessed March 5, 2025, from https://www150.statcan.gc.ca/n1/pub/71m0001x/71m0001x2021001-eng.htm
Files Included
File Name
Purpose
‘Who Leaves Work_RR’
PDF version of replicability steps
‘LFS exits.do’
Calls Stata scripts to conduct all analyses
‘LFS heatmap.Rmd’
Calls R scripts to create the heatmap
‘pp_all.dta’
Analysis output of containing all predicted probabilities and confidence intervals
Instructions for Data Preparation and Analysis
To reproduce the analyses conducted here, download the zip file of this project. The zip file will create the folder "LFSexits." which will serve as the working directory.
Download the LFS dataset zip file, extract the data and rename it as preferred. Open and run the Stata script ‘LFS_exits.do’, which generates ‘pp_all.dta’ in your working directory. This script calls individual sub-files to clean the data, handle missing values, and estimate predicted probabilities with confidence intervals.
Next, open ‘LFS_heatmap.Rmd’ in R to load ‘pp_all.dta’ and produce the heatmap visualization.
Software Requirements
The analyses were conducted in Stata 18.5, but equivalent analyses can also be reproduced in R. Stata is therefore not required to replicate the results.
•
R and Rstudio (version 1.4.4) and the following packages as of 10/07/25
o
haven
o
dplyr
o
tidyr
o
ggplot2
o
scales
o
RColorBrewer
o
stringr
o
ggtext
o
grid
Machine Information
These analyses were conducted using Windows 11 version 23H2:
•
11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz 2.70 GHz Processor
•
8 GB 1600 MHz DDR3 Memory
