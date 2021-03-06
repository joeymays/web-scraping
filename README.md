---
subject: "web scraping"
date: 2022-06-06
author: "Joey Mays"
---

# Web Scraping

Easy web scraping snippets in R.

## Motivation

### Short Version

I learned basic web scraping to save time finding concert dates.

### Details

I've never done any web scraping before. I'm annoyed I hadn't thought to try earlier, because it's quite easy and actually pretty easy, at least in this case.

I wanted to go through the schedules for the New Jersey Symphony Orchestra (NJSO) and the New York Philharmonic (NYPhil) and pick out some upcoming shows. As a recovering band kid, I do love going to see the orchestra, but I'm pretty picky about what music I want to hear. Plus, the tickets can be expensive. I usually go through the orchestra's website and write down a few pieces from the concert shedule I know or I think I might enjoy. Then I go back and check dates and prices to find something that works.

I figured I could save a lot of time if I didn't have to manually write down the shows while I searched. I could of course copy and paste everything into a note on my computer, but that gets messy quick. I figured if I had a spreadsheet of all the dates, I could easily search through, highlight some shows that look interesting and delete shows I definitely don't care to see.

## Process

### Toolkit

- `rvest` R package
- `stringr` R package

### Details

I used the R package `rvest` to scrape the concert schedules from the NJSO and NYPhil websites and put them into a text file I could import into Excel. Luckily, the elements that I needed to find (the events, dates, times, and pieces performed) could be easily identified in the html source code and pulled out using `rvest::html_element()`. With some tidying (via `stringr`) and organization, I was able to find the information I wanted and output into a neat spreadsheet to look through. The code itself isn't the most elegant, and there are probably better ways to pull out the data (e.g. separate composer from title in the NJSO data), but I'm going for mimimum viable product here. 

## Citations

- Wickham H (2022). rvest: Easily Harvest (Scrape) Web Pages. https://rvest.tidyverse.org/, https://github.com/tidyverse/rvest.
- Wickham H (2022). stringr: Simple, Consistent Wrappers for Common String Operations. http://stringr.tidyverse.org, https://github.com/tidyverse/stringr.
