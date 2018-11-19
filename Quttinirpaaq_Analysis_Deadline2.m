clear
close all
clc
quttinirpaaq_data = xlsread('Quttinirpaaq.xlsx');
Qyears_data = quttinirpaaq_data(:,3);
Qgrid_number = quttinirpaaq_data(:,4);
Qfirst_thickness = quttinirpaaq_data(:,5);
Qsecond_thickness = quttinirpaaq_data(:,6);
Qmatrix1=[Qfirst_thickness(:),Qsecond_thickness(:)];
QmatrixT= transpose(Qmatrix1);
QmatrixT(QmatrixT == -99999) = NaN;
Qaverage_thickness = nanmean(QmatrixT);


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
title('Active Layer Thickness Yearly Average Quttinirpaaq');
ylabel('Thickness (cm)');
xlabel('Year');
lgnd = {'thickness mean', 'thickness mean + \sigma','thickness mean - \sigma', 'thickness max', 'thickness min'};
legend(lgnd,'location','NorthWest')
grid on
grid minor
hold off

