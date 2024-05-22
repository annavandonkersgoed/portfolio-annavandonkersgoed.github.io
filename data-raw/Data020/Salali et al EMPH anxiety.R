## R CODE for Salali, Uysal, Bevan 2021 EMPH anxiety during a pandemic
# contact guldeniz.salali@ucl.ac.uk

rm(list=ls())

#####################################################################
# multiple regressions

data=  read.csv(here::here("data-raw", "Data030", "UK_complete_responses.csv"), header=T)
head(data)
colnames(data)
data_UK= data

levels(data$edu)
data$edu= relevel(data$edu, "below_ug")

GAD_UK_m1= lm(GAD.mean ~ IUS.mean + FOC.mean + MAAS.mean + RiskPerception +
                   + edu + age + sex + FinancialSatisfaction, data=data)

summary(GAD_UK_m1)

# Covid-related anxiety model UK (CRA.mean)

CRA_UK_full= lm(CRA.mean ~ IUS.mean + FOC.mean + MAAS.mean +
                 RiskPerception + edu + age + sex +
                 FinancialSatisfaction, data= data)
summary(CRA_UK_full)
lm.beta(CRA_UK_full) # standardized coefficients

# Risk avoidance behaviour RAB UK

RAB_UK= lm(RAB.mean ~ IUS.mean + MAAS.mean + CRA.mean + RiskPerception +FinancialSatisfaction + age +
             sex + edu, data=data)

# just anxiety

RAB_UK_1= lm(RAB.mean ~  CRA.mean, data=data)

summary(RAB_UK)
summary(RAB_UK_1)
library(lm.beta)
lm.beta(RAB_UK)


############################################
# TR

data=  read.csv("TR_complete_responses.csv", header=T)
head(data)
colnames(data)
summary(data$edu)

summary(data$age) # someone with 103
data_TR= data[-which(data$age>=90),] # omit 103 yo

# Covid-related anxiety model TR (CRA.mean)

CRA_TR_full= lm(CRA.mean ~ IUS.mean + FOC.mean + MAAS.mean +
                 RiskPerception +
                  edu + age + sex + FinancialSatisfaction, data= data)

summary(CRA_TR_full)
lm.beta(CRA_TR_full)

# Risk avoidance behaviour RAB TR

RAB_TR= lm(RAB.mean ~ IUS.mean + MAAS.mean + CRA.mean + RiskPerception +FinancialSatisfaction + age +
             sex + edu, data=data)
RAB_TR_1= lm(RAB.mean ~  CRA.mean, data=data)
summary(RAB_TR)
summary(RAB_TR_1)
lm.beta(RAB_TR)

############PLOTS FOR ANXIETY ###

#library(ggplot2)

#choose which data
#data= data_UK1
#data= data_TR1

#colnames(data_UK1)
#colnames(data_TR1)
#dataUKmerge= data_UK1[,c("RAB.mean","GAD.mean", "GAD.Total.Adj", "CRA.mean","FOC.mean",
#                         "IUS.mean", "MAAS.mean", "RiskPerception",
#                         "FinancialSatisfaction", "age", "sex", "edu")]
#dataTRmerge= data_TR1[,c("RAB.mean","GAD.mean", "GAD.Total.Adj", "CRA.mean","FOC.mean",
#                         "IUS.mean", "MAAS.mean", "RiskPerception",
#                         "FinancialSatisfaction", "age", "sex", "edu")]
#dataTRmerge$Country=rep("Turkey", length(dataTRmerge[,1]))
#dataUKmerge$Country=rep("UK", length(dataUKmerge[,1]))

#datamerge= rbind(dataTRmerge, dataUKmerge)

#write.csv(datamerge, "combineddata.csv")

## READ FROM HERE: TR UK combined regression analysis

datamerge= read.csv("combineddata.csv")
head(datamerge)
summary(datamerge$Country)
library(ggplot2)

s= 8
p=1
t=0.3

gad.cra=
  ggplot(datamerge, aes(x=GAD.mean, y=CRA.mean, color=Country)) +
 # geom_point(alpha = 0.3) + # with alpha blending to make points transparent
  geom_jitter(size=t) +
  geom_point(size=t) +
  geom_smooth(method=lm, se=T, size=p) + # or method=loess
  ylab("Pandemic anxiety") +
  xlab("Generalized anxiety") +
  theme(axis.title=element_text(size=s)) +
  theme(legend.position = "none")



gad.ius=
ggplot(datamerge, aes(x=IUS.mean, y=GAD.Total.Adj, color=Country)) +
 # geom_point(alpha = 0.3) +
  geom_jitter(size=t) +
  geom_point(size=t) +
  geom_smooth(method=lm, se=T, size=p) + # or method=loess
  ylab("GAD-7") +
  xlab("Intolerance of uncertainty")  +
  theme(axis.title=element_text(size=s)) +
  theme(legend.position = "none")

cra.ius=
  ggplot(datamerge, aes(x=IUS.mean, y=CRA.mean, color=Country)) +
  #geom_point(alpha = 0.3) +
  geom_jitter(size=t) +
  geom_point(size=t) +
  geom_smooth(method=lm, se=T, size=p) + # or method=loess
  ylab("Pandemic anxiety") +
  xlab("Intolerance of uncertainty")  +
  theme(axis.title=element_text(size=s)) +
  theme(legend.position = "none")
  #ylim(1.5,3.5)

cra.maas=
  ggplot(datamerge, aes(x=MAAS.mean, y=CRA.mean, color=Country)) +
  #geom_point(alpha = 0.3) +
  geom_jitter(size=t) +
  geom_point(size=t) +
  geom_smooth(method=lm, se=T, size=p) + # or method=loess  ylab("Pandemic anxiety") +
  ylab("Pandemic anxiety") +
  xlab("Mindfulness")  +
  theme(axis.title=element_text(size=s)) +
  theme(legend.position = "none")

cra.foc=
  ggplot(datamerge, aes(x=FOC.mean, y=CRA.mean, color=Country)) +
  #geom_point(alpha = 0.3) +
  geom_jitter(size=t) +
  geom_point(size=t) +
  geom_smooth(method=lm, se=T, size=p) + # or method=loess
  ylab("Pandemic anxiety") +
  xlab("Future orientation")  +
  theme(axis.title=element_text(size=s)) +
  theme(legend.position = "none")

cra.risk=
  ggplot(datamerge, aes(x=RiskPerception, y=CRA.mean, color=Country)) +
  #geom_point(alpha = 0.3) +
  geom_jitter(size=t) +
  geom_point(size=t) +
  geom_smooth(method=lm, se=T, size=p) + # or method=loess
  ylab("Pandemic anxiety") +
  xlab("Risk Perception")  +
  theme(axis.title=element_text(size=s)) +
  theme(legend.position = "none")

rab.cra=
  ggplot(datamerge, aes(x=CRA.mean, y=RAB.mean, color=Country)) +
  #geom_point(alpha = 0.3) +
  geom_jitter(size=t) +
  geom_point(size=t) +
  geom_smooth(method=lm, se=T, size=p) + # or method=loess  ylab("Risk avoidance behaviour") +
  ylab("Risk avoidance behaviour") +
  xlab("Pandemic anxiety")  +
  theme(axis.title=element_text(size=s)) +
  theme(legend.position = "none")

rab.gad=
  ggplot(datamerge, aes(x=GAD.mean, y=RAB.mean, color=Country)) +
 # geom_point(alpha = 0.3) +
  geom_jitter(size=t) +
  geom_point(size=t) +
  geom_smooth(method=lm, se=T, size=p) + # or method=loess  ylab("Risk avoidance behaviour") +
  ylab("Risk avoidance behaviour") +
  xlab("Generalized anxiety")  +
  theme(axis.title=element_text(size=s)) +
  theme(legend.position = "none")

library(ggpubr)
ggarrange(gad.cra, cra.foc,
          cra.ius, cra.maas,
          cra.risk, rab.cra,
          labels = c("A", "B",
                     "C", "D",
                     "E", "F"),
          ncol = 2, nrow = 3,
          font.label = list(size = 10, color = "black", face = "bold", family = NULL))

## countries separate

gad.cfc.tr=
ggplot(data, aes(x=FOC.mean, y=GAD.Total.Adj)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("GAD-7") +
  xlab("Consideration of future consequences")  +
  theme(axis.title=element_text(size=s))

gad.maas.tr=
ggplot(data, aes(x=MAAS.mean, y=GAD.Total.Adj)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("GAD-7") +
  xlab("Mindfulness")  +
  theme(axis.title=element_text(size=s))

gad.age.tr=
ggplot(data, aes(x=age, y=GAD.Total.Adj)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("GAD-7") +
  xlab("Age")  +
  theme(axis.title=element_text(size=s))

cra.gad.tr=
ggplot(data, aes(x=GAD.Total.Adj, y=CRA.Total.Adj)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Pandemic anxiety") +
  xlab("GAD-7")  +
  theme(axis.title=element_text(size=s))

cra.ius.tr=
ggplot(data, aes(x=IUS.mean, y=CRA.Total.Adj)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Pandemic anxiety") +
  xlab("Intolerance of uncertainty")  +
  theme(axis.title=element_text(size=s))

cra.maas.tr=
ggplot(data, aes(x= MAAS.mean, y=CRA.Total.Adj)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Pandemic anxiety") +
  xlab("Mindfulness")  +
  theme(axis.title=element_text(size=s))

cra.trust.tr=
ggplot(data, aes(x= Norm, y=CRA.Total.Adj)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Pandemic anxiety") +
  xlab("Trust in others")  +
  theme(axis.title=element_text(size=s))

cra.risk.tr=
ggplot(data, aes(x= RiskPerception, y=CRA.Total.Adj)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Pandemic anxiety") +
  xlab("Risk perception")  +
  theme(axis.title=element_text(size=s))

cra.age.tr=
ggplot(data, aes(x= age, y=CRA.mean)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Pandemic anxiety") +
  xlab("Age")  +
  theme(axis.title=element_text(size=s))

cra.news.tr=
ggplot(data, aes(x= news_opposite, y=CRA.Total.Adj)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Pandemic anxiety") +
  xlab("Frequency of following news")  +
  theme(axis.title=element_text(size=s))

rab.cra.tr=
ggplot(data, aes(x= CRA.Total.Adj, y=RAB.mean)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Risk avoidance behaviour") +
  xlab("Pandemic anxiety")  +
  theme(axis.title=element_text(size=s))

rab.maas.tr=
ggplot(data, aes(x= MAAS.mean, y=RAB.mean)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Risk avoidance behaviour") +
  xlab("Mindfulness")  +
  theme(axis.title=element_text(size=s))

rab.age.tr=
ggplot(data, aes(x= age, y=RAB.mean)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Risk avoidance behaviour") +
  xlab("Age")  +
  theme(axis.title=element_text(size=s))

rab.trust.uk=
ggplot(data, aes(x= Norm, y=RAB.mean)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Risk avoidance behaviour") +
  xlab("Trust in others")  +
  theme(axis.title=element_text(size=s))

rab.risk.tr=
ggplot(data, aes(x= RiskPerception, y=RAB.mean)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Risk avoidance behaviour") +
  xlab("Risk Perception")  +
  theme(axis.title=element_text(size=s))

rab.ius.tr=
ggplot(data, aes(x= IUS.mean, y=RAB.mean)) +
  geom_point(shape=1) +
  geom_smooth(method=lm) +
  ylab("Risk avoidance behaviour") +
  xlab("Intolerance of uncertainty")  +
  theme(axis.title=element_text(size=s))

### plot together

library(ggpubr)
ggarrange(gad.ius.uk, gad.ius.tr,
          gad.maas.uk, gad.maas.tr,
          cra.gad.uk, cra.gad.tr,
          labels = c("A", "B",
                     "C", "D",
                     "E", "F"),
          ncol = 2, nrow = 3,
          font.label = list(size = 10, color = "black", face = "bold", family = NULL))

ggarrange(cra.ius.uk, cra.ius.tr,
          cra.risk.uk, cra.risk.tr,
          rab.cra.uk, rab.cra.tr,
          labels = c("A", "B",
                     "C", "D",
                     "E", "F"),
          ncol = 2, nrow = 3,
          font.label = list(size = 10, color = "black", face = "bold", family = NULL))

ggarrange(gad.age.uk, gad.age.tr,
          cra.age.uk, cra.age.tr,
          rab.age.uk, rab.age.tr,
          labels = c("A", "B",
                     "C", "D",
                     "E", "F"),
          ncol = 2, nrow = 3,
          font.label = list(size = 10, color = "black", face = "bold", family = NULL))

ggarrange(rab.trust.uk, rab.trust.tr,
          labels = c("A", "B"),
          ncol=2, nrow=1,
          font.label = list(size = 10, color = "black", face = "bold", family = NULL))
# summary stats

tapply(data_TR$CRA.mean, data_TR$new_back_normal, mean)
tapply(data_UK$CRA.mean, data_UK$sex, mean)
tapply(data_UK$CRA.mean, data_UK$edu, mean)
tapply(data_TR$CRA.mean, data_TR$edu, mean)

tapply(data_UK$GAD.mean, data_UK$sex, mean)

tapply(data_UK$RAB.mean, data_UK$edu, mean)
tapply(data_TR$RAB.mean, data_TR$edu, mean)

tapply(data_UK$RAB.mean, data_UK$sex, mean)
tapply(data_TR$RAB.mean, data_TR$sex, mean)

tapply(data_TR$RAB.mean, data_TR$new_back_normal, mean)
tapply(data_UK$RAB.mean, data_UK$new_back_normal, mean)


