clear
close all
clc
auyuittuq_data = xlsread('Auyuittuq.xlsx');
Ayears_data = auyuittuq_data(:,3);
Agrid_number = auyuittuq_data(:,4);
Afirst_thickness = auyuittuq_data(:,5);
Asecond_thickness = auyuittuq_data(:,6);
Amatrix1=[Afirst_thickness(:),Asecond_thickness(:)];
AmatrixT= transpose(Amatrix1);
AmatrixT(AmatrixT == -99999) = NaN;
Aaverage_thickness = nanmean(AmatrixT);


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
title('Active Layer Thickness Yearly Average Auyuittuq');
ylabel('Thickness (cm)');
xlabel('Year');
lgnd = {'thickness mean', 'thickness mean + \sigma','thickness mean - \sigma', 'thickness max', 'thickness min'};
legend(lgnd,'location','NorthEast')
grid on
grid minor
hold off

