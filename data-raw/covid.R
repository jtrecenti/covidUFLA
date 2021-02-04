## code to prepare `covid` dataset goes here

library(magrittr)

# da_covid <- vroom::vroom("~/Downloads/HIST_PAINEL_COVIDBR_02fev2021.csv")

da_covid_estado <- da_covid %>% 
  dplyr::filter(!is.na(estado), is.na(municipio)) %>% 
  dplyr::select(
    regiao, 
    estado,
    data, 
    populacao = populacaoTCU2019, 
    obitos = obitosNovos
  )

covid <- da_covid_estado

usethis::use_data(covid, overwrite = TRUE)

