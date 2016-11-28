%I assume my model is gaussian distribution, so first step is to find parameters
%load data
data = csvread('classification_dataset_training.csv',1,1);
data_class0 = [];
data_class1 = [];
%pre-processing of data
for k=1:5000
    for l = 1:50
        if(data(k,l)>0)
            data(k,l)=1;
        end
    end
end
%split data
for i=1:5000
    if data(i,51)==0
        data_class0 = [data_class0; data(i,:)];
    else
        data_class1 = [data_class1; data(i,:)];
    end
end

%estimate Pij
pij0 = [];
pij1 = [];

for j=1:50
    pij_0 = sum(data_class0(:,j))/1857;
    pij_1 = sum(data_class1(:,j))/3143;
    pij0 = [pij0 pij_0];
    pij1 = [pij1 pij_1];
end

%check test case
test_data = csvread('classification_dataset_testing.csv',1,1);
%pre-process the test data
for k=1:1000
    for l = 1:50
        if(test_data(k,l)>0)
            test_data(k,l)=1;
        end
    end
end
test_result = zeros(1000,1);
%discrimininat function
for m = 1:1000
    sum0 = 0;
    sum1 = 0;
    for n=1:50
        sum0 = sum0 + (test_data(m,n)*log(pij0(1,n))) + ((1-test_data(m,n))*log(1-pij0(1,n)));
        sum1 = sum1 + (test_data(m,n)*log(pij1(1,n))) + ((1-test_data(m,n))*log(1-pij1(1,n)));
    end
    %calculate gix
    gix0 = sum0  + log((1857/5000));
    gix1 = sum1  + log((3143/5000));
    if (gix0<gix1)
        test_result(m,1) = 1;
        
    end
end
sol = csvread('classification_dataset_testing_solution.csv',1,1);
p = accuracy(sol,test_result)