# RShinyRMarkdown

This repository contains code relating to producing a dashboard in RMarkdown while integrating R shiny (dynamic elements/web application).
The code informs how to initialize and ask for multiple user inputs, reactive programming that returns calculated results with respect to user input, and ways to generate graphs whose parameters are reactive variables. This is done all in the context of an RMarkdown file (.RMD) as opposed to an app.R (.R) file.

It also introduces a way to scrape financial data using a ticker symbol representing a company's name from Yahoo Finance. 

Disclaimer: 
Followed along with Beyond Static Reports With R Markdown | RStudio Webinar - 2017. 

The code is not entirely my own work (although there are some very slight modifications to make the app run); it serves as a personal tutorial for how to develop more complicated web applications in R.

What I have done is re-purposed the code for .R file as opposed to an .RMD file. The difference is in syntax and placement of lines of code. I've also used this opportunity to learn how to deploy an app into a webpage, which is attached below. It will take a moment to process as it has to scrape the data from yahoo and perform initial calculations based on default values for parameters. 

An 'improvement' upon the application was added to impose that the portf. % sum to 100%. Whether this is this is correct in theory is besides the point; it is an exercise in having dynamically adjusted numeric inputs.


See webpage for deployed application:
https://benjnguyen.shinyapps.io/flexshiny/

Future Reference:
To deploy an app, use rsconnect::deployApp("directory for .rmd file here")
