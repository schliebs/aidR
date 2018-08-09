# Unify Country namesss

#' Unify countrynames
#' @description Description
#' @param inVec A vector or character string of country name(s)
#' @return A character vector containing the unified strings.
#' @examples
#' x = c("Congo Kinshasa",
#'       "Congo, Republic of",
#'       "Congo Brazzaville",
#'       "Cote d`Ivoire",
#'       "Central African Rep.",
#'       "Cabo Verde",
#'       "Gambia, The")
#'       
#'  unifyCountrynames(x)
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.
#' @export
unifyCountrynames <- function(inVec){
  
  df <- rbind(
    c("Congo, Democratic Republic of","Democratic Republic of the Congo (the)"),#
    c("Congo, Dem. Rep.","Democratic Republic of the Congo (the)"),#
    c("Congo Kinshasa","Congo, Dem. Rep."),#
    c("Congo (Kinshasa)","Congo, Dem. Rep."),#
    c("Congo, Republic of","Congo (the)"),#
    c("Congo, Rep.","Congo (the)"),#
    c("Congo","Congo (the)"),#
    c("Ethiopia(excludes Eritrea)","Ethiopia"),#
    c("Congo (Democratic Republic of the)","Democratic Republic of the Congo (the)"),#
    c("Congo Brazzaville","Congo, Rep."),#
    c("Republic of Congo","Congo, Rep."),#
    c("Congo (Brazzaville)","Congo, Rep."),
    c("Cote d Ivoire","Côte d'Ivoire"),#
    c("Cote d`Ivoire","Côte d'Ivoire"),#
    c("Cote D'Ivoire","Côte d'Ivoire"),#
    c("Central African Republic","Central African Republic (the)"),##
    c("Cape Verde","Cabo Verde"),##
    c("Comoros","Comoros (the)"),##
    c("Gambia","Gambia (the)"),#
    c("Gambia, The","Gambia (the)"),#
    c("Niger","Niger (the)"),#
    c("Sudan","Sudan (the)"),#
    c("Sao Tome & Principe","Sao Tome and Principe"),#
    c("Tanzania","United Republic of Tanzania (the)"),
    c("Tanzania (United Republic of)","United Republic of Tanzania (the)")#
  ) %>% tibble::as.tibble()  %>% 
    purrr::set_names(c("input","output"))
  
  xx <- df$output
  names(xx) <- df$input
  
  res <- inVec %>% stringr::str_replace_all(.,xx)
  
  return(res)
}

'
 
x = c("Congo Kinshasa","Congo, Republic of","Congo Brazzaville","Cote d`Ivoire","Central African Rep.","Cabo Verde","Gambia, The")

unifyCountrynames(x)

'


# Countrynames all --------------

#' Dirichlet-sample of a multinomial election poll
#' @description Description
#' @return A character vector with subsaharan country names.
#' @examples
#' subsahara()
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.
#' @export
subsaharaCountries <- function(){
  
  countrynames<- c("Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic (the)","Chad","Comoros (the)",
                   "Congo (the)","Côte d'Ivoire","Democratic Republic of the Congo (the)","Djibouti", "Equatorial Guinea","Eritrea","Ethiopia","Gabon",
                   "Gambia (the)","Ghana","Guinea","Guinea-Bissau", "Kenya","Lesotho","Liberia","Madagascar","Malawi","Mali","Mauritania","Mauritius",
                   "Mozambique","Namibia","Niger (the)","Nigeria", "Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia",
                   "South Africa","South Sudan", "Sudan (the)","Swaziland","Togo","Uganda","United Republic of Tanzania (the)","Zambia","Zimbabwe")
  return(countrynames)
  
}
