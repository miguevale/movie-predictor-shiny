ngram <- function(input,b) {
  wordsToRemove = c('get', 'cant', 'can', 'now', 'just', 'will', 'dont', 'ive', 'got', 'much')
  CorpusTranscript = Corpus(VectorSource(input$a))
  CorpusTranscript = tm_map(CorpusTranscript, content_transformer(tolower), lazy = T)
  CorpusTranscript = tm_map(CorpusTranscript, PlainTextDocument, lazy = T)
  CorpusTranscript = tm_map(CorpusTranscript, removePunctuation)
  CorpusTranscript = tm_map(CorpusTranscript, removeWords, stopwords("english"))
  CorpusTranscript = tm_map(CorpusTranscript, removeNumbers)
  TermMatrix = DocumentTermMatrix(CorpusTranscript)
  TermMatrix = removeSparseTerms(TermMatrix, 0.98) # keeps a matrix 99% sparse
  TermMatrix = as.data.frame(as.matrix(TermMatrix))
  colnames(TermMatrix) = make.names(colnames(TermMatrix))
  
  ##Integra ContenidoFiltrado a a input
  
  input$a = ""
  for (i in 1:dim(input)[1]){
    input$a[i] = CorpusTranscript[[i]]$content
  }
  
  ##Genera Tockens y Ngrams
  mytokTxts = tokenize(input$a, ngrams = 2)
  mytokTxts = dfm(mytokTxts)
  freq_ngrams = colSums(mytokTxts)
  freq_ngrams = freq_ngrams[order(freq_ngrams, decreasing = T)]
  max = length(freq_ngrams)
  selected_ngrams = rownames(as.data.frame(freq_ngrams[1:max]))
  ngrams = as.data.frame(as.matrix(mytokTxts[,selected_ngrams]))
  rownames(ngrams) <- rownames(data)
  X = cbind(TermMatrix, ngrams)
  res <- data.frame(Ngram=colnames(X),Valor=rep(1,length(colnames(X))))
  aa <- left_join(b,res)
  aa$Valor <- ifelse(is.na(aa$Valor),0,1)
  return(aa)
  #input_ngrams<-cbind(input,ngrams)
  
  
}

x <- c("Kate and her actor brother live in N.Y. in the 21st Century. Her ex-boyfriend, Stuart, lives above her apartment. Stuart finds a space near the Brooklyn Bridge where there is a gap in time....")
