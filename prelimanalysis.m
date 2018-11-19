%Project Preliminary Analysis
%Group 6 - Pearl Ayem, Navneet Brar, Thomas Sanford, Nicholas Wu
clear
close

%%
% 
% * Air tmperature datasets were obtained from 'climate.weather.gc.ca'
% * Both datasets contained the maximum, miinimum, and average temperature
%   per month over the course of time in the dataset
% * Each of these mean temperatures were compiled and calculated per month
% * Data loaded using xlsread (excel file)
% * nanmean was used to obtain the average as there were some missing data
%   in the dataset
% 
% * The data used for Quttinirpaaq National Park was obtained in Eureka
%   (Southwest of the park)
% * The data used for Auyuttuq National Park was obtained in Cape Hooper
%   (North of the park)
% * We will be anayzing the temperature data to see the impact this will
%   have on permafrost thickness and their rate of change (The influcence
%   of air surface temperature on permafrost thickness)
%
%%
% Loading the Monthly Temperature Data

% Quttinirpaaq/Eureka Data
Qdata = xlsread('Eureka.csv');
Qmonth = Qdata(:,2);
Qmintemp = Qdata(:,5);
Qmaxtemp = Qdata(:,3);
Qmeantemp = Qdata(:,7);

% Auyuttuq/Cape Hooper Data
Adata = xlsread('CAPEHOOPER.csv');
Amonth = Adata(:,2);
Amintemp = Adata(:,5);
Amaxtemp = Adata(:,3);
Ameantemp = Adata(:,7);

%% 
% Quttinirpaaq Plot
for month = 1:12
    meanmintemp(month) = nanmean(Qmintemp(Qmonth == month));
    meanmaxtemp(month)= nanmean(Qmaxtemp(Qmonth == month));
    meantemp(month)= nanmean(Qmeantemp(Qmonth == month));
end

months = (1:12);
figure(1);
hold on
plot(months,meanmintemp,'.');plot(months,meanmaxtemp,'+');plot(months,meantemp,'--');
legend('Minimum Temperature','Maximum Temperature','Average Temperature','Location','se');
title('Mean Monthly Temperature from 1947-2016 at Eureka(Quttinirpaaq)');xlabel('Month');ylabel('Temperature (degrees Celcius)');

% table
t_month = transpose(months);
t_max = transpose(meanmaxtemp);
t_min = transpose(meanmintemp);
t_temp = transpose(meantemp);
T = table(t_month, t_min, t_temp, t_max)

%%
% Auyuttuq Plot
for month = 1:12
    meanmintemp(month) = nanmean(Amintemp(Amonth == month));
    meanmaxtemp(month)= nanmean(Amaxtemp(Amonth == month));
    meantemp(month)= nanmean(Ameantemp(Amonth == month));
end

months = (1:12);
figure(2);
hold on
plot(months,meanmintemp,'.');plot(months,meanmaxtemp,'+');plot(months,meantemp,'--');
legend('Minimum Temperature','Maximum Temperature','Average Temperature','Location','se');
title('Mean Monthly Temperature from 1957-2007 at Cape Hooper(Auyuittuq)');xlabel('Month');ylabel('Temperature (degrees Celcius)');

% table
t_month = transpose(months);
t_max = transpose(meanmaxtemp);
t_min = transpose(meanmintemp);
t_temp = transpose(meantemp);
T = table(t_month, t_min, t_temp, t_max)