#IMPORT LIBRARIES####

install.packages("dplyr")
install.packages("ggplot2")
install.packages("randomForest")
install.packages("corrplot")
install.packages("caret")
install.packages("e1071")
install.packages("splitstackshape")
install.packages("pROC")
install.packages("rfUtilities")

library(dplyr)
library(ggplot2)
library(randomForest)
library(corrplot)
library(caret)
library(splitstackshape)
library(pROC)
library(rfUtilities)

#IMPORT DATA####

#Removing pre-existing variables from workspace
rm(list = ls())

#The data used is from the University of California, Irvine Machine Learning repository
#1. Hungarian Institute of Cardiology. Budapest: Andras Janosi, M.D.
#2. University Hospital, Zurich, Switzerland: William Steinbrunn, M.D.
#3. University Hospital, Basel, Switzerland: Matthias Pfisterer, M.D.
#4. V.A. Medical Center, Long Beach: : Robert Detrano, M.D., Ph.D.
#5. Cleveland Clinic Foundation: Robert Detrano, M.D., Ph.D.

url_cleveland <- "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data"
url_hungarian <- "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.hungarian.data"
url_switzerland <- "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.switzerland.data"
url_va <- "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.va.data"

data_cleveland <- read.csv(url_cleveland, header = FALSE)
data_hungarian <- read.csv(url_hungarian, header = FALSE)
data_switzerland <- read.csv(url_switzerland, header = FALSE)
data_va <- read.csv(url_va, header = FALSE)

#TREAT DATA####

#Combine all data
model_data <- rbind(data_cleveland, data_hungarian, data_switzerland, data_va) 

#Remove unnecessary datasets
rm(url_cleveland, url_hungarian, url_switzerland, url_va, data_cleveland, data_hungarian, data_switzerland, data_va)

#Name columns
colnames(model_data) <- c("age",      # age of patient
                          "sex",      # 0 = female, 1 = male
                          "cp",       # chest pain: 1 = typical angina, 2 = atypical angina, 3 = non-anginal pain, 4 = asymptomatic
                          "trestbps", # resting blood pressure (in mm Hg)
                          "chol",     # serum cholestoral in mg/dl
                          "fbs",      # fasting blood sugar if less than 120 mg/dl, 1 = TRUE, 0 = FALSE
                          "restecg",  # resting electrocardiographic results: 1 = normal, 2 = having ST-T wave abnormality, 3 = showing probable or definite left ventricular hypertrophy
                          "thalach",  # maximum heart rate achieved
                          "exang",    # exercise induced angina, 1 = yes, 0 = no
                          "oldpeak",  # ST depression induced by exercise relative to rest
                          "slope",    # the slope of the peak exercise ST segment: 1 = upsloping, 2 = flat, 3 = downsloping 
                          "ca",       # number of major vessels (0-3) colored by fluoroscopy
                          "thal",     # thalium heart scan: 3 = normal (no cold spots), 6 = fixed defect (cold spots during rest and exercise), 7 = reversible defect (when cold spots only appear during exercise)
                          "hd"        # (PREDICTED ATTRIBUTE) - diagnosis of heart disease: 0 if less than or equal to 50% diameter narrowing, 1 if greater than 50% diameter narrowing
)

#Replace "?"s with NAs.
model_data[model_data == "?"] <- NA

#Add factors for variables that are factors and clean up the ones that have missing data
model_data[model_data$sex == 0,]$sex <- "F"
model_data[model_data$sex == 1,]$sex <- "M"
model_data$sex <- as.factor(model_data$sex)

model_data$cp <- as.factor(model_data$cp)

model_data$trestbps <- as.numeric(model_data$trestbps)

model_data$chol <- as.numeric(model_data$chol)

model_data$fbs <- as.integer(model_data$fbs)
model_data$fbs <- as.factor(model_data$fbs)

model_data$restecg <- as.integer(model_data$restecg)
model_data$restecg <- as.factor(model_data$restecg)

model_data$thalach <- as.numeric(model_data$thalach) 

model_data$exang <- as.integer(model_data$exang)
model_data$exang <- as.factor(model_data$exang)

model_data$oldpeak <- as.numeric(model_data$oldpeak)

model_data$slope <- as.integer(model_data$slope)
model_data$slope <- as.factor(model_data$slope)

model_data$ca <- as.integer(model_data$ca)
model_data$ca <- as.factor(model_data$ca) 

model_data$thal <- as.integer(model_data$thal)
model_data$thal <- as.factor(model_data$thal)

#Replace 0 and 1 with "Healthy" and "Unhealthy"
model_data$hd <- ifelse(test = model_data$hd == 0, yes = "Healthy", no = "Unhealthy")
model_data$hd <- as.factor(model_data$hd)

#Setting seed to ensure reproducible results
set.seed(42)

#Impute missing values in the training set using proximities
model_data_imputed <- rfImpute(hd ~ ., data = model_data, iter = 5)

#CORRELATION####
#Remove predicted attribute & non-numeric columns
model_data_cor <- subset(model_data, select = -c(sex, hd))

#Change factors into integer for finding correlation
model_data_cor$cp <- as.integer(model_data_cor$cp)
model_data_cor$trestbps <- as.numeric(model_data_cor$trestbps)
model_data_cor$chol <- as.numeric(model_data_cor$chol)
model_data_cor$fbs <- as.integer(model_data_cor$fbs)
model_data_cor$restecg <- as.integer(model_data_cor$restecg)
model_data_cor$thalach <- as.numeric(model_data_cor$thalach) 
model_data_cor$exang <- as.integer(model_data_cor$exang)
model_data_cor$oldpeak <- as.numeric(model_data_cor$oldpeak)
model_data_cor$slope <- as.integer(model_data_cor$slope)
model_data_cor$ca <- as.integer(model_data_cor$ca)
model_data_cor$thal <- as.integer(model_data_cor$thal)

#Create correlation matrix
model_cor <- cor(model_data_cor)
model_cor[is.na(model_cor)] <- 0

#Plot Correlogram
corrplot(model_cor, type = "upper", tl.pos = "td",
         method = "circle", tl.cex = 0.8, tl.col = 'black',
         order = "hclust")

#TRAIN - TEST SPLIT#####
split <- stratified(model_data_imputed, "hd", 0.8, bothSets = TRUE)

train_data <- split[[1]]
test_data <- split[[2]]

#BUILD MODEL####
model <- randomForest(hd ~ ., 
                      train_data, 
                      proximity = FALSE)

#PREDICT####
predicted <- predict(model, test_data)
predicted_prob <- predict(model, test_data, type = 'prob')

#EVALUATE MODEL####

#Predicted Confusion Matrix
confusionMatrix(predicted, test_data$hd)

#Plot Feature Importance
varImpPlot(model, type = 2, main = "Feature Importance")

#Write Feature Importance to CSV file
write.csv(importance(model), "Feature Importance.csv")

#Number of Nodes
hist(treesize(model),
     main = "Number of Nodes for Trees",
     xlab = "Number of Nodes",
     ylab = "Count of Trees",
     col = "blue")

#Plot Error Rate with Trees
plot(model, main = "Error Rate with Increase in Trees")

#ROC Curve
par(pty = "s")

plot.roc(train_data$hd, model$votes[,1],
         legacy.axes = TRUE, percent = TRUE, print.auc = TRUE,
         main = "Receiver Operating Characteristic (ROC) Curve", 
         xlab = "False Positive Percentage", 
         ylab = "True Positive Percentage",
         col = "blue", lwd = 3)

par(pty = "m")