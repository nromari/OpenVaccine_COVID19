Data=read.csv("sample_submission.csv")
# Le début du script = script du prof... à compléter avec commentaires et une meilleure explication des données
library(jsonlite)

out=lapply(readLines("test.json"),fromJSON)
out[[1]]$sequence
out[[1]]$structure
out[[1]]$predicted_loop_type

library(reticulate)
np=import("numpy")
# matrix data: probabilities that each pair of nucleotides in the RNA forms a base pair
data=np$load(paste("bpps/",out[[1]]$id,".npy",sep=""))
image(data)

#Helix, multibranch loop, hairpin  loop, internal loop, left bulge, right bulge
#S: paired "Stem"; M: Multiloop; I: Internal loop; B: Bulge; H: Hairpin loop; E: dangling End; X: eXternal loop;

#
library(RRNA)
str=out[[1]]$structure
seq=out[[1]]$sequence
ct=makeCt(str,seq)
coord=ct2coord(ct)
RNAPlot(coord,nt=TRUE,dp=0.75)

out=lapply(readLines("train.json"),fromJSON)
out[[1]]$sequence
out[[1]]$structure
out[[1]]$predicted_loop_type

#Stratégie :
## A partir de la matrice de probabilité data, faire une matrice d'adjacence en boléen --> trouver à partir de quel seuil de proba on a contact
## Suppression des lignes sans contact (à confirmer...) --> on obtient une matrice de contact
## Installation library igraph
## plot des graph (cf. script M1)
## calculs de paramètres (cf. scrpt M1)
## Découpages (cf. scrpt M1)
