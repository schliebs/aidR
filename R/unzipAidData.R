# Unzip and process Data

#' Unzip and process Data
#' @description Description
#' @param filepath A character string of either a folder or zipfile (including suffix) including the data. 
#' @param dataset The Dataset chosen for download. Options currently include "China .
#' @return A data frame with the output data (further cleaning to be added.)
#' @examples
#' \dontrun{
#' df <- 
#' downloadRawAidData(dataset = "China") %>% 
#' prepAidData(filepath = .,
#'            dataset = "China")
#' head(df)
#'
#' df <- 
#'  prepAidData(filepath = "AidDataChina.zip",
#'              dataset = "China")
#' head(df)
#' }
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.
#' @export
prepAidData <- function(filepath = "AidDataChina.zip",
                        dataset = "China"){
  
  fileDF <- 
    dplyr::bind_rows(
      c(selector = "China",
        filetarget = "GlobalChineseOfficialFinanceDataset_v1.0/GlobalChineseOfficialFinanceDataset_v1.0.xlsx",
        filetype = "xlsx",
        citeMessage = "testmessage"),
      
      c(selector = "AidDataCore",
        filetarget = "https://github.com/AidData-WM/public_datasets/raw/master/chinaglobal/GlobalChineseOfficialFinanceDataset_v1.0.zip",
        filetype = "xlsx",
        citeMessage = "testmessage")
      )
  
  # Unzip
  if(filepath %>% str_sub(.,-4,-1) == ".zip"){
    exdir = filepath %>% str_sub(.,1,-5)
    message(paste0("Unzipping ",filepath," to ",exdir))
    unzip(zipfile = filepath,exdir = exdir)
  }
  
  if(filepath %>% str_sub(.,-4,-1) != ".zip"){
    exdir = filepath
  }
  
  df <- 
    fileDF %>% 
    dplyr::filter(selector == dataset)
  
  if(df$selector == "China"){
    path <- paste0(exdir,"/",df$filetarget)
    
    data <- 
      openxlsx::read.xlsx(path,sheet = 1)
  }
  
  return(data)
  
}

'
downloadRawAidData(dataset = "China") %>% 
  prepAidData(filepath = .,
              dataset = "China")

prepAidData(filepath = "AidDataChina.zip",
            dataset = "China")
'  
