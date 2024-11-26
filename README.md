# Toronto Infection Outbreak Predictions

# Overview
This study aims to examine the factors influencing healthcare outbreaks in Toronto healthcare institutions. These factors include: type of infection ( respiratory vs. gastroenteric), causative agent of infection, and duration of infection. These variables are potentially influenced by the setting (type of healthcare institution), time of year, and causative agent. This study uses logitistical regression and Bayesian survival analysis to identify the factors associated with infectious outbreaks and predict the likelihood of a specific outbreak type depending on the aforementioned variables. 

# File Structure
This repository is structured as:

* **data**: Contains the raw and cleaned datasets of outbreak reports from Toronto healthcare institutions, retrieved from Open Data Toronto: https://open.toronto.ca/dataset/outbreaks-in-toronto-healthcare-institutions/.
* **paper**: Includes the PDF and Quarto files used to generate the research paper as well as the references.bib file used to generate the References.
* **scripts**: Contains the R code for data preprocessing, model development, and visualizations.
* **model** contains fitted models.
* **other**: Includes sketches for figures used in the paper and documentation for all LLM usage.

# Statement on LLM usage
Aspects of  the code were troubleshooted using ChatGPT. ChatGPT was also used to help understand certain statistical concepts used in the development of the model. The entire chat history is documented and available in `other/llms/llm_usage.txt`.
