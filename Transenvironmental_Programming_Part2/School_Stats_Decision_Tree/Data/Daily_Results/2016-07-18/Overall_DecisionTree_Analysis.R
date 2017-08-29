## OH Data

OHdata<-read.csv("OH_data.csv", head=TRUE, sep=",")
OHclusterdata<-subset(OHdata, select=c(FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional,CBM_Math,CBM_Reading))
OHmydata<-as.matrix(OHclusterdata)
OHdata$Number<-as.character(OHdata$Number)
OHdata$Number<-paste("Sch1",OHdata$Number,sep="")

install.packages("gplots")
install.packages("RColorBrewer")
library(gplots)
library(RColorBrewer)
RowColors<-as.character(OHdata$Status)
mypallete<-colorRampPalette(c("#e66101","#fdb863","#b2abd2","#4e3c99"))(n=256)
#quartz()
## heatmap.2(OHmydata, col=mypallete,scale="col",rowsep=1:34, colsep=1:8, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=OHdata$Name,margins=c(10,10),cexRow=.75,cexCol=1,keysize=1, add.expr=eval(abline(v=5.5, lwd=3, col="yellow"), abline(h=21.5, lwd=3, col="yellow")),colRow=RowColors,lhei=c(3,10))

## OH Output## OH Data

OHdata<-read.csv("OH_data.csv", head=TRUE, sep=",")
OHclusterdata<-subset(OHdata, select=c(FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional,CBM_Math,CBM_Reading))
OHmydata<-as.matrix(OHclusterdata)
OHdata$Number<-as.character(OHdata$Number)
OHdata$Number<-paste("Sch1",OHdata$Number,sep="")

install.packages("gplots")
install.packages("RColorBrewer")
library(gplots)
library(RColorBrewer)
RowColors<-as.character(OHdata$Status)
mypallete<-colorRampPalette(c("#e66101","#fdb863","#b2abd2","#4e3c99"))(n=256)
#quartz()
## heatmap.2(OHmydata, col=mypallete,scale="col",rowsep=1:34, colsep=1:8, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=OHdata$Name,margins=c(10,10),cexRow=.75,cexCol=1,keysize=1, add.expr=eval(abline(v=5.5, lwd=3, col="yellow"), abline(h=21.5, lwd=3, col="yellow")),colRow=RowColors,lhei=c(3,10))

## OH Output
pdf("Heatmap_OH.pdf", paper="letter", bg="transparent",colormodel="cmyk", pagecentre=TRUE)
heatmap.2(OHmydata, col=mypallete,scale="col",rowsep=1:34, colsep=1:8, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=OHdata$Name,margins=c(10,10),cexRow=.75,cexCol=1,keysize=2,add.expr=eval(abline(v=5.5, lwd=3, col="yellow"), abline(h=21.5, lwd=3, col="yellow")),colRow=RowColors,lhei=c(3,10))
dev.off()

## WVE Data
WVEdata<-read.csv("WVE_data.csv", head=TRUE, sep=",")
WVEclusterdata<-subset(WVEdata, select=c(FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional,CBM_Math,CBM_Reading))
WVEmydata<-as.matrix(WVEclusterdata)
WVEdata$Number<-as.character(WVEdata$Number)
WVEdata$Number<-paste("Sch2",WVEdata$Number,sep="")

library(gplots)
library(RColorBrewer)
RowColors<-as.character(WVEdata$Status)
mypallete<-colorRampPalette(c("#e66101","#fdb863","#b2abd2","#4e3c99"))(n=256)
#quartz()

## WVE Output
pdf("Heatmap_WVE.pdf", paper="letter", bg="transparent",colormodel="cmyk", pagecentre=TRUE)
heatmap.2(WVEmydata, col=mypallete,scale="col",rowsep=1:65, colsep=1:8, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=WVEdata$Name,margins=c(10,10),cexRow=.75,cexCol=1,keysize=2, add.expr=eval(abline(v=5.5, lwd=3, col="yellow"), abline(h=12.5, lwd=3, col="yellow")),colRow=RowColors,lhei=c(3,10))
dev.off()

## combined output
merged_data<-rbind(OHdata,WVEdata)
Overallclusterdata<-subset(merged_data, select=c(FSIQ,Basic_Reading_Skills,Reading_Comp,Math_Calc,Math_Reasoning,Written_Lang,Adaptive,SocioEmotional,CBM_Math,CBM_Reading))
Overallmydata<-as.matrix(Overallclusterdata)
merged_data$Number<-as.character(merged_data$Number)

library(gplots)
library(RColorBrewer)
RowColors<-as.character(merged_data$Status)
mypallete<-colorRampPalette(c("#e66101","#fdb863","#b2abd2","#4e3c99"))(n=256)
#quartz()

## Overall Output
pdf("Heatmap_Overall.pdf", paper="letter", bg="transparent",colormodel="cmyk", pagecentre=TRUE)
heatmap.2(Overallmydata, col=mypallete,scale="col",rowsep=1:65, colsep=1:8, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=merged_data$Number,margins=c(10,10),cexRow=.75,cexCol=1,keysize=2, add.expr=eval(abline(v=5.5, lwd=3, col="yellow"), abline(h=39.5, lwd=3, col="yellow")),colRow=RowColors,lhei=c(3,10))
dev.off()

install.packages("rpart")
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

## Decision Tree with Academic Testing Separated
fit1<-rpart(Outcome~Adaptive+FSIQ+CBM_Math+CBM_Reading+Basic_Reading_Skills+Reading_Comp+Math_Reasoning+Math_Calc+Written_Lang+SocioEmotional,data=na.omit(merged_data), cost=c(3,1,2,2,2,2,2,2,2,1),parms=list(prior=c(.3,.3,.4)),method="class", control=rpart.control(minsplit=1,minbucket=1,cp=-1))
pdf("RegressionTree_Separated.pdf", paper="letter", bg="transparent",colormodel="cmyk", pagecentre=TRUE)
rpart.plot(fit1,type=0,extra=100, branch.lty=1, shadow.col="gray", nn=TRUE, under=TRUE,tweak=.75,main="Decision Tree (Academic Testing Separated)")
dev.off()

## Decision Tree with Academic Testing Present
#quartz()
fit2<-rpart(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(OHdata),method="class", parms=list(prior=c(.3,.3,.4)),cost=c(3,1,2,2,1),control=rpart.control(minsplit=1, minbucket=1, cp=-1, mincriterion=.5))
pdf("RegressionTree_Testing.pdf", paper="letter", bg="transparent",colormodel="cmyk", pagecentre=TRUE)
rpart.plot(fit2,type=0,extra=100, branch.lty=1, shadow.col="gray", nn=TRUE, under=TRUE,tweak=.75,main="Decision Tree (Academic Testing Present)")
dev.off()

## Decision Tree with Academic Testing Absent
#quartz()
fit3<-rpart(Outcome~Adaptive+FSIQ+SocioEmotional,data=na.omit(merged_data), method="class", parms=list(prior=c(.3,.3,.4)),cost=c(3,1,1), control=rpart.control(minsplit=1,minbucket=1,cp=-1))
pdf("RegressionTree_NoAcademics.pdf", , paper="letter", bg="transparent",colormodel="cmyk", pagecentre=TRUE)
rpart.plot(fit3,type=0,extra=100, branch.lty=1, shadow.col="gray", nn=TRUE, under=TRUE,tweak=.75,main="Decision Tree (Academic Testing Absent)")
dev.off()

## Support Vector Machines Confirmation of rpart and Heatmaps
install.packages("e1071")
library(e1071)

sink(paste(format(Sys.time(), "%Y-%m-%d %I-%p"), "txt", sep = "."), type="output", split=FALSE)

print(Sys.time()) # Time Stamps the Output File
print("K means cross validation - 30 v 31")
svm.fit<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="polynomial",cross=30,probability=TRUE)
print(svm.fit)
print(summary(svm.fit))
print(predict(svm.fit))

print("K means cross validation - 20 v 41")
svm.fit2<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="polynomial",cross=20,probability=TRUE)
print(svm.fit2)
print(summary(svm.fit2))
print(predict(svm.fit2))

print("K means cross validation - 10 v 51")
svm.fit3<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="polynomial",cross=10,probability=TRUE)
print(svm.fit3)
print(summary(svm.fit3))
print(predict(svm.fit3))

print("K means cross validation - 5 v 56")
svm.fit4<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="polynomial",cross=5,probability=TRUE)
print(svm.fit4)
print(summary(svm.fit4))
print(predict(svm.fit4))

print("K means cross validation - 3 v 58")
svm.fit5<-svm(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(merged_data),kernel="polynomial",cross=3,probability=TRUE)
print(svm.fit5)
print(summary(svm.fit5))
print(predict(svm.fit5))

sink()