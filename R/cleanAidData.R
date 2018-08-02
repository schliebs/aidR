# Clean China ------------

#' Clean China
#' @description Description
#' @param df a Data Frame containing the Raw  Dataset
#' @param dataset Character String denoting which dataset is to be cleaned (takes "Core" or "China". Takes vector c("Core","China") if datasets shall be merged)
#' @param level Level (c("full","donor-year","donor-year-recipient","donor-year-recipient-type"))
#' @return A data frame containing \code{n} rows of blabla.
#' @examples
#' x <- c(1,2,3)
#' mean(x)
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.
#' @export
clean_aidData <- function(df_list,
                        dataset = c("China","Core"),
                        level = "donor-year"){
  
  # df_list <- list(dfCHINA,dfCORE)
  
  if(class(df_list) != "list"){
    df_list <- list(df_list)
  }
  
  names(df_list) <- dataset
  
  sepList <- 
    purrr::map2(.x = df_list,
                .y = names(df_list),
             .f = function(df,name){
  
  orig_names <- names(df)
  
  #### General Datamanagement
  

  if("Core" %in% name){
    
    # Remove year 9999
    df %<>% filter(year != 9999)
    
    # deflation correction? STILL DO THIS HERE!!!!!
    df$amountUSD <- df$commitment_amount_usd_constant %>% as.numeric() #check this
    
    # Flow class
    df$flow_classification <- NA
    df$flow_classification [df$flow_name %in% c("ODA Grants","ODA Loans")] <- "ODA"
    df$flow_classification [df$flow_name %in% c("OOF LOANS(NON-EXPORT CREDIT)","Other Official Flows (non Export Credit)")] <- "OOF"
    df$flow_classification [!df$flow_name %in% c("ODA Grants","ODA Loans","OOF LOANS(NON-EXPORT CREDIT)","Other Official Flows (non Export Credit)")] <- "other"
    
  }
  
  if("China" %in% name){
    
    # Throw out all with more than one recipient countries
    df %<>% filter(recipient_count == 1)
    
    # Fix variable names
    df %<>% rename(recipient = all_recipients)
    
    # deflation correction? STILL DO THIS HERE!!!!!
    df$amountUSD <- df$usd_defl_2014 %>% as.numeric() #check this
    
    # Flow class
    df$flow_classification <- NA
    df$flow_classification [df$flow_class == "ODA-like"] <- "ODA"
    df$flow_classification [df$flow_class == "OOF-like"] <- "OOF"
    df$flow_classification [df$flow_class == "Vague (Official Finance)"] <- "other"
    
  }
  
  
  # Fix country names
  df %<>% mutate_at(vars(recipient,donor),
                    funs(unifyCountrynames(.)))
  


  # grouping/summarising
  
  if(level == "full"){
    
    df_grid <- expand.grid(year = seq(min(df$year),max(df$year),by = 1))
    
    df2 <- df
    
    df3 <- left_join(df_grid,df2,by = c("year"))
    
  }
  
  if (level == "donor-year"){
    
    df_grid <- expand.grid(year = seq(min(df$year),max(df$year),by = 1),
                           donor = df$donor %>% unique())
    df2 <- 
      df %>% 
      group_by(donor,year) %>% 
      summarise(aidSum = sum(amountUSD,na.rm = T))
    
    df3 <- left_join(df_grid,df2,by = c("year","donor"))
    
  }
    
  if(level == "donor-year-recipient"){
    
    df_grid <- expand.grid(year = seq(min(df$year),max(df$year),by = 1),
                           recipient = df$recipient %>% unique(),
                           donor = df$donor %>% unique())
    df2 <- 
      df %>% 
      group_by(donor,year,recipient) %>% 
      summarise(aidSum = sum(amountUSD,na.rm = T))
    
    df3 <- 
      left_join(df_grid,df2,by = c("year","donor","recipient")) %>% 
      arrange(donor,year,recipient)
  }
    
    
  if(level == "donor-year-recipient-type"){
    
    df_grid <- expand.grid(year = seq(min(df$year),max(df$year),by = 1),
                           donor = df$donor %>% unique(),
                           recipient = df$recipient %>% unique(),
                           flow_classification = df$flow_classification %>% unique())
    
    df2 <- 
      df %>% 
      group_by(donor,year,recipient,flow_classification) %>% 
      summarise(aidSum = sum(amountUSD,na.rm = T))
    
    df3 <- 
      left_join(df_grid,
                df2,
                by = c("year","donor","recipient","flow_classification")) %>% 
      arrange(donor,year,recipient,flow_classification)
  }
  
  
  df <- df3
  out <- df
  
  # Names
  
  new_names <- names(df)[!names(df) %in% c(orig_names)]
  removed_names <- orig_names[!orig_names %in% names(df)]
    
  message(paste0("Cleaned ",dataset,"  Data.\n\n Original variable names contain:\n",paste0(orig_names,collapse = "; "),"\n\nnewly created variables contain:\n ",paste0(new_names,collapse = "; "),". \n\nRemoved variables are:\n ",paste0(removed_names,collapse = "; ")))
  
  
  
  return(out)
  })
  
  merged <- 
    dplyr::bind_rows(sepList)

return(merged)
}



# cl <- clean_china(dfCHINA,level = "full")
# cl2 <- clean_china(dfCHINA,level = "donor-year")
# cl3 <- clean_china(dfCHINA,level = "donor-year-recipient")
# cl4 <- clean_china(dfCHINA,level = "donor-year-recipient-flow_classification")
# 
# core <- clean_aidData(dfCORE,dataset = "Core",level = "full")
# core2 <- clean_aidData(dfCORE,dataset = "Core",level = "donor-year")
# core3 <- clean_aidData(dfCORE,dataset = "Core",level = "donor-year-recipient")
# core4 <- clean_aidData(dfCORE,dataset = "Core",level = "donor-year-recipient-flow_classification")

# merged <- clean_aidData(df_list = list(dfCORE,dfCHINA),
#                         dataset = c("Core","China"),
#                         level = "full")
# 
# merged2 <- clean_aidData(list(dfCORE,dfCHINA),
#                          dataset = c("Core","China"),
#                          level = "donor-year")
# 
# merged3 <- clean_aidData(list(dfCORE,dfCHINA),
#                          dataset = c("Core","China"),
#                          level = "donor-year-recipient")
# 
# merged4 <- clean_aidData(list(dfCORE,dfCHINA),
#                          dataset = c("Core","China"),
#                          level = "donor-year-recipient-flow_classification")

