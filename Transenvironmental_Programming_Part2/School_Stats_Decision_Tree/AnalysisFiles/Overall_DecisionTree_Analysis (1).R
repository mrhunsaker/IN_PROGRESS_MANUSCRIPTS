################################################################################
################################################################################
######      Analysis Pipeline for TransEnvironmental Programming          ######
################################################################################
################################################################################

##################### Load my data folder on Google Drive ######################
setwd("C:/Users/mrhunsaker/Google Drive/School_Stats_Decision_Tree/Data/")

########################## Verify Working Directory ############################
WD<-getwd()

########## Verify required data are present in the working directory ###########
list.files(WD)

########### Install and load  all needed packages for the algorithms ###########
install.packages("gplots")
install.packages("RColorBrewer")
install.packages("rpart")
install.packages("rpart.plot")
install.packages("e1071")
library(e1071)
library(gplots)
library(RColorBrewer)
library(rpart)
library(rpart.plot)
################################################################################
################################################################################
######                    Individual School Data                         #######
################################################################################
################################################################################

## Oquirrh Hills Data
OHdata<-read.csv("OH_data.csv", head=TRUE, sep=",")
OHdata<-subset(OHdata,select=c(Name,Outcome, FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional, CBM_Math, CBM_Reading, WJIII, CBM))
OHclusterdata<-subset(OHdata, select=c(FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional, CBM_Math, CBM_Reading))
OHmydata<-as.matrix(OHclusterdata)
#OHdata$Number<-as.character(OHdata$Number)
#OHdata$Number<-paste("Sch1",OHdata$Number,sep="")

## Oquirrh Hills Output into Heatmap
#RowColors<-as.character(OHdata$Status)
mypallete<-colorRampPalette(c("#e66101","#fdb863","#b2abd2","#4e3c99"))(n=256)
pdf("Heatmap_OH.pdf",  width=8.5,height=14, bg="transparent",colormodel="cmyk", pagecentre=TRUE)
heatmap.2(OHmydata, main="OH", col=mypallete, scale="none",rowsep=1:100, colsep=1:10, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=OHdata$Name,margins=c(10,10),cexRow=.75,cexCol=1,keysize=2,lhei=c(3,10))
dev.off()

################################################################################

## West Valley Elementary Data
WVEdata<-read.csv("WVE_data.csv", head=TRUE, sep=",")
WVEdata<-subset(WVEdata,select=c(Name,Outcome, FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional, CBM_Math, CBM_Reading, WJIII, CBM))
WVEclusterdata<-subset(WVEdata, select=c(FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional, CBM_Math, CBM_Reading))
WVEmydata<-as.matrix(WVEclusterdata)
#WVEdata$Number<-as.character(WVEdata$Number)
#WVEdata$Number<-paste("Sch2",WVEdata$Number,sep="")
WVEmydata<-na.omit(WVEmydata)

## West Valley Elementary Output into Heatmap
#RowColors<-as.character(WVEdata$Status)
mypallete<-colorRampPalette(c("#e66101","#fdb863","#b2abd2","#4e3c99"))(n=256)
pdf("Heatmap_WVE.pdf", width=8.5,height=14, bg="transparent",colormodel="cmyk", pagecentre=TRUE)
heatmap.2(WVEmydata, main="WVE",col=mypallete,scale="none",rowsep=1:100, colsep=1:10, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=WVEdata$Name,margins=c(10,10),cexRow=.75,cexCol=1,keysize=2,lhei=c(3,10))
dev.off()

################################################################################

## Farnsworth Data
PTFdata<-read.csv("PTF_data.csv", head=TRUE, sep=",")
PTFdata<-subset(PTFdata,select=c(Name,Outcome, FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional, CBM_Math, CBM_Reading, WJIII, CBM))
PTFclusterdata<-subset(PTFdata, select=c(FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional, CBM_Math, CBM_Reading))
PTFmydata<-as.matrix(PTFclusterdata)
PTFmydata<-na.omit(PTFmydata)
#PTFdata$Number<-as.character(PTFdata$Number)
#PTFdata$Number<-paste("Sch3",PTFdata$Number,sep="")

## Farnsworth Output into Heatmap
#RowColors<-as.character(PTFdata$Status)
mypallete<-colorRampPalette(c("#e66101","#fdb863","#b2abd2","#4e3c99"))(n=256)
pdf("Heatmap_Farnsworth.pdf",width=8.5,height=14, bg="transparent",colormodel="cmyk", pagecentre=TRUE)
heatmap.2(PTFmydata, main="PTF",col=mypallete,scale="none",rowsep=1:100, colsep=1:10, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=PTFdata$Name,margins=c(10,10),cexRow=.75,cexCol=1,keysize=2,lhei=c(3,10))
dev.off()

################################################################################

## Upland Terrace Data
UTdata<-read.csv("UT_data.csv", head=TRUE, sep=",")
UTdata<-subset(UTdata,select=c(Name,Outcome, FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional, CBM_Math, CBM_Reading, WJIII, CBM))
UTclusterdata<-subset(UTdata, select=c(FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional, CBM_Math, CBM_Reading))
UTmydata<-as.matrix(UTclusterdata)
UTmydata<-na.omit(UTmydata)
#UTdata$Number<-as.character(UTdata$Number)
#UTdata$Number<-paste("Sch4",UTdata$Number,sep="")

## Upland Terrace Output into Heatmap
#RowColors<-as.character(UTdata$Status)
mypallete<-colorRampPalette(c("#e66101","#fdb863","#b2abd2","#4e3c99"))(n=256)
pdf("Heatmap_UT.pdf",width=8.5,height=14, bg="transparent",colormodel="cmyk", pagecentre=TRUE)
heatmap.2(UTmydata, main="UT",col=mypallete,scale="none",rowsep=1:100, colsep=1:10, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=UTdata$Name,margins=c(10,10),cexRow=.75,cexCol=1,keysize=2,lhei=c(3,10))
dev.off()

################################################################################
################################################################################
######                    Omnibus School Data                            #######
################################################################################
################################################################################

## Combine all data into a single entity
merged_data<-rbind(OHdata,WVEdata, PTFdata, UTdata)
Overallclusterdata<-subset(merged_data, select=c(FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional, CBM_Math, CBM_Reading))
Overallmydata<-as.matrix(Overallclusterdata)
Overallmydata<-na.omit(Overallmydata)
#merged_data$Number<-as.character(merged_data$Number)

## Overall Output into Heatmap
#RowColors<-as.character(merged_data$Status)
mypallete<-colorRampPalette(c("#e66101","#fdb863","#b2abd2","#4e3c99"))(n=256)
#quartz()
pdf("Heatmap_Overall.pdf", ,width=8.5,height=14, bg="transparent",colormodel="cmyk", pagecentre=TRUE)
heatmap.2(Overallmydata, main="Combined AA", col=mypallete,scale="none",rowsep=1:200, colsep=1:10, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=merged_data$Name,margins=c(10,10),cexRow=.75,cexCol=1,keysize=2,lhei=c(3,10))
dev.off()

################################################################################
################################################################################
######           Regression Tree Confirmation of Decision Tree           #######
######       All AA Students in Granite School District Combined         #######
################################################################################
################################################################################

##################### Confirmation of Decision Trees ###########################
## Academic Testing (WJ-IIINU Separated into Component Subtests)
fit1<-rpart(Outcome~Adaptive+FSIQ+CBM_Math+CBM_Reading+Basic_Reading_Skills+Reading_Comp+Math_Reasoning+Math_Calc+Written_Lang+SocioEmotional,data=na.omit(merged_data), cost=c(3,1,2,2,2,2,2,2,2,1),parms=list(prior=c(.4,.6)),method="class", control=rpart.control(minsplit=1,minbucket=1,cp=-1))
pdf("C:/Users/mrhunsaker/Google Drive/School_Stats_Decision_Tree/Data/Daily_Results/RegressionTree_Separated.pdf", paper="letter", bg="transparent",colormodel="cmyk", pagecentre=TRUE)
rpart.plot(fit1,type=0,extra=100, branch.lty=1, shadow.col="gray", nn=TRUE, under=TRUE,tweak=.75,main="Decision Tree (Academic Testing Separated)")
dev.off()

## Academic Testing (WJ-IIINU Domains Binned into a Composite)
fit2<-rpart(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(OHdata),method="class", parms=list(prior=c(.4,.6)),cost=c(3,1,2,2,1),control=rpart.control(minsplit=1, minbucket=1, cp=-1, mincriterion=.5))
pdf("C:/Users/mrhunsaker/Google Drive/School_Stats_Decision_Tree/Data/Daily_Results/RegressionTree_Testing.pdf", paper="letter", bg="transparent",colormodel="cmyk", pagecentre=TRUE)
rpart.plot(fit2,type=0,extra=100, branch.lty=1, shadow.col="gray", nn=TRUE, under=TRUE,tweak=.75,main="Decision Tree (Academic Testing Present)")
dev.off()

## Academic Testing Absent
fit3<-rpart(Outcome~Adaptive+FSIQ+SocioEmotional,data=na.omit(merged_data), method="class", parms=list(prior=c(.4,.6)),cost=c(3,1,1), control=rpart.control(minsplit=1,minbucket=1,cp=-1))
pdf("C:/Users/mrhunsaker/Google Drive/School_Stats_Decision_Tree/Data/Daily_Results/RegressionTree_NoAcademics.pdf", , paper="letter", bg="transparent",colormodel="cmyk", pagecentre=TRUE)
rpart.plot(fit3,type=0,extra=100, branch.lty=1, shadow.col="gray", nn=TRUE, under=TRUE,tweak=.75,main="Decision Tree (Academic Testing Absent)")
dev.off()

################################################################################
################################################################################
######   Support Vector Machines Modeling of Decision Tree Placements    #######
######       All AA Students in Granite School District Combined         #######
######           Final Decision Tree Placement Used as "Correct"         #######
################################################################################
################################################################################

# Set up text file for simulation results to be written to file
sink(paste(format(Sys.time(), "%Y-%m-%d %I-%p"), "txt", sep = "."), type="output", split=FALSE)

############# Iterative K means Confirmation of SVM Results ####################
print(Sys.time()) # Time Stamps the Output File

## Split the Learning and Test Set by Different values
print("K means cross validation - 30 v 31")
svm.fit<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="linear",cross=30,probability=TRUE)
print(svm.fit)
print(summary(svm.fit))
print(predict(svm.fit))

print("K means cross validation - 20 v 41")
svm.fit2<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="linear",cross=20,probability=TRUE)
print(svm.fit2)
print(summary(svm.fit2))
print(predict(svm.fit2))

print("K means cross validation - 10 v 51")
svm.fit3<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="linear",cross=10,probability=TRUE)
print(svm.fit3)
print(summary(svm.fit3))
print(predict(svm.fit3))

print("K means cross validation - 5 v 56")
svm.fit4<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="linear",cross=5,probability=TRUE)
print(svm.fit4)
print(summary(svm.fit4))
print(predict(svm.fit4))

print("K means cross validation - 3 v 58")
svm.fit5<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="linear",cross=3,probability=TRUE)
print(svm.fit5)
print(summary(svm.fit5))
print(predict(svm.fit5))
sink()

################################################################################
################################################################################
############################## End Document ####################################
################################################################################
################################################################################
