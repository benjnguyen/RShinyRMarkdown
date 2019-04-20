# RShinyRMarkdown

This repository contains code relating to producing a dashboard in RMarkdown while integrating R shiny (dynamic elements/web application).
The code informs how to initialize and ask for multiple user inputs, reactive programming that returns calculated results with respect to user input, and ways to graphs whose parameters are reactive variables. This is done all in the context of an RMarkdown file (.RMD) as opposed to an app.R (.R) file.

It also introduces a way to scrape financial data using a ticker symbol representing a company's name from Yahoo Finance. An improvement upon the application would be to impose that the portf. % sum to 100% and when the sum reaches 100%, that the numeric inputs restrict themselves to impose the implied percentage of portfolio constraint.

Disclaimer: 
Followed along with Beyond Static Reports With R Markdown | RStudio Webinar - 2017. 
The code is not my own work (although there are some very slight modifications to make the app run); it serves as a personal tutorial for how to develop more complicated web applications in R.