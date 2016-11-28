%nca feature selection
data = csvread('classification_dataset_training.csv',1,1);
X = data(:,1:50);
y = data(:,51);
mdl = fscnca(X,y)
figure()
plot(mdl.FeatureWeights,'ro')
grid on
xlabel('Feature index')
ylabel('Feature weight')

c = cvpartition(y,'k',100);
opts = statset('display','iter');
fun = @(XT,yT,Xt,yt)...
      (sum(~strcmp(yt,classify(Xt,XT,yT,'quadratic'))));

[fs,history] = sequentialfs(fun,data(:,40:50),y,'cv',c,'options',opts)

maxdev = chi2inv(.95,1);     
opt = statset('display','iter',...
              'TolFun',maxdev,...
              'TolTypeFun','abs');

inmodel = sequentialfs(@critfun,X,y,...
                       'cv','none',...
                       'nullmodel',true,...
                       'options',opt,...
                       'direction','forward');
