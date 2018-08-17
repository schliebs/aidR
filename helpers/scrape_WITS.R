countrynames_WITS<- c("Angola","Benin","Botswana","Burkina Faso","Burundi","Cape Verde","Cameroon","Central African Republic","Chad","Comoros",
                      "Congo, Rep.","Cote d Ivoire","Djibouti", "Equatorial Guinea","Eritrea","Ethiopia(excludes Eritrea)","Gabon",
                      "Gambia, The","Ghana","Guinea","Guinea-Bissau", "Kenya","Lesotho","Liberia","Madagascar","Malawi","Mali","Mauritania","Mauritius",
                      "Mozambique","Namibia","Niger","Nigeria", "Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia",
                      "South Africa","South Sudan", "Sudan","Swaziland","Togo","Uganda","Tanzania","Zambia","Zimbabwe")

countrycodes_3<- c("AGO","BEN","BWA","BFA","BDI","CPV","CMR","CAF","TCD","COM","COG","CIV","ZAR","DJI","GNQ","ERI","ETH","GAB","GAM",
                   "GHA","GNB","GIN","KEN","LSO","LBR","MDG","MWI","MLI","MRT","MUS","MOZ","NAM","NER","NGA","RWA","STP","SEN","SYC",
                   "SLE","SOM","ZAF","SSD","SDN","SWZ","TGO","UGA","TZA","ZMB","ZWE")

library("rvest")
library("RSelenium")
library("wdman")

countrynames_donors<-c("United States", "Germany", "France", "United Kingdom","Japan", 
                       "Netherlands", "Canada", "Sweden", "Italy", "Norway", "China")

donors_codes <- c("USA","DEU","FRA","GBR","JPN","NLD","CAN","SWE","ITA","NOR","CHN")


human_wait = function(t = 5, tt = 7){
  Sys.sleep(sample(seq(t, tt, by=0.001), 1)) 
}

pathh <- "C:/Users/Schliebs/Desktop/ecpr_2018/data/wits_download_donors"

eCaps <- list(
  chromeOptions = 
    list(prefs = list(
      "profile.default_content_settings.popups" = 0L,
      "download.prompt_for_download" = FALSE,
      "download.default_directory" = pathh
    )
    )
)

#############################


rd = rsDriver(extraCapabilities = eCaps)  
remdr = rd[["client"]] 
remdr$maxWindowSize()

for (cn in donors_codes[6]){
#for (cn in "TZA"){
  print(Sys.time())
  
  tryCatch({
    
  for(year in c(2010:2016)){
    
    # if ("WITS-Partner (100).xlsx" %in% list.files(eCaps$chromeOptions$prefs$download.default_directory)){}
    
    print(paste0(cn,year))
    
    urll <- paste0("https://wits.worldbank.org/CountryProfile/en/Country/",cn,"/Year/",year,"/TradeFlow/EXPIMP/Partner/all/Product/Total")
    
    remdr$navigate(urll) 
    
    remdr$findElement(using = 'xpath', value = '//*[@id="DataDownload"]')$clickElement()
    
    remdr$findElement(using = 'xpath', value = '//*[@id="dropDownFileFormat"]/li/a/span[2]')$clickElement()

    
    print(year)
    
    list.files(pathh)
    human_wait(1,2)
    
    whichyear <- year
    
    # for (q in 1:10){
    # if(!file.exists(paste0(pathh,"/","WITS-Partner.xlsx"))) next
    file.rename(paste0(pathh,"/","WITS-Partner.xlsx"), paste0(pathh,"/",cn,"-",whichyear,".xlsx"))
    #}
    
    human_wait(1,2)
    
    }
    
   })
}


#####################

# get country/years

# countriess <- '//*[@id="selectedCountryRegion"]'
# countriess2 <- '//*[@id="dropdownlistContentbyCountry_country_dropdown"]'
# countriess3 <- '//*[@id="listBoxContentinnerListBoxbyCountry_country_dropdown"]/div'
# 
# remdr$findElement(using = 'xpath', value = countriess)$clickElement()
# remdr$findElement(using = 'xpath', value = countriess2)$clickElement()
# remdr$findElement(using = 'xpath', value = countriess3)$getElementText()

##




