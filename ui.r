
shinyUI(navbarPage(theme = "bootstrap.css",
  title = "IMDB Prediction",
  
  
  tabPanel('Boosted Trees',
  fluidRow(
		column(6,class='well',
		 
				column(6,
				  h5('Prediction Variables:'),
				  sliderInput("year", label = "Creation Year", min = 2000, 
				              max = 2030, value = 2016),
					selectInput("gender", label = "Gender",multiple=TRUE, 
						          choices = generos,selected="Drama"),
					selectInput("languages", label = "Language",multiple=TRUE, 
					            choices = languages, selected="English"),
				  selectInput("rated", label = "Rated",multiple=FALSE, 
				              choices = rated, selected=1),
		      textInput("plot", label = "Plot", value = "Type the movie's plot")
					
		       ),
				column(6,
				  br(),
				  br(),
				  sliderInput("release", label = "Released Year", min = 2000, 
				              max = 2030, value = 2016),
				  selectInput("actor", label = "Actors",multiple=TRUE,choices=actores,selected="Other"),
					selectInput("country", label = "Country",multiple=TRUE, 
					            choices = countries, selected="USA"),
					numericInput("runtime", label = "Runtime", value = 100)
				)),
		
		column(6,
		       plotlyOutput("text1",width="100%")
	))
)))