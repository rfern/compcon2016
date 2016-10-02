#This tutorial is based on https://www.r-bloggers.com/using-neural-networks-for-credit-scoring-a-simple-example/ by Bart from R Bloggers

#installing and loading the neuralnet package
install.packages(c('neuralnet'))
library('neuralnet')

#Loading the creditscore dataset
dataset <- read.csv("creditscore.csv")
head(dataset)

#assigning the first 800 records as the training set and the rest as the test set
trainingset <- dataset[1:800, ]
testset <- dataset[801:2000, ]

## build the neural network (NN)
creditnet <- neuralnet(default10yr ~ LTI + age, trainingset, hidden = 4, lifesign = "minimal", linear.output = FALSE, threshold = 0.1, stepmax=100000)
plot(creditnet, rep = "best")

#testing the model on the test dataset
temp_test <- subset(testset, select = c("LTI", "age"))
creditnet.results <- compute(creditnet, temp_test)

#showing our predictor inputs within the test dataset
head(temp_test)

#showing the difference between our predicted outcome and the actual outcome within our test data set.
results <- data.frame(actual = testset$default10yr, prediction = creditnet.results$net.result)
results[100:115, ]

#This is a rounded result in order to make it easier to read.
results$prediction <- round(results$prediction)
results[100:115, ]
