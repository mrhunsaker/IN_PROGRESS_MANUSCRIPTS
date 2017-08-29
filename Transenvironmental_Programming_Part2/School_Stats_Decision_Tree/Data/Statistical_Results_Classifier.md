# 2016-07-10 12:22:46 MDT

## Data Analysis and Development of a Support Vector Machine to Assist in Special Education Student Mainstreaming Allocation

### Methods
 
#### Data Preprocessing
Data were collected from each student's most recent special education re-evaluation. The following data were extracted: Adaptive Function, Full Scale IQ (FSIQ), SocioEmotional data, WJ-IIINU data for academics (Basic Reading Skills, Reading Comprehension, Math Reasoning, Math Calculation, Written L:anguage) and Curriculum Based Measures (CBM-Math and ELA/Reading). 

These values were converted into categorical variables based on the Granite School District SLD Rubric. 

|Measure       |          Value Definitions         |Value Range|
|--------------|:----------------------------------:|:-----:|
|Adaptive      |SS 0-59 = 0, SS <70 = 1             |0,1    |
|FSIQ          |SS 0-70 = 0, 70-99 = 1, >100 = 2    |0,1,2  |
|SocioEmotional|T<70 = 1, T > 70 = 0                |0,1    |
|WJ III NU     |SS <70 = 0, 70-85 =1,85-99=2, >100=3|0,1,2,3|
|CBM           | < 35% correct = 0, > 35% correct = 1       |0,1    |


#### Mainstream Decision Tree

Using the Mainstream Decision Tree and raw data (raw values rather than categorical values), student allocation was determined for each student manually and annotated in a spreadsheet with the rest of the data from the above step. These data were later used to evaluate the efficacy of the numerical analyses.

#### Regression Tree Analysis
To determine whether or not the Mainstreaming Decision Tree could be supported by data, Recursive Partitioning and Regression Trees (rpart) analyses were performed. These methods split the data into 2 groups initially based on the type of data that creates the most statistically reliable split among groups. This process is repeated across all resulting groups until the algorithm can find no reliable way to split the groups further.

This analysis was prrformed with the *rpart* library in the R statistical computing package. This analysis was performed 3 times, first with all data independently (all scales collected for the WJ-IIINU and CBM separated), once with the academic data collapsed (mean scores across WJIII-NU as well as mean scores across CBM), and once with academic information withheld.

Once the *rpart* code was executed, the resulting tree-based visualizations were saved to file and remained unaltered. A deliberate choice was made to not cut the trees or post process them for the sake of clarity. 

The *rpart* code for the condition of no academic information was:
>fit3<-rpart(Outcome~Adaptive+FSIQ+SocioEmotional,data=na.omit(merged_data), method="class",parms=list(prior=c(.3,.3,.4)),cost=c(3,1,1), control=rpart.control(minsplit=1,minbucket=1,cp=-1))
>
>rpart.plot(fit3,type=0,extra=100,box.palette="auto", branch.lty=1, shadow.col="gray", nn=TRUE, under=TRUE,tweak=.75,main="Decision Tree (Academic Testing Absent)")

The *rpart* code for the condition of academic information present and collapsed into WJ-IIINU and CBM means :
>fit2<-rpart(Outcome~Adaptive+FSIQ+WJIII+CBM+SocioEmotional,data=na.omit(OHdata), method="class",parms=list(prior=c(.3,.3,.4)),cost=c(3,1,2,2,1),control=rpart.control(minsplit=1, minbucket=1,cp=-1, mincriterion=.5))
>
>rpart.plot(fit2,type=0,extra=100,box.palette="auto", branch.lty=1, shadow.col="gray", nn=TRUE, under=TRUE,tweak=.75,main="Decision Tree (Academic Testing Present)")

The *rpart* code for the condition of academic information present and included separately:
> fit1<-rpart(Outcome~Adaptive+FSIQ+CBM_Math+CBM_Reading+Basic_Reading_Skills+Reading_Comp+ Math_Reasoning+Math_Calc+Written_Lang+SocioEmotional,data=na.omit(merged_data), cost=c(3,1,2,2,2,2,2,2,2,1),parms=list(prior=c(.3,.3,.4)),method="class", control=rpart.control(minsplit=1,minbucket=1,cp=-1))
>
> rpart.plot(fit1,type=0,extra=100,box.palette="auto", branch.lty=1, shadow.col="gray", nn=TRUE, under=TRUE,tweak=.75,main="Decision Tree (Academic Testing Separated)")

#### Clustering Approach

This analysis was performed with the *gplots* library in the R statistical computing package. This analysis was performed 3 times, first once with each of the 2 schools independently and again with the 2 schools' data combined. The results of these analyses were heatmaps that showed similarities among students as well as similarities among factors.

Once the *heatmap.2* code was executed, the resulting hierarchical clustering-based visualizations were saved to file and remained unaltered. A deliberate choice was made to not cut the heatmaps or post process them for the sake of clarity. 

The *heatmap.2* code for the first school :
>heatmap.2(OHmydata,col=mypallete,scale="col",rowsep=1:34,colsep=1:8, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=OHdata$Name,margins=c(10,10),cexRow=.75, cexCol=1,keysize=2,add.expr=eval(abline(v=5.5,lwd=3,col="yellow"), abline(h=21.5,lwd=3,col="yellow")),colRow=RowColors,lhei=c(3,10))

The *heatmap.2* code for the second school :
>heatmap.2(WVEmydata,col=mypallete,scale="col",rowsep=1:65,colsep=1:8, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=WVEdata$Name,margins=c(10,10),cexRow=.75, cexCol=1,keysize=2,add.expr=eval(abline(v=5.5,lwd=3,col="yellow"),abline(h=12.5,lwd=3, col="yellow")),colRow=RowColors,lhei=c(3,10))

The *heatmap.2* code for a combination of the two schools:
>heatmap.2(Overallmydata,col=mypallete,scale="col",rowsep=1:65,colsep=1:8, sepcol="white",sepwidth=c(.015,.025),trace="none",labRow=merged_data$Number,margins=c(10,10), cexRow=.75,cexCol=1,keysize=2,add.expr=eval(abline(v=5.5,lwd=3,col="yellow"),abline(h=39.5,lwd=3, col="yellow")),colRow=RowColors,lhei=c(3,10))

#### SVM / Machine Learning Approach

In order to quantify the correctness of the clustering approaches, a machine learning classification algorithm was employed. This method, called Support Vector Machines, is designed to identify an optimal separation among groups or classes of data.

The algorithm was trained by using different numbers of data points (students) to train the algorithm and testing it with the rest of the datasets. This analysis confirms the correctness of the heatmaps as well as trains a computer to discriminate among the 3 classes of students, allowing for unknown students' data to be input and a classification be elucidated.

K means cross validation was used as a training and evaluation metric for the Support Vector Machine. THis means K students' data were used to test the system and the remaining data were used to train the classifier. K means cross validation with K=30, 20, 10, 5, and 3 were used to evaluate the efficacy of the algorithm.

### Results
#### Cluster Analyses and Heatmaps
##### Partition Maps (Decision Trees)

As can be seen from the partition tree below, when academic testing is not available, the *rpart* algorithm used Adaptive Function as the first split point, supporting the decision to use Adpative Function as the first split in the Mainstreaming Decision Tree. Socioemotional data then seems to be important for determining student placement, followed by FSIQ data.

![No Academic Testing](https://drive.google.com/a/granitesd.org/file/d/0B_VVMEN2K1xCVWY1aXBPS29MNTg/view?usp=sharing=800px)

When academic information is included as means across the WJ-IIINU and CBM, CBM (indicating classroom performance) is the primary determining factor for success, followed by WJIII-NU and socioemotional function. FSIQ appears to only become involved when very low WJ-IIINU scores are present and there are some socioemotional difficulties.

![With Academic Testing](https://drive.google.com/a/granitesd.org/file/d/0B_VVMEN2K1xCYVIxUWxXNUNGaXM/view?usp=sharing=800px)

When academic information is included and all academic measures provided separately, a much more complicated picture appears. It appears that CBM math measures are most reliable for the initial split, followed by SocioEmotional data. Reading comprehension appears to be the most reliable indicator separating final general education placement relative to other factors. In separating inclusion from mainstreaming endpoints, it appears Basic Reading Skills are paramount. These data suggest that mathematics knowledge is critical, and after that Reading Comprehension. In the presence of poor CBM math scores, them math Reasoning becomes critical and  

![With Academic Testing Separated](https://drive.google.com/open?id=0B_VVMEN2K1xCM1FMNDZaU05adGs=800px)

##### Cluster Analyses and Heatmaps

The data show that there was a 90%+ correct classification of students designated for mainstreaming or inclusion. Interestingly, one can also see the Cognitive factors were separated from the academic factors, and CBM measurements were included as cognitive, rather than academic factors. 

These data all support the use of the Mainstreaming Decision Tree by reaching similar conclusions as to student allocation or classification as the Mainstreaming Decision Tree using a converging method, 

![School1](https://drive.google.com/open?id=0B_VVMEN2K1xCX0k5TmVpSVk5Q1E=800px)
![School2](https://drive.google.com/open?id=0B_VVMEN2K1xCWVNneVNJU1RVRms=800px)
![Combined](https://drive.google.com/open?id=0B_VVMEN2K1xCMlhMWnZHazBvOWc=800px)

#### Machine Learning Algorithm and Classification

Note in the Table that the classifier mis-classified 1 GenEd student as Mainstreaming and 0 as inclusion. 3 inclusion students were mis-classified as needing mainstreaming. 3 Mainstreaming students were mis-classified as GenEd and 2 were mis-classified as requiring inclusion. These data are important because it means the algorithm is optimistic, erring on the side of moving the student to a less restrictive environment rather than favoring more restrictive environments. Also, these data by and large support the classroom decisions undertaken this past year, which was to favor moving students into less restrictive environments when they were approaching "ready", rather than waiting. 

| || GenEd | Inclusion | Mainstream | % Correct |
|---| :---: | :---: | :---: |
  |GenEd | 12 | 0  | 1 | 93% |
  |Inclusion | 0 | 20 | 3 | 87% |
  |Mainstream | 3 | 2 | 20 | 80% |
  
####Prediction for each student based on classifier

[Table:: Results of Classifier by Student]
| Student | Classifier Output | Decision Tree Placement | Correct (Y/N) | Notes|
|---| :---: | :---: | :---: | ---|
|1| Inclusion| Inclusion | Y | 
|2| Mainstream | Mainstream | Y | 
|3| Mainstream | Mainstream | Y | 
|4| Inclusion | Inclusion | Y | 
|5| Inclusion | Inclusion  | Y | 
|6| Inclusion | Inclusion | Y | 
|7| GenEd | GenEd | Y | 
|8| Mainstream |Mainstream |Y | 
|9| Mainstream| Mainstream| Y| | 
|10| Mainstream |Mainstream |Y | 
|11| Mainstream| Mainstream |Y |
|12| Mainstream |Mainstream |Y |
|13| Mainstream | Inclusion | N | Optimistic Classification|
|14| Inclusion |Inclusion |N  |
|15| Mainstream |Mainstream |Y  |
|16| Inclusion |Inclusion |Y | 
|17| Mainstream |Mainstream |Y | 
|18| GenEd | GenEd| Y| 
|19| Mainstream | GenEd | N | Student was successfully placed in GenEd
|20| GenEd | GenEd|Y  | 
|21| Inclusion | Inclusion |Y | 
|22|GenEd | GenEd|Y | 
|23| GenEd | GenEd|Y | 
|24| GenEd | GenEd|Y | 
|25| Inclusion | Inclusion |Y |
|26| Inclusion| Inclusion|Y  |
|27| GenEd | GenEd|Y | 
|28| Inclusion | Inclusion |Y |
|29| Mainstream | Mainstream |Y |
|30| Inclusion | Inclusion |Y |
|31| Inclusion | Mainstream | N |
|32| Inclusion | Mainstream | N |
|33| Inclusion | Inclusion | Y |
|34| Mainstream |  Mainstream|Y |
|35| Inclusion | Inclusion |Y |
|36|GenEd| GenEd|Y | | 
|37|  Inclusion | Inclusion|Y | 
|38| Mainstream| Mainstream|Y | 
|39| GenEd |GenEd |Y | 
|40| Inclusion| Inclusion|Y |
|41| Inclusion | Inclusion |Y | 
|42| Mainstream | Mainstream|Y | 
|43| Mainstream | Mainstream|Y | 
|44| Mainstream |Mainstream |Y | 
|45| Mainstream| Inclusion |N | 
|46| Mainstream| Mainstream|Y | 
|47| GenEd | GenEd|Y | 
|48| GenEd| GenEd|Y | 
|49| Inclusion| Inclusion |Y | 
|50| Inclusion | Inclusion| Y|
|51| Mainstream | Mainstream|Y |
|52| Mainstream | GenEd | N |Student was successfully placed in GenEd |
|53| Inclusion |Inclusion |Y |
|54| Inclusion | Mainstream |N | 
|55| Mainstream | Mainstream |Y |
|56| GenEd | GenEd|Y |
|57| Mainstream  | Mainstream|Y |
|58| GenEd | GenEd|Y | 
|59| Mainstream | Mainstream|Y |
|60| Inclusion | Inclusion|Y |
|61| Mainstream | Mainstream | Y |


