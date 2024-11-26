# Toronto Infection Outbreak Predictions

# Overview
This study investigates the factors influencing the type and duration of healthcare-related outbreaks in Toronto healthcare institutions. Using Bayesian logistic regression, it predicts the likelihood of a specific outbreak type (e.g., respiratory vs. gastroenteric) based on variables such as healthcare setting, time of year, and causative agent. Additionally, Bayesian survival analysis is applied to study the duration of outbreaks and identify factors associated with prolonged outbreaks.

# File Structure
This repository is structured as:

* **data**: Contains the raw and cleaned datasets of outbreak reports from Toronto healthcare institutions, retrieved from Open Data Toronto: https://open.toronto.ca/dataset/outbreaks-in-toronto-healthcare-institutions/.
* **paper**: Includes the PDF and Quarto files used to generate the research paper as well as the references.bib file used to generate the References.
* **scripts**: Contains the R code for data preprocessing, model development, and visualizations.
* **model** contains fitted models.
* **other**: Includes sketches for figures used in the paper and documentation for all LLM usage.

# Statement on LLM usage
Aspects of  the code were troubleshooted using ChatGPT. ChatGPT was also used to help understand certain statistical concepts used in the development of the model. The entire chat history is documented and available in `other/llms/llm_usage.txt`.
