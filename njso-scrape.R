library(rvest)
library(stringr)

#get NJSO events at NJPAC
njpac <- read_html("https://www.njsymphony.org/events/venue/newark-njpac")

#event names
events <- njpac %>% html_elements(".title") %>% html_text2()

#event dates
event.dates <- njpac %>% html_elements(".date") %>% html_text2()

#pieces (songs performed), one list entry per event
songs <- njpac %>% html_elements(".info")
songs.list <- list()

for(i in seq_len(length(songs))){
  songs.list[[i]] <- songs %>% .[i] %>% html_elements(".link") %>% html_elements(".list") %>% html_elements("li") %>% html_text2() %>% str_split_fixed(pattern = "\n\n", n = 2) %>% .[,1]
}

#build output dataframe
output <- as.data.frame(matrix(data = NA, ncol = 3, ))
colnames(output) <- c("date", "title", "piece")

#populate dataframe, one piece per row
for(i in seq_len(length(songs.list))){
  current.length <- length(songs.list[[i]])
  output <- rbind(output, data.frame(date = rep(trimws(event.dates[i]), current.length), title = rep(events[i], current.length), piece = songs.list[[i]]))
}

output <- output[2:nrow(output),]

#ouput, encoding for Windows
write.table(output, file = "njso-njpac-2022-concerts.txt", sep = '\t', quote = F, row.names = F, col.names = T, 
            fileEncoding = "UTF-16LE")
