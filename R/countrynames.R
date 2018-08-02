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
    c("Congo, Democratic Republic of","Congo, Dem. Rep."),
    c("Congo Kinshasa","Congo, Dem. Rep."),
    c("Congo, Republic of","Congo, Rep."),
    c("Congo Brazzaville","COngo, Rep."),
    c("Cote d`Ivoire","Ivory Coast"),
    c("Cote D'Ivoire","Ivory Coast"),
    c("Central African Rep.","Central African Republic"),
    c("Cabo Verde","Cape Verde"),
    c("Gambia, The","Gambia")
  ) %>% tibble::as.tibble() %>% 
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
subsahara <- function(){
  
  countrynames<- c("Angola","Benin","Botswana","Burkina Faso","Burundi","Cameroon","Cape Verde","Central African Republic","Chad",
                   "Comoros","Congo, Rep.","Congo, Dem. Rep.","Ivory Coast","Cote d'Ivoire", "Cote D'Ivoire","Djibouti","Equatorial Guinea","Eritrea","Ethiopia", "Gabon", "Gambia"
                   ,"Ghana", "Guinea","Guinea-Bissau","Kenya","Lesotho","Liberia","Madagascar","Malawi","Mali","Mauritania","Mauritius","Mozambique","Namibia","Niger",
                   "Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa","Swaziland","Tanzania","Togo","Uganda","Zambia","Zimbabwe", "Sudan")
  return(countrynames)
  
}
