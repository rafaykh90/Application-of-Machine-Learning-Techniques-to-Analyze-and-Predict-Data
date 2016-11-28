%logistic regression

%loading datasets
data = csvread('classification_dataset_training.csv',1,1);

%predictors
X = data(:,1:50);

%responses
Y = data(:,51);

%find-coefficients
b = glmfit(X,Y,'binomial','link','logit');

%load test dataset
testData = csvread('classification_dataset_testing.csv',1,1);

%split testData into predictors and responses
X_test = testData(:,1:50);

%apply logistic function on testData predictors
yfit = glmval(b,X_test,'logit');

%give classes
for i=1:1000
    if yfit(i,1)>=0.5
        yfit(i,1) = 1;
    else
        yfit(i,1) = 0;
    end
end

%check accuracy
solution = csvread('classification_dataset_testing_solution.csv',1,1);
p = accuracy(solution,yfit);