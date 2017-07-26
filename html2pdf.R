HTMLasPDF <- function(domain, out.dir){
  
  # Saves PDF files of each webpage in "domain" to out.dir
  # Requires wget and wkhtmltopdf
  # Written July 20, 2017 by Jacob Schaperow
  
  # DOES NOT WORK BC I HAVE NOT BEEN ABLE TO FORMAT CMD CORRECTLY FOR THE CAT CMD
  
  # Get list of urls
  cmd <- paste("wget -mk --spider -r -l2", domain, "-o", 
               file.path(out.dir, "urlinfolist.txt"))
  system(cmd)

  urlname <- file.path(out.dir, "urllist.txt")
  
  cmd <- paste("cat", file.path(out.dir, "urlinfolist.txt"), "| tr ' ' ' \\012  | grep \"^http\" | egrep -vi \"[?]|[.]jpg$\" | sort -u", urlname)
  
  cmd <- gsub("([\])","",cmd)
  cmd <- gsub("([\n])","\\012",cmd)
  
  system(cmd)

  urls <- read.table(urlname, stringsAsFactors = F)
  
  # Convert webpages to PDFs using wkhtmltopdf tool
  setwd(out.dir)
  for (i in 1:length(urls)) {
    in.html <- urls[i,1]
    out.pdf <- paste0("page_", i ,".pdf")
    cmd <- paste("wkhtmltopdf --javascript-delay 1", in.html, out.pdf)
    system(cmd)
  }

}

domain <- "http://milkoolongstudio.com/"
out.dir <- "/Users/jschapMac/Documents/Codes"
HTMLasPDF_v2(domain, out.dir)

# Credit to https://webmasters.stackexchange.com/questions/47085/is-there-an-xml-sitemap-generator-with-command-line-interface-for-nginx-on-linux for the wget codes
  

# This is what I want the command to look like:
# cat urlinfolist.txt | tr ' ' '\012' | grep "^http" | egrep -vi "[?]|[.]jpg$" | sort -u > urllist.txt
# This is what the command looks like:
# cat urlinfolist.txt | tr ' ' ' \\012  | grep \"^http\" | egrep -vi \"[?]|[.]jpg$\" | sort -u urllist.txt

name <- "^http"
