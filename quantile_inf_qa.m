% Quality Assurance testing for quantile_inf function
clear;
clc;
%addpath(['Z:\Research\Quantile Inference\PublicCode']);

%%
tic;
nreplic=500;
rejs=zeros(nreplic,1);
for i=1:nreplic
    rejs(i) = quantile_inf(randn(40,1),[],0.5,0,0,0.05);
    if round(i/100)==i/100,  disp(sprintf('iter #%d',i)); end;
end
mean(rejs) %should be <=.05
toc;

%%
tic;
nreplic=500; 
pvals=zeros(nreplic,1);
for i=1:nreplic
    data = rand(21,1);             
    pvals(i) = quantile_inf(data(:,1),[],1/10,0,0.1,[]); 
    if round(i/50)==i/50,       disp(sprintf('iter #%d',i));end;
end
figure;
%hist(pvals); %should be ~uniform(0,1)
plot(1:nreplic,sort(pvals),1:nreplic,[1:nreplic]/nreplic);
toc;

%%
nreplic=400;
alldata=trnd(1,11,nreplic*2);
for alt=0:2 %.5:2.5
 tic;
 rejs2=zeros(nreplic,1);
 for i=1:nreplic
     if round(i/50)==i/50,       disp(sprintf('iter #%d',i));end;
     data = [alldata(:,2*i-1),alldata(:,2*i)-alt];    % *2*((rand(1)<.5)-.5)
     rejs2(i) = quantile_inf(data(:,1),data(:,2),0.5,0,0,.05); 
 end
 mean(rejs2) 
 toc;
end

%%
nreplic=500;
alldata=trnd(1,11,nreplic);
for alt=[0,.9,1.8]
 tic;
 rejs3=zeros(nreplic,1);
 for i=1:nreplic
     if round(i/50)==i/50,       disp(sprintf('iter #%d',i));end;
     rejs3(i) = quantile_inf(alldata(:,i),[],.5,0,0-alt,.05);
 end
 mean(rejs3) 
 toc;
end

%%
tmp=zeros(nreplic,1);
for i=1:nreplic;
   data = rand(21,1);
   tmp(i) = quantile_inf(data(:,1),[],1/10,0,0.1,0.05);
end
mean(tmp)

%EOF