# Download Raw Dataset

#' Download Raw Dataset
#' @description Description
#' @param dataset The Dataset chosen for download. Options currently include "China","AidDataCore". 
#' @param folder A character string containing the name of a subfolder of the current working directory where the dataset shall be saved in.
#' @param filename A character string for the name of the file (without filetype ending).
#' @param overwrite Logical T/F whether data shall be overwritten if existing already(Defaults to FALSE) 
#' @return A character string of the file path and name of the downloaded raw data.
#' @examples
#' \dontrun{
#' downloadRawAidData(dataset = "China",
#'                    folder = "rawdata",
#'                    filename = "MyChinaData")
#' }
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.
#' @export
downloadRawAidData <- function(dataset = "China",
                               folder = "",
                               filename = NULL,
                               overwrite = FALSE){

  linkDF <- 
    dplyr::bind_rows(
      c(selector = "China",
        url = "https://github.com/AidData-WM/public_datasets/raw/master/chinaglobal/GlobalChineseOfficialFinanceDataset_v1.0.zip",
        filetype = "zip",
        filenameOut = "AidDataChina",
        citeMessage = "Please cite as follows:\n\nfor Academic Purposes: Dreher, A., Fuchs, A., Parks, B.C., Strange, A. M., & Tierney, M. J. (2017). Aid, China, and Growth: Evidence from a New Global Development Finance Dataset. AidData Working Paper #46. Williamsburg, VA: AidData.\n\nFor other Purposes: AidData. 2017. Global Chinese Official Finance Dataset, Version 1.0. Retrieved from http://aiddata.org/data/chinese-global-official-finance-dataset."),
      
      c(selector = "AidDataCore",
        url = "https://github.com/AidData-WM/public_datasets/releases/download/v3.1/AidDataCore_ResearchRelease_Level1_v3.1.zip",
        filetype = "zip",
        filenameOut = "AidDataCore",
        citeMessage = "Please cite as\n Tierney, Michael J., Daniel L. Nielson, Darren G. Hawkins, J. Timmons Roberts, Michael G. Findley, Ryan M. Powers, Bradley Parks, Sven E. Wilson, and Robert L. Hicks. 2011.   More Dollars than Sense: Refining Our Knowledge of Development Finance Using AidData. World Development 39 (11): 1891-1906. \n AND Updated in: AidData. 2017. AidDataCore_ResearchRelease_Level1_v3.1 Research Releases dataset. Williamsburg, VA: AidData. Accessed on [date]. http://aiddata.org/datasets."),
      
      c(selector = "WITS",
        url = "http://wits.worldbank.org/data/public/cp/wits_en_trade_summary_allcountries_allyears.zip",
        filetype = "zip",
        filenameOut = "WITS_Trade",
        citeMessage = "Please cite as\n insert WITS citation!!!"),
      
      c(selector = "worldbank",
      url = "http://databank.worldbank.org/data/download/WDI_csv.zip",
      filetype = "zip",
      filenameOut = "worldbank",
      citeMessage = "Please cite as follows:\n\n INSERT CITATION HERE"),
      
      c(selector = "polity",
        url = "http://www.systemicpeace.org/inscr/p4v2017.xls",
        filetype = "xls",
        filenameOut = "polity",
        citeMessage = "Sorry, this data is not currently supported yet"
#"Please cite as follows:\n\n INSERT CITATION HERE"
        )
    )
  
  if(folder != "") dir.create(folder, showWarnings = TRUE)
  
  df <- 
    linkDF %>% 
    dplyr::filter(selector == dataset)
  
  nameOut <- ifelse(is.null(filename),
                    df %>% pull(filenameOut),
                    filename)
  
  path <- paste0(ifelse(folder == "",folder,paste0(folder,"/")),
                 nameOut,".",df$filetype)
  
  message(paste0(df %>% pull(citeMessage)),"\n\n")
  
  message(paste0("Writing ",nameOut,".",df$filetype," to '",folder,"'\n"))
  
  
 if(overwrite == TRUE |(! file.exists(path))){
   download.file(df %>% pull(url),
                 destfile = path) 
 }  else {warning(paste0("File ",path," exists already. Not downloaded again"))}
  
  return(path)
  
}

'
downloadRawAidData(dataset = "AidDataCore",
                   folder = "",
                   filename = NULL)

downloadRawAidData(dataset = "polity",
                   folder = "rawdata",
filename = NULL)
'