function percentage= accuracy(train, test)
count = 0;
for i = 1:1000
    if (train(i) == test(i))
        count = count + 1;
    end
end

percentage = (count/1000)*100;