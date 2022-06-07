library(rvest)
library(stringr)

#get all NY Philharmonic 2022-23 Season Events
nyphil <- read_html("https://nyphil.org/calendar?season=23&page=all")

# main content class holds dates and times
#date
event.dates <- nyphil %>% html_elements(".eventListItem22") %>% html_element(".eventListItem22__main-content") %>% 
  html_element(".eventListItem22__date") %>% html_text2() %>% str_split("\n\r\n") %>% 
  lapply(FUN = function(x) paste(trimws(unlist(x)), collapse = " ")) %>% unlist()

#time
event.times <- nyphil %>% html_elements(".eventListItem22" )%>% html_element(".eventListItem22__main-content") %>% 
  html_element(".eventListItem22__heading__time") %>% html_text2()

#event title
event.titles <- nyphil %>% html_elements(".eventListItem22") %>% html_element(".eventListItem22__main-content") %>% 
  html_element(".eventListItem22__title") %>% html_text2()


# details class holds pieces (songs)
#pieces (songs performed), one list entry per event
songs <- nyphil %>% html_elements(".eventListItem22")
songs.list <- list()

for(i in seq_len(length(songs))){
  songs.list[[i]] <- songs %>% .[i] %>% html_element(".eventListItem22__details__list") %>% 
    html_elements("li") %>% html_text2()
}

#build output dataframe
output <- as.data.frame(matrix(data = NA, ncol = 4, ))
colnames(output) <- c("date", "time", "title", "piece")

#populate dataframe, one piece per row
for(i in seq_len(length(songs.list))){
  current.length <- length(songs.list[[i]])
  output <- rbind(output, data.frame(date = rep(trimws(event.dates[i]), current.length), 
                                     time = rep(trimws(event.times[i]), current.length), 
                                     title = rep(event.titles[i], current.length), 
                                     piece = songs.list[[i]]))
}

output <- output[2:nrow(output),]

#ouput, encoding for Windows
write.table(output, file = "nyphil-2022-concerts.txt", sep = '\t', quote = F, row.names = F, col.names = T, 
            fileEncoding = "UTF-16LE")
