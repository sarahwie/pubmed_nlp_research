install.packages("XML")
library("XML")
library("methods")

#------------------------------------------------------------
# Testing
setwd("/home/sarahwie/Downloads/zip")

doc = xmlParse(file="medline16n0812.xml", useInternal=TRUE)
xmltop=xmlRoot(doc)
xmlName(xmltop)
xmlSize(xmltop)
head(names(xmltop))

pmid1 = xmlValue(xmltop[[1]][['PMID']])
typeof(pmid1)

top = xmlNode(xmlName(xmltop))
for(i in 1:5) top = addChildren(top, xmltop[[i]])
saveXML(top, file="out.xml")
file.show("out.xml")

#Testing PMID comparison
test_pmids = read.table("pmids_for_testing.txt", header=FALSE)
test_pmids = sapply(test_pmids, function(x){as.numeric(x)})

lst = list()
#for each record in file
for (i in 1:3){
  #pull out PMID of that record
  pmid1 = xmlValue(xmltop[[i]][['PMID']])
  #convert this to a numeric
  pmid1 = as.numeric(pmid1)
  lst = c(lst,pmid1)
  # if(pmid1 %in% test_pmids) {
  #   print("match")
  # } else {
  #   print("no match")
  # }
  
}
#Where I stopped: once have the 
indx = match(test_pmids,lst, nomatch=0)
xml[indx]

#loop through list
for (i in 1:length(indices)){
  
  #if value is not N/A,
  if (!is.na(indices[i])){
    
    #get XML record of that value
    print(xmltop[[indices[i]]])
  }
}

top <- xmlNode(xmlName(xmltop))
for(i in 1:5) top <- addChildren(top, xmltop[[i]])
saveXML(top, file="out.xml")
file.show("out.xml")
#------------------------------------------------------------

#read in .txt file of PMIDs as dataframe
#***Note: first open and save this .txt file on VM***
setwd("~/Downloads")
musc_pmids = read.table("MUSC_PMIDs.txt", header=FALSE)

#convert them to numeric
musc_pmids = sapply(musc_pmids, function(x){as.numeric(x)})


#change working directory to where xml files are
#***Note: remove .md5 files from this folder so that it's only .xml files (and only recent ones?)***
setwd("~/Desktop/PubMed")


#for each file in folder
for (fil in dir()){
  doc = xmlTreeParse(fil, useInternal=TRUE)
  top = xmlRoot(doc)
  
  #empty list
  lst = list()
  
  #for each record in file
  for (i in 1:xmlSize(top)){
    #pull out PMID of that record
    pmid1 = xmlValue(top[[i]][['PMID']])
    #convert this to a numeric
    pmid1 = as.numeric(pmid1)
    
    #add the pmid to the list in order of record
    lst = c(lst,pmid1)
    
    #search through pmids from .txt file for a match
    #if (pmid1 %in% musc_pmids){
      #TODO:export record as row of new data frame
      #TODO:remove this pmid from musc_pmids
    #}
  }
  
  #get indices in lst where musc_pmids can be found
  indices = match(musc_pmids,lst)
  
  #pull out those where indices is not NA
  #while indices[i] is not N/A
  #loop through each position and get top[[indices[i]]]
  
}