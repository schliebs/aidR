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
