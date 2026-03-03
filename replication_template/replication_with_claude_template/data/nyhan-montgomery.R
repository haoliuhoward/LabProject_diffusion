library(network)
library(foreign)
library(sna)
library(spdep)
library(plyr)
library("multicore")
library("foreach")
library("doMC")

#set your working directory to the data subfolder

#largest connected components of Democratic network (2002)
adjjd<-read.dta("consultcandmatrix-jd-d02.dta")
adj<-as.matrix(adjjd[,-1])
inclvec<-component.largest(adj,connected="weak")
inclveccand<-inclvec[66:115]
candnames<-as.matrix(read.csv("canddata-jd-names-d02.csv",header=FALSE)[,1])
candnames<-cbind(candnames,inclveccand)[inclveccand==TRUE,]
inclvecconsult<-inclvec[1:65]
consnames<-as.matrix(read.csv("consultdata-jd-names-d02.csv",header=FALSE)[,1])
consnames<-cbind(consnames,inclvecconsult)[inclvecconsult==TRUE,]
adjnet<-network(component.largest(adj,connected="weak",result="graph"),directed=FALSE,bipartite=length(consnames[,1]))
network.vertex.names(adjnet)<-c(consnames[,1],candnames[,1])
consvec<-c(rep(1,length(consnames[,1])),rep(0,length(candnames[,1])))
set.vertex.attribute(adjnet,"consultant",consvec)

## Figure 1
pdf(file="figure1.pdf",width=11,height=8)
plot(adjnet,vertex.col="consultant",cex=.5,displayisolates=FALSE,label=network.vertex.names(adjnet),interactive=FALSE)
dev.off()
#NOTE: interactive feature was used to adjust layout to maximize readability

#project Democratic 2002 candidate-consultant adjacency matrix to form candidate network and plot
adjjd<-read.dta("consultcandmatrix-jd-d02.dta")
adj<-as.matrix(adjjd[,-1])
adjnet<-network(adj,directed=FALSE,bipartite=length(consnames))
cand<-t(as.sociomatrix.sna(adjnet)) %*% as.sociomatrix.sna(adjnet)
candnet<-network(cand,directed=FALSE,bipartite=FALSE)
candnames<-as.matrix(read.csv("canddata-jd-names-d02.csv",header=FALSE)[,1])
network.vertex.names(candnet)<-c(candnames)
candnet.largest<-network(component.largest(candnet,connected="weak",result="graph"),directed=FALSE,bipartite=FALSE)
inclvec<-component.largest(candnet,connected="weak")
newnames<-cbind(candnames,inclvec)[inclvec==TRUE,]
candnet.largestd02<-candnet.largest
network.vertex.names(candnet.largestd02)<-c(newnames)
network.vertex.names(candnet.largest)<-c(newnames[,1])

## Figure 2
pdf(file="figure2.pdf",width=11,height=8)
plot(candnet.largest,vertex.col="white",label=network.vertex.names(candnet.largest),interactive=FALSE)
dev.off()
#NOTE: interactive feature was used to adjust layout to maximize readability

## Note: Table 1 replication is shown in the Stata *.do file.

##### Preparing to make main regression tables #######
## Read in different adjacency matrices 
adjMatLog <- read.dta("allCand-log-after-proj.dta") #logged dollars
adjMatLog<-as.matrix(adjMatLog, rownames.force = FALSE)
adjMatBin <- (adjMatLog>0)*1 #binary
adjMatShared<- read.dta("allCand-shared-cons.dta") #Count of shared consultants
adjMatShared <- as.matrix(adjMatShared, rownames.force = FALSE)

## Read in Druckman data reduced to the covariate set/observations used
DruckData.Reduced <- read.csv("MainRegressionData.csv")

## my.spat3 is a wrapper function for executing the spatial regressions while correctly handling missing data.
my.spat3<-function(form, adj.matrix , data = DruckData.Reduced, selector){
  form=this.mod
  startlist<-adj.matrix
  dataset<-data
  startlist0<-startlist[selector, selector]
  final.list<-mat2listw(startlist0, style="W")
  final.data<-dataset[selector,]
  (summary(
           lagsarlm(form, data=final.data, listw=final.list, zero.policy=TRUE)
           )
   )
}

################# TABLE 2

## Table 2: Column 1 
this.mod <- risk ~ y2004 + y2006 + democrat +  open + chall + factor(newdistAlt)+ factor(region) 
t2c1<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)))
t2c1

## Table 2: Column 2 
this.mod <- risk ~ y2004 + y2006 + democrat +  open + chall + factor(newdistAlt)+ factor(region) + cfscore
t2c2<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist) & !is.na(DruckData.Reduced$cfscore)))
t2c2

## Table 2: Column3
this.mod <- issueowner ~ y2004 + y2006 + democrat + open + chall +   factor(newdistAlt) + factor(region) + isssal2
t2c3<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$issueowner) & !is.na(DruckData.Reduced$newdist)))
t2c3

## Table 2: Column4
this.mod <- issueowner ~ y2004 + y2006 + democrat + open + chall +   factor(newdistAlt) + factor(region) + cfscore + isssal2 + cfscore
t2c4<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$issueowner) & !is.na(DruckData.Reduced$newdist) & !is.na(DruckData.Reduced$cfscore)))
t2c4

################# TABLE 3

### Table 3: Column 1 - non incumbents
this.mod <- risk ~ y2004 + y2006 + democrat +  chall + factor(newdistAlt)+ factor(region)
t3c1<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist))  & DruckData.Reduced$incumbent == 0)
t3c1

### Table 3: Column 2 - incumbents
this.mod <- risk ~ y2004 + y2006 + democrat +  factor(newdistAlt)+ factor(region) 
t3c2<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$incumbent == 1)
t3c2

### Table 3: Column 3 - unfavorable district
this.mod <- risk ~ y2004 + y2006 + democrat + open +  chall + factor(newdistAlt)+ factor(region) 
t3c3<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$newdistAlt<=1)
t3c3

### Table 3: Column 4 - favorable district
this.mod <- risk ~ y2004 + y2006 + democrat +  open + chall + factor(newdistAlt)+ factor(region) 
t3c4<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$newdistAlt>=2)
t3c4

################  TABLE 4

### Table 4: Column 1 - non incumbents
this.mod <- issueowner ~ y2004 + y2006 + democrat +  chall + factor(newdistAlt)+ factor(region)  + isssal2
t4c1<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$incumbent == 0)
t4c1

### Table 4: Column 2 - incumbents
this.mod <- issueowner ~ y2004 + y2006 + democrat +  factor(newdistAlt)+ factor(region)  + isssal2
t4c2<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$incumbent == 1)
t4c2

### Table 4: Column 3 - unfavorable district
this.mod <- issueowner ~ y2004 + y2006 + democrat + open +  chall + factor(newdistAlt)+ factor(region)  + isssal2
t4c3<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$newdistAlt<=1)
t4c3

### Table 4: Column 4 - favorable district
this.mod <- issueowner ~ y2004 + y2006 + democrat +  open + chall + factor(newdistAlt)+ factor(region)  + isssal2
t4c4 <- my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$newdistAlt>=2)
t4c4

################ TABLE SI-2

## As part of our cleaning, we checked the records in the FEC against Campaigns & Elections.  This helped us
## catch some dyads that had been inadverently dropped in the data cleaning or as a result of a coding error.  
## Table SI-2 reports how our FEC approach compares with the C&E approach.

dyadAnalysis <- read.csv("CEDyads.csv", row.names=NULL)

# total number we cannot find
DyadsNotFound <- table(dyadAnalysis$ReasonNotFound)[4]+ # Cases that are not visible in any FEC records
table(dyadAnalysis$FailedToFind)[1] # This last term is cases that were "incorrectly" failed to find them due to cleaning errors, etc.  
# Note that these dydads are included in the main analyses
DyadsNotFound

DyadsFound <- dim(dyadAnalysis)[1]-63
DyadsFound

## Total number of dyads located in the FEC dataset was 1194
1194-DyadsFound #Dyads in the FEC records not found in the C&E report

################# TABLE SI-3

### Table SI-3: Column 1 - non incumbents, risk, logged
this.mod <- risk ~ y2004 + y2006 + democrat +  chall + factor(newdistAlt)+ factor(region) 
a3c1<-my.spat3(form=this.mod, adj.matrix=adjMatLog, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$incumbent == 0)
a3c1

### Table SI-3: Column 2 - difficult district, risk, logged
this.mod <- risk ~ y2004 + y2006 + democrat + open +  chall + factor(newdistAlt)+ factor(region) 
a3c2<-my.spat3(form=this.mod, adj.matrix=adjMatLog, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$newdistAlt<=1)
a3c2

### Table SI-3: Column 3 - non incumbents, risk, binary
this.mod <- risk ~ y2004 + y2006 + democrat +  chall + factor(newdistAlt)+ factor(region) 
a3c3<-my.spat3(form=this.mod, adj.matrix=adjMatBin, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$incumbent == 0)
a3c3

### Table SI-3: Column 4 - difficult district, risk, binary
this.mod <- risk ~ y2004 + y2006 + democrat + open +  chall + factor(newdistAlt)+ factor(region) 
a3c4<-my.spat3(form=this.mod, adj.matrix=adjMatBin, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$newdistAlt<=1)
a3c4

#################  TABLE SI-4

### Table SI-4: Column 1 - non incumbents,issueowner, logged
this.mod <- issueowner ~ y2004 + y2006 + democrat +  chall + factor(newdistAlt)+ factor(region) + isssal2
a4c1<-my.spat3(form=this.mod, adj.matrix=adjMatLog, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$incumbent == 0)
a4c1

### Table SI-4: Column 2 - difficult district, issueowner, logged
this.mod <- issueowner ~ y2004 + y2006 + democrat + open +  chall + factor(newdistAlt)+ factor(region) +isssal2
a4c2<-my.spat3(form=this.mod, adj.matrix=adjMatLog, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$newdistAlt<=1)
a4c2

### Table SI-4: Column 3 - non incumbents, issueowner, binary
this.mod <- issueowner ~ y2004 + y2006 + democrat +  chall + factor(newdistAlt)+ factor(region) +isssal2
a4c3<-my.spat3(form=this.mod, adj.matrix=adjMatBin, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$incumbent == 0)
a4c3

### Table SI-4: Column 4 - difficult district, issueowner, binary
this.mod <- issueowner ~ y2004 + y2006 + democrat + open +  chall + factor(newdistAlt)+ factor(region) +isssal2
a4c4<-my.spat3(form=this.mod, adj.matrix=adjMatBin, selector=c(!is.na(DruckData.Reduced$risk) & !is.na(DruckData.Reduced$newdist)) & DruckData.Reduced$newdistAlt<=1)
a4c4

################# TABLE SI-5

### Column 1
this.mod <- positions ~ y2004 + y2006 + democrat +  open + chall +  factor(region) + factor(newdistAlt)
a5c1<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$positions) & !is.na(DruckData.Reduced$newdist)))
a5c1

### Column 2
this.mod <- positions ~ y2004 + y2006 + democrat +  open + chall +  factor(region) + factor(newdistAlt)
a5c2<-my.spat3(form=this.mod, adj.matrix=adjMatLog, selector=c(!is.na(DruckData.Reduced$positions) & !is.na(DruckData.Reduced$newdist)))
a5c2

### Column 3
this.mod <- positions ~ y2004 + y2006 + democrat +  open + chall +  factor(region) + factor(newdistAlt)
a5c3<-my.spat3(form=this.mod, adj.matrix=adjMatBin, selector=c(!is.na(DruckData.Reduced$positions) & !is.na(DruckData.Reduced$newdist)))
a5c3

### Column 4
this.mod <- goneg ~ y2004 + y2006 + democrat +  open + chall +  factor(region) + factor(newdistAlt) 
a5c4<-my.spat3(form=this.mod, adj.matrix=adjMatShared, selector=c(!is.na(DruckData.Reduced$goneg) & !is.na(DruckData.Reduced$newdist)))
a5c4

### Column 5
this.mod <- goneg ~ y2004 + y2006 + democrat +  open + chall +  factor(region) + factor(newdistAlt) 
a5c5<-my.spat3(form=this.mod, adj.matrix=adjMatLog,  selector=c(!is.na(DruckData.Reduced$goneg) & !is.na(DruckData.Reduced$newdistAlt)))
a5c5

### Column 6
this.mod <- goneg ~ y2004 + y2006 + democrat +  open + chall +  factor(region) + factor(newdistAlt)
a5c6<-my.spat3(form=this.mod, adj.matrix=adjMatBin, selector=c(!is.na(DruckData.Reduced$goneg) & !is.na(DruckData.Reduced$newdist)))
a5c6

################# FIGURE SI-3

##All permutation matrices are provided in the subdirectories specified below.  Here is example code for how they were created.  Since this is a simulation, and we did not set the seed, the results may not match precisely.

##build permuted 2002-2006 adjacency matrix (exchange within same party-year-race type groups)
#adjjd<-read.dta("consultcandmatrix-jd.dta")
#adj<-as.matrix(adjjd[,-1])
##read in permutation vector defining party-year-race type groups
#permvec <- read.csv("cand-partyyearrace-groups.csv",header=FALSE)

#j<-1
#while (j<501) {
##permute column loctions randomly using rperm function from sna library
#adj<-adj[,rperm(as.matrix(permvec))]
##don't pass through network package to speed up
#cand<-t(adj) %*% adj
#diag(cand) <- 0
#filename<-paste("partyyearraceSHARED/cand-jd-pyr-",j,".csv",sep="")
#write.table(as.matrix(cand),file=filename,sep=",",row.names=FALSE,col.names=FALSE)
#j<-j+1
#}

## Function for automating the running of the file
my.spat.false.test<-function(adj.matrix.num, form, adj.matrix.stub ="cand-jd-pyr-", data = DruckData.Reduced, miss){
  adj.matrix<- read.csv(paste(adj.matrix.stub, adj.matrix.num, ".csv", sep=""), header=FALSE) 
  adj.matrix <- adj.matrix[miss, miss]
  adj.matrix <- as.matrix(adj.matrix, rownames.force = FALSE)
  data<-data[miss,]
  final.list<-mat2listw(adj.matrix, style="W")
  model <- lagsarlm(form, data=data, listw=final.list, zero.policy=TRUE)
  list(summary(model)$LR1, model$rho)
}

## Set up the multiple cores. May not work on Windows machines
#registerDoMC(cores=20)
setwd("./partyyearraceSHARED/")

riskPYR <- alply(c(1:500), 1, my.spat.false.test,
                 form= risk ~ y2004 + y2006 + democrat +  open + chall + factor(newdistAlt)+ factor(region),
                 miss= !is.na(DruckData.Reduced$risk)&!is.na(DruckData.Reduced$newdist),
                 .parallel=TRUE
                 )
issPYR<- alply(c(1:500), 1, my.spat.false.test,
               form= issueowner ~ y2004 + y2006 + democrat + open + chall + factor(newdistAlt) + factor(region) + isssal2,
               miss= !is.na(DruckData.Reduced$isssal2)&!is.na(DruckData.Reduced$newdist),
               .parallel=TRUE
               )

setwd("../regionpartyyearSHARED/")

riskSPY <- alply(c(1:500), 1, my.spat.false.test,
                 form= risk ~ y2004 + y2006 + democrat +  open + chall + factor(newdistAlt)+ factor(region),
                 miss= !is.na(DruckData.Reduced$risk)&!is.na(DruckData.Reduced$newdist),
                 adj.matrix.stub="cand-jd-spy-",
                 .parallel = TRUE
                 )

issSPY<- alply(c(1:500), 1, my.spat.false.test,
               form= issueowner ~ y2004 + y2006 + democrat + open + chall +   factor(newdistAlt) + factor(region) + isssal2,
               miss= !is.na(DruckData.Reduced$isssal2)&!is.na(DruckData.Reduced$newdist),
               adj.matrix.stub="cand-jd-spy-",
               .parallel=TRUE
               )

setwd("../partyyearpresSHARED/")

riskPYP <- alply(c(1:500), 1, my.spat.false.test,
                 form= risk ~ y2004 + y2006 + democrat +  open + chall + factor(newdistAlt)+ factor(region),
                 miss= !is.na(DruckData.Reduced$risk)&!is.na(DruckData.Reduced$newdist),
                 adj.matrix.stub="cand-jd-pyp-",
                 .parallel = TRUE
                 )

issPYP<- alply(c(1:500), 1, my.spat.false.test,
               form= issueowner ~ y2004 + y2006 + democrat + open + chall +   factor(newdistAlt) + factor(region) + isssal2,
               miss= !is.na(DruckData.Reduced$isssal2)&!is.na(DruckData.Reduced$newdist),
               adj.matrix.stub="cand-jd-pyp-",
               .parallel=TRUE
               )

## Function to grab all LR stats

grabber<-function(obj){
 out<-rep(NA, 500)
  for(i in 1:500){
    out[i] <- unclass(obj[[i]][[1]][[1]])[1]
  }
return(out)
}

mcRiskPYR<-grabber(riskPYR); mcIssPYR<-grabber(issPYR)
mcRiskSPY<-grabber(riskSPY); mcIssSPY<-grabber(issSPY)
mcRiskPYP<-grabber(riskPYP); mcIssPYP<-grabber(issPYP)

### Make the actual figure
par(mfrow=c(3,2), cex.axis=.65, mar=c(2,2,3,0))
par(tcl=0, mgp=c(1,0,0))
plot(density(mcRiskPYR, from=min(mcRiskPYR), to=max(mcRiskPYR)), xlab="", main="Risk: Permutations by candidate type")
abline(v= 5.111, lty=2)
rug(mcRiskPYR)
par(tcl=.5)
axis(3, at=quantile(mcRiskPYR, c(.5, .9,  .95, .99)),  padj=0, labels=c("50%","90%", "95%", "99%"), cex=.6)
text(5.159, .3, "Observed value", cex=1, pos=4)
par(tcl=0, mgp=c(1,0,0))
plot(density(mcIssPYR, from=min(mcIssPYR), to=max(mcIssPYR)), xlab="", ylab="", main="Issues: Permutations by candidate type")
abline(v= 49.066, lty=2)
text(66, .035, "Observed value", cex=1, pos=2)
rug(mcIssPYR)
par(tcl=.5)
axis(3, at=quantile(mcIssPYR, c(.5, .9,  .95, .99)),  padj=0, labels=c("50%","90%", "95%", "99%"), cex=.6)
par(tcl=0, mgp=c(1,0,0))
plot(density(mcRiskPYP, from=min(mcRiskPYP), to=max(mcRiskPYP)), xlab="",  main="Risk: Permutations by district type")
abline(v= 5.111, lty=2)
rug(mcRiskPYP)
par(tcl=.5)
axis(3, at=quantile(mcRiskPYP, c(.5, .9,  .95, .99)),  padj=0, labels=c("50%","90%", "95%", "99%"), cex=.6)
text(5.159, .3, "Observed value", cex=1, pos=4)
par(tcl=0, mgp=c(1,0,0))
plot(density(mcIssPYP, from=min(mcIssPYP), to=max(mcIssPYP)), xlab="",ylab="", main="Issues: Permutations by district type")
abline(v= 49.066, lty=2)
text(49, .035, "Observed value", cex=1, pos=2)
rug(mcIssPYP)
par(tcl=.5)
axis(3, at=quantile(mcIssPYP, c(.5, .9,  .95, .99)),  padj=0, labels=c("50%","90%", "95%", "99%"), cex=.6)
text(5.159, .3, "Observed value", cex=1, pos=4)
par(tcl=0, mgp=c(1,0,0))
plot(density(mcRiskSPY, from=min(mcRiskSPY), to=max(mcRiskSPY)), xlab="Likelihood ratio statistic (Monte Carlo)", main="Risk: Permutations by region")
abline(v= 5.111, lty=2)
text(5.1159, .3, "Observed value", cex=1, pos=4)
rug(mcRiskSPY)
par(tcl=.5)
axis(3, at=quantile(mcRiskSPY, c(.5, .9,  .95, .99)),  padj=0, labels=c("50%","90%", "95%", "99%"), cex=.6)
par(tcl=0, mgp=c(1,0,0))
plot(density(mcIssSPY, from=min(mcIssSPY), to=max(mcIssSPY)), ylab="",xlab="Likelihood ratio statistic (Monte Carlo)", main="Issues: Permutations by region", ylim=c(0,.051))
abline(v= 49.066, lty=2)
text(49, .035, "Observed value", cex=1, pos=2)
rug(mcIssSPY)
par(tcl=.5)
axis(3, at=quantile(mcIssSPY, c(.5, .9,  .95, .99)),  padj=0, labels=c("50%","90%", "95%", "99%"), cex=.6)
text(8, .3, "Observed value", cex=.8)
segments(7, .27, 5.159, .2)
### End figure code

#percentage less than observed values
100-(100*(sum(mcRiskPYR>5.111)/sum(!is.na(mcRiskPYR))))
100-(100*(sum(mcRiskSPY>5.111)/sum(!is.na(mcRiskSPY))))
100-(100*(sum(mcRiskPYP>5.111)/sum(!is.na(mcRiskPYP))))

100-(100*(sum(mcIssPYR>49.066)/sum(!is.na(mcIssPYR))))
100-(100*(sum(mcIssSPY>49.066)/sum(!is.na(mcIssSPY))))
100-(100*(sum(mcIssPYP>49.066)/sum(!is.na(mcIssPYP))))


