#' Get the irradiance for a given location and time
#'
#' @param year The year for which the irradiance is requested.
#' @param month The month for which the irradiance is requested.
#' @param day The day for which the irradiance is requested.
#' @param lat The latitude for which the irradiance is requested.
#' @param lon The longitude for which the irradiance is requested.
#' @param min_wavelength The minimum wavelength for which the irradiance is requested.
#' @param max_wavelength The maximum wavelength for which the irradiance is requested.
#' @param wavelength_interval The wavelength interval for which the irradiance is requested.
#' @return A tibble with the wavelength, category, and value of the irradiance.
#' @export
#' @examples
#' get_irradiance()

get_irradiance <- function(year = "2023",
                             month = "1",
                             day = "1",
                             lat = "-34.2833",
                             lon = "150.95",
                             min_wavelength = "350",
                             max_wavelength = "750",
                             wavelength_interval = "10") {

    #url
    url <- "https://www2.pvlighthouse.com.au/calculators/solar%20spectrum%20calculator/solar%20spectrum%20calculator.aspx"

    # Acesso para pegar as informacoes da sessao
    res <- httr::GET(url)

    # Pegar o __VIEWSTATE
    viewstate <- res |>
      httr::content() |>
      xml2::xml_find_first("//input[@id='__VIEWSTATE']") |>
      xml2::xml_attr("value")

    # Pegar o __EVENTVALIDATION
    eventvalidation <- res |>
      httr::content() |>
      xml2::xml_find_first("//input[@id='__EVENTVALIDATION']") |>
      xml2::xml_attr("value")

    # Declarar parametros
    params <- list(
      "smMain" = "TabContainer1$TabPanel1$UpdatePanel1|TabContainer1$TabPanel1$tbDay",
      "TabContainer1_ClientState" = "{\"ActiveTabIndex\":0,\"TabEnabledState\":[true,true,true,true],\"TabWasLoadedOnceState\":[true,false,false,false]}",
      "__EVENTTARGET" = "TabContainer1$TabPanel1$tbDay",
      "__EVENTARGUMENT" = "",
      "__LASTFOCUS" = "",
      "__VIEWSTATE" = viewstate,
      "__VIEWSTATEGENERATOR" = "2AB02EE8",
      "__SCROLLPOSITIONX" = "0",
      "__SCROLLPOSITIONY" = "0",
      "__EVENTVALIDATION" = eventvalidation,
      "TabContainer1$TabPanel1$tbYear" = year,
      "TabContainer1$TabPanel1$tbHour" = "12",
      "TabContainer1$TabPanel1$tbMonth" = month,
      "TabContainer1$TabPanel1$tbMinute" = "0",
      "TabContainer1$TabPanel1$tbDay" = day,
      "TabContainer1$TabPanel1$tbSecond" = "0",
      "TabContainer1$TabPanel1$tbLatitude" = lat,
      "TabContainer1$TabPanel1$tbLongitude" = lon,
      "TabContainer1$TabPanel1$tbModuleTiltAngle" = "0",
      "TabContainer1$TabPanel1$tbModuleAzimuthAngle" = "0",
      "TabContainer1$TabPanel1$ddlSpectrumSource" = "AM0",
      "TabContainer1$TabPanel1$ddlAtmosphericTransmissionModel" = "SPCTRAL2 [Bir86]",
      "TabContainer1$TabPanel1$tbAtmosphericPressure" = "1013.25",
      "TabContainer1$TabPanel1$tbTurbidity" = "0.084",
      "TabContainer1$TabPanel1$tbPrecipitableWaterVapour" = "1.4164",
      "TabContainer1$TabPanel1$tbOzone" = "0.3438",
      "TabContainer1$TabPanel1$tbAlbedo" = "0.1",
      "TabContainer1$TabPanel1$cpeInsolation_ClientState" = "false",
      "TabContainer1$TabPanel1$cpeFigure_ClientState" = "false",
      "TabContainer1$TabPanel1$ddlFigureYaxis" = "Spectral irradiance",
      "TabContainer1$TabPanel1$ddlSelectedPlane" = "Module",
      "TabContainer1$TabPanel1$ddlFigureXaxis" = "Wavelength",
      "TabContainer1$TabPanel1$cbPlotExtraterrestrialSpectrum" = "on",
      "TabContainer1$TabPanel1$cbPlotDirect" = "on",
      "TabContainer1$TabPanel1$cbPlotDiffuse" = "on",
      "TabContainer1$TabPanel1$cbPlotGlobal" = "on",
      "TabContainer1$tabOptions$ddlSolarPosition" = "Enter module location and time",
      "TabContainer1$tabOptions$ddlSolarVectorAlgorithm" = "PSA algorithm [Bla01]",
      "TabContainer1$tabOptions$ddlSpectrumManipulation" = "Impose wavelength limits",
      "TabContainer1$tabOptions$tbOptionWavelengthMin" = min_wavelength,
      "TabContainer1$tabOptions$tbOptionWavelengthMax" = max_wavelength,
      "TabContainer1$tabOptions$tbOptionWavelengthInterval" = wavelength_interval,
      "TabContainer1$TabPanel2$ddlOptionsFileType" = "CSV US/UK (comma delimited)",
      "TabContainer1$TabPanel2$tbStoreXData" = "",
      "TabContainer1$TabPanel2$tbStoreYData" = "",
      "tbFeedback" = "",
      "__ASYNCPOST" = "false"
    )

    # Pegar o conteudo da resposta
    cont <- url %>%
      httr::POST(body = params, encode = "form") %>%
      httr::content()

    # Extrair dados
    tabela <- cont %>%
      xml2::xml_find_all("//map/area") %>%
      purrr::map(\(x) list(coords = xml2::xml_attr(x, "coords"),
                           title = xml2::xml_attr(x, "title"))) %>%
      purrr::transpose() %>%
      purrr::map(purrr::flatten_chr) %>%
      dplyr::as_tibble()

    tabela2 <- tabela %>%
      dplyr::mutate(nm = as.numeric(stringr::str_extract(title, "(?<=WL\\s\\=\\s)[:digit:]{3,}\\.[:digit:]")),
                    category = stringr::str_extract(title, "(?<=\\snm\\s)[:alpha:]+"),
                    value = as.numeric(stringr::str_extract(title, "[:digit:]\\.[:digit:]{3,}(?=\\sW\\/m2\\/nm)"))) %>%
      dplyr::select(-c(coords, title)) %>%
      dplyr::filter(!is.na(nm)) %>%
      dplyr::arrange(nm)

    return(tabela2)

  }
