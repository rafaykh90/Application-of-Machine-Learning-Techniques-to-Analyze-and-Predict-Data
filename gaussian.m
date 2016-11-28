%I assume my model is gaussian distribution, so first step is to find parameters
%load data
data = csvread('classification_dataset_training.csv',1,1);
data_class0 = [];
data_class1 = [];
%split data
for i=1:5000
    if data(i,51)==0
        data_class0 = [data_class0; data(i,:)];
    else
        data_class1 = [data_class1; data(i,:)];
    end
end
%get mean vector
mean_class0 = [];
mean_class1 = [];

for i=1:50
    m0 = sum(data_class0(:,i)/1857);
    m1 = sum(data_class1(:,i)/3143);
    mean_class0 = [mean_class0 m0];
    mean_class1 = [mean_class1 m1];
end

%finding covariances
covariance_class0 = cov(data_class0(:,1:50));
covariance_class1 = cov(data_class1(:,1:50));
%calculate prior
p0 = 1857/5000;
p1 = 3143/5000;
%load test data
testData = csvread('classification_dataset_testing.csv',1,1);
testDataresult = zeros(1000,1);
for i=1:1000
    disc_class0 = mvnpdf(testData(i,:),mean_class0);
    posterior_class0 = p0 * disc_class0;
    disc_class1 = mvnpdf(testData(i,:),mean_class1);
    posterior_class1 = p1 * disc_class1;
    if (posterior_class0<posterior_class1)
        testDataresult(i,1) = 1;
    end
    
    
end
sol = csvread('classification_dataset_testing_solution.csv',1,1);
p = accuracy(sol,testDataresult)