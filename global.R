library(plotly,quietly = T)
library(dplyr,quietly=T)
library(plyr,quietly=T)
library(gbm,quietly=T)
library(tm,quietly=T)
library(quanteda,quietly=T)
library(data.table,quietly=T)
library(stringr,quietly=T)
source("ngrams.r")


cngram <- read.table("NgramModel.csv",sep=",",header=T)
lanmodel <- read.table("LanModel.csv",sep=",",header=T)
counmodel <- read.table("CountryModel.csv",sep=",",header=T)
genmodel <- read.table("GenreModel.csv",sep=",",header=T)
actmodel <- read.table("ActorsModel.csv",sep=",",header=T)
ref <- read.csv(file="references.csv",header=T,stringsAsFactors = F,fileEncoding = 'UTF-8')
generos <- as.character(genmodel[,1])
languages <- as.character(lanmodel[,1])
countries <- as.character(counmodel[,1])
rated <- as.character(ref$Rated)[1:17]
actores <- as.character(actmodel[,1])

final <- readRDS("modeloFinal.rds")
