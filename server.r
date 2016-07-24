

lancreation <- function(x,lan){
  x <- data.frame(Language=x,Valor=1)
  y <- left_join(lan,x)
  lan$Valor <- ifelse(is.na(y$Valor),0,1)
  
  return(as.character(lan$Valor))
}

councreation <- function(x,coun){
  x <- data.frame(Country=x,Valor=1)
  y <- left_join(coun,x)
  coun$Valor <- ifelse(is.na(y$Valor),0,1)
  
  return(as.character(coun$Valor))
}

gencreation <- function(x,gen){
  x <- data.frame(Gender=x,Valor=1)
  y <- left_join(gen,x)
  gen$Valor <- ifelse(is.na(y$Valor),0,1)
  return(as.character(gen$Valor))
}

actcreation <- function(x,act){
  x <- data.frame(Actor=x,Valor=1)
  y <- left_join(act,x)
  act$Valor <- ifelse(is.na(y$Valor),0,1)
  return(as.character(act$Valor))
}

shinyServer(function(input, output) {
      vars <- reactive({
      p <- if (length(input$plot)==1) data.frame(a='pizza shit') else data.frame(a=input$plot)
      texto <- as.character(ngram(p,cngram)$Valor)
      idioma <- lancreation(if(length(input$languages)==0) factor('NO') else input$languages,lanmodel)
      pais <- councreation(if(length(input$country)==0) factor('NO') else input$country,counmodel)
      genero <- gencreation(if(length(input$gender)==0) factor('NO') else input$gender,genmodel)
      actor <- actcreation(if(length(input$actor)==0) factor('NO') else input$actor,actmodel)
      rat <- input$rated
      rel <- input$release
      run <- input$runtime
      yy <- input$year
     
      
      ##estructura texto
      namesid <-  as.character(t(cngram))
      texto <- as.matrix(texto)
      rownames(texto) <- namesid
      texto <- data.frame(t(texto))
      
      ##estructura idiomas
      namesid <-  as.character(t(lanmodel[1:nrow(lanmodel),]))
      idioma <- as.matrix(idioma)
      rownames(idioma) <- paste(c("Language"),namesid,sep="_")
      idioma <- data.frame(t(idioma))
      
      ##estructura genero
      namesid <-  as.character(t(genmodel[1:nrow(genmodel),]))
      genero <- as.matrix(genero)
      rownames(genero) <- paste(c("Genre"),namesid,sep="_")
      genero <- data.frame(t(genero))
      
      ##estructura paises
      namesid <-  as.character(t(counmodel))
      pais <- as.matrix(pais)
      rownames(pais) <- paste(c("Country"),namesid,sep="_")
      pais <- data.frame(t(pais))
      
      ##estructura actores
      
      namesid <-  as.character(t(actmodel))
      actor <- as.matrix(actor)
      rownames(actor) <- paste(c("Actor"),namesid,sep="_")
      actor <- data.frame(t(actor))
      
      out <- data.frame(Rated=rat,Released=rel,Runtime=run,Year=yy)
      out <- cbind(out,genero,actor,pais,idioma,texto)
      set.seed(100)
      pred <- predict(final,out,n.trees=500,type="response")
      
      pp <- data.frame(Labels="FailureProb",Prob=pred)
      
      pp <- rbind(pp,data.frame(Labels="SuccessProb",Prob=1-pp$Prob))
      p1 <- plot_ly(pp,labels=Labels,values=Prob,type="pie",
                    marker=list(colors=c('#1D3557','#E63946')),insidetextfont=list(color='white'))%>%
                    layout(margin=list(t=100),title='Estimated Probability of Success',font=list(family='sans-serif',color='#535353'))
      
      return(p1)
      })
      
   output$text1 <- renderPlotly({ 
      print(vars())
         })
})