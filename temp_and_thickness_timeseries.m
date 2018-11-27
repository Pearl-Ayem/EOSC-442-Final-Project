clear
close all
clc

AtempData= xlsread('AuyuttuqCapeHooperAirTemp.csv');
Amean_temps= AtempData(:,7);
Atemp_year= AtempData(:,1);

QtempData= xlsread('QuttinirpaaqEurekaAirTemp.csv');
Qmean_temps= AtempData(:,7);
Qtemp_year= AtempData(:,1);

auyuittuq_data = xlsread('Auyuittuq.xlsx');
Ayears_data = auyuittuq_data(:,3);
Agrid_number = auyuittuq_data(:,4);
Afirst_thickness = auyuittuq_data(:,5);
Asecond_thickness = auyuittuq_data(:,6);
Amatrix1=[Afirst_thickness(:),Asecond_thickness(:)];
AmatrixT= transpose(Amatrix1);
AmatrixT(AmatrixT == -99999) = NaN;
Aaverage_thickness = nanmean(AmatrixT);


quttinirpaaq_data = xlsread('Quttinirpaaq.xlsx');
Qyears_data = quttinirpaaq_data(:,3);
Qgrid_number = quttinirpaaq_data(:,4);
Qfirst_thickness = quttinirpaaq_data(:,5);
Qsecond_thickness = quttinirpaaq_data(:,6);
Qmatrix1=[Qfirst_thickness(:),Qsecond_thickness(:)];
QmatrixT= transpose(Qmatrix1);
QmatrixT(QmatrixT == -99999) = NaN;
Qaverage_thickness = nanmean(QmatrixT);


Ayearly_avg=[];
Arow = 1;
for year = 2009:2017
        Acondition = Ayears_data == year;
        Ayavg= nanmean(Aaverage_thickness(Acondition));
        Ayearly_avg(Arow)= Ayavg;
        Amax_per_year(Arow) = max(Aaverage_thickness(Acondition));
        Amin_per_year(Arow)= min(Aaverage_thickness(Acondition));
        Astd_per_year(Arow)= nanstd(Aaverage_thickness(Acondition));
        Arow = Arow+1;
end



Qyearly_avg=[];
Qrow = 1;
for year = 2009:2017
        Qcondition = Qyears_data == year;
        Qyavg= nanmean(Qaverage_thickness(Qcondition));
        Qyearly_avg(Qrow)= Qyavg;
        Qmax_per_year(Qrow) = max(Qaverage_thickness(Qcondition));
        Qmin_per_year(Qrow)= min(Qaverage_thickness(Qcondition));
        Qstd_per_year(Qrow)= nanstd(Qaverage_thickness(Qcondition));
        Qrow = Qrow+1;
end


Aaverage_temp_yearly=[];
Qaverage_temp_yearly=[];
i = 1;
for year = 2009:2017
    Aaverage_temp_yearly(i)= nanmean(Amean_temps(Atemp_year== year));
    Qaverage_temp_yearly(i)= nanmean(Qmean_temps(Qtemp_year== year));
    i= i+1;
end

%% TODO: MAKE IT PRETTY
years=[2009:2017];
figure
hold on
yyaxis left
plot(years, Aaverage_temp_yearly,'linewidth', 2);
xlabel('Years');
ylabel('Temperature ({\circ}C)');
axis([2009,2017,-16,-7]);
yyaxis right
plot(years, Ayearly_avg,'linewidth', 2);
ylabel('Thickness (cm)');
title({'Auyuittuq Active Layer Thickness Yearly Average &',' Average Yearly Temperature Timeseries (2009-2017)'});
lgnd = {'temp mean', 'thickness mean'};
legend(lgnd,'location','NorthEast')
grid on
grid minor
hold off

figure
hold on
yyaxis left
plot(years, Qaverage_temp_yearly,'linewidth', 2);
xlabel('Years');
ylabel('Temperature ({\circ}C)');
axis([2009,2017,-20,-7]);
yyaxis right
plot(years, Qyearly_avg,'linewidth', 2);
ylabel('Thickness (cm)');
title({'Quttinirpaaq Active Layer Thickness Yearly Average &',' Average Yearly Temperature Timeseries (2009-2017)'});
lgnd = {'temp mean', 'thickness mean'};
legend(lgnd,'location','NorthWest');
grid on
grid minor
hold off

%% THICKNESS VS TEMP

%TODO ADD TRENDLINE STATS

Axt=transpose(Aaverage_temp_yearly);
Ayt=transpose(Ayearly_avg);
[coef, bint, r, rint, stats]= regress(Ayt, [ones(size(Axt)) Axt]);
r_squared= stats(1);
p_val= stats(3);
slope=coef(2,1);
y_int= coef(1,1);


pred_thickness= slope*Aaverage_temp_yearly+y_int;

linfit = coef(1)+coef(2).*date;
linfitbotlim = coef(1)+bint(2,1).*date;
linfittoplim = coef(1)+bint(2,2).*date;
    
figure
hold on 
plot(Aaverage_temp_yearly,Ayearly_avg, 'r.', 'Markersize', 10);
plot(Aaverage_temp_yearly,pred_thickness,'linewidth', 2)
title({'Auyuittuq Active Layer Thickness Yearly Average VS',' Average Yearly Temperature (2009-2017)'});
ylabel('ALT thickness (cm)');
xlabel('Average Temperature ({\circ}C)');
lgnd = {'Observed mean thickness', 'Predicted mean thickness'};
legend(lgnd,'location','SouthEast')
text(-15,37,['Slope = ',num2str(round(coef(2),3)),...
    '; R^2=',num2str(round(stats(1),3))...
    '; p val=',num2str(round(stats(3),3))...
    '; confidence int = [' num2str(round(bint(2,1),3)) ','...
    num2str(round(bint(2,2),3)) ']']);
axis([-15,-8,22,38]);
grid on
grid minor
hold off
hold off


Qxt=transpose(Qaverage_temp_yearly);
Qyt=transpose(Qyearly_avg);
[coef, bint, r, rint, stats]= regress(Qyt, [ones(size(Qxt)) Qxt]);
r_squared= stats(1);
p_val= stats(3);
slope=coef(2,1);
y_int= coef(1,1);
pred_thickness= slope*Qaverage_temp_yearly+y_int;
figure
hold on
plot(Qaverage_temp_yearly,Qyearly_avg, 'r.', 'Markersize', 10);
plot(Qaverage_temp_yearly,pred_thickness,'linewidth', 2)
title({'Quttinirpaaq Active Layer Thickness Yearly Average VS',' Average Yearly Temperature (2009-2017)'});
ylabel('ALT thickness (cm)');
xlabel('Average Temperature ({\circ}C)');
lgnd = {'Observed mean thickness', 'Predicted mean thickness'};
legend(lgnd,'location','SouthEast')
text(-15,68,['Slope = ',num2str(round(coef(2),3)),...
    '; R^2=',num2str(round(stats(1),3))...
    '; p val=',num2str(round(stats(3),3))...
    '; confidence int = [' num2str(round(bint(2,1),3)) ','...
    num2str(round(bint(2,2),3)) ']']);
axis([-15,-8,54,69]);
grid on
grid minor
hold off
hold off


%% RATE OF CHANGE IN THICKNESS
Ayears=transpose([2009:2017]);
Athickness_rate_change=[];
for i = 2:length(Ayearly_avg)-1
        Athickness_rate_change(i) = nanmean(Ayearly_avg(i-1:i+1));      
end

[coef, bint, r, rint, stats]= regress(Ayt, [ones(size(Ayears)) Ayears]);
slope=coef(2,1);
y_int= coef(1,1);
A_overall_rate_change= slope*Ayears+y_int;


years=[2010:2016];
figure 
hold on
plot(years,Athickness_rate_change(2:end),'linewidth', 2);
plot(years,A_overall_rate_change(2:end-1),'linewidth', 2);
title({'Auyuittuq rate change in Active Layer Thickness over time'});
ylabel('ALT rate of change (cm/year)');
xlabel('Years');
lgnd = {'Yearly rate of change', 'Overall rate of change(2009 - 2017)'};
legend(lgnd,'location','NorthEast')
grid on
grid minor
hold off
hold off


Qthickness_rate_change=[];
for i = 2:length(Qyearly_avg)-1
        Qthickness_rate_change(i) = nanmean(Qyearly_avg(i-1:i+1));
end
figure
plot(years,Qthickness_rate_change(2:end));
    
    


%% THICKNESS TIMESERIES RAW
Ayearly_avg=[];
Arow = 1;
for year = 2009:2017
        Acondition = Ayears_data == year;
        Ayavg= nanmean(Aaverage_thickness(Acondition));
        Ayearly_avg(Arow)= Ayavg;
        Amax_per_year(Arow) = max(Aaverage_thickness(Acondition));
        Amin_per_year(Arow)= min(Aaverage_thickness(Acondition));
        Astd_per_year(Arow)= nanstd(Aaverage_thickness(Acondition));
        Arow = Arow+1;
end
Ayears=[2009:2017];
Astd_positive = Ayearly_avg + Astd_per_year;
Astd_negative =Ayearly_avg - Astd_per_year;

figure
axis([2008,2018,14,72]);
hold on
plot(Ayears,Ayearly_avg, '-*k','linewidth', 2);
plot(Ayears,Astd_positive, '--r');
plot(Ayears,Astd_negative, '--b');
plot(Ayears,Amax_per_year, '^r', 'Markersize', 4);
plot(Ayears,Amin_per_year, 'vb', 'Markersize', 4);
title('Active Layer Thickness Yearly Average Auyuittuq (2009-2017)');
ylabel('Thickness (cm)');
xlabel('Year');
lgnd = {'thickness mean', 'thickness mean + \sigma','thickness mean - \sigma', 'thickness max', 'thickness min'};
legend(lgnd,'location','NorthEast')
grid on
grid minor
hold off


Qyearly_avg=[];
Qrow = 1;
for year = 1999:2017
        Qcondition = Qyears_data == year;
        Qyavg= nanmean(Qaverage_thickness(Qcondition));
        Qyearly_avg(Qrow)= Qyavg;
        Qmax_per_year(Qrow) = max(Qaverage_thickness(Qcondition));
        Qmin_per_year(Qrow)= min(Qaverage_thickness(Qcondition));
        Qstd_per_year(Qrow)= nanstd(Qaverage_thickness(Qcondition));
        Qrow = Qrow+1;
end
Qyears=[1999:2017];
Qstd_positive = Qyearly_avg + Qstd_per_year;
Qstd_negative =Qyearly_avg - Qstd_per_year;

figure
axis([1998,2018,34,90]);
hold on
plot(Qyears,Qyearly_avg, '-*k','linewidth', 2);
plot(Qyears,Qstd_positive, '--r');
plot(Qyears,Qstd_negative, '--b');
plot(Qyears,Qmax_per_year, '^r', 'Markersize', 4);
plot(Qyears,Qmin_per_year, 'vb', 'Markersize', 4);
title('Active Layer Thickness Yearly Average Quttinirpaaq (2009-2017)');
ylabel('Thickness (cm)');
xlabel('Year');
lgnd = {'thickness mean', 'thickness mean + \sigma','thickness mean - \sigma', 'thickness max', 'thickness min'};
legend(lgnd,'location','NorthWest')
grid on
grid minor
hold off









