clear
close all
clc

%Each of the locations’ data will be plot against air surface temperature 
%to investigate if there a relationship or significant correlation between 
%air surface temperature and active layer thickness. Finally the yearly 
%rates of change at the two locations will be compared through a  a one-way
%ANOVA test to check for significant difference. We intend to compare our 
%results with the “Thermal State of Permafrost and Active Layer in Central 
%Asia during the International Polar Year.” study that is described at 
%the end of this document.
%==============================================================================================================
%%
%RAW DATA

quttinirpaaq_data = xlsread('Quttinirpaaq.xlsx');
Qyears_data = quttinirpaaq_data(:,3);
Qgrid_number = quttinirpaaq_data(:,4);
Qfirst_thickness = quttinirpaaq_data(:,5);
Qsecond_thickness = quttinirpaaq_data(:,6);
Qmatrix1=[Qfirst_thickness(:),Qsecond_thickness(:)];
QmatrixT= transpose(Qmatrix1);
QmatrixT(QmatrixT == -99999) = NaN;
Qaverage_thickness = nanmean(QmatrixT);

Qfirst_thickness(Qfirst_thickness == -99999) = NaN;
Qmask1 = ~(isnan(Qfirst_thickness)| isnan(Qyears_data));
Qsecond_thickness(Qsecond_thickness == -99999) = NaN;
Qmask2 = ~(isnan(Qsecond_thickness)| isnan(Qyears_data));


auyuittuq_data = xlsread('Auyuittuq.xlsx');
Ayears_data = auyuittuq_data(:,3);
Agrid_number = auyuittuq_data(:,4);
Afirst_thickness = auyuittuq_data(:,5);
Asecond_thickness = auyuittuq_data(:,6);
Amatrix1=[Afirst_thickness(:),Asecond_thickness(:)];
AmatrixT= transpose(Amatrix1);
AmatrixT(AmatrixT == -99999) = NaN;
Aaverage_thickness = nanmean(AmatrixT);

%Amask = ~(isnan(Afirst_thickness)| isnan(Qyears_data));


%PLOT RAW DATA

figure
subplot(211)
plot(Qyears_data(Qmask1),Qfirst_thickness(Qmask1), '-*k');
title('Active Layer Thickness RAW data (all points) Quttinirpaaq Measurement 1');
ylabel('Thickness (cm)');
xlabel('Year');
grid on
grid minor


subplot(212)
plot(Qyears_data(Qmask2),Qsecond_thickness(Qmask2), '-*k');
title('Active Layer Thickness RAW data (all points) Quttinirpaaq  Measurement 2');
ylabel('Thickness (cm)');
xlabel('Year');
grid on
grid minor


auyuittuq_data = xlsread('Auyuittuq.xlsx');
Ayears_data = auyuittuq_data(:,3);
Agrid_number = auyuittuq_data(:,4);
Afirst_thickness = auyuittuq_data(:,5);
Asecond_thickness = auyuittuq_data(:,6);
Amatrix1=[Afirst_thickness(:),Asecond_thickness(:)];
AmatrixT= transpose(Amatrix1);
AmatrixT(AmatrixT == -99999) = NaN;
Aaverage_thickness = nanmean(AmatrixT);

Afirst_thickness(Afirst_thickness == -99999) = NaN;
Amask1 = ~(isnan(Afirst_thickness)| isnan(Ayears_data));
Asecond_thickness(Asecond_thickness == -99999) = NaN;
Amask2 = ~(isnan(Asecond_thickness)| isnan(Ayears_data));


figure
subplot(211)
plot(Ayears_data(Amask1),Afirst_thickness(Amask1), '-*k');
title('Active Layer Thickness RAW data (all points) Auyuittuq Measurement 1');
ylabel('Thickness (cm)');
xlabel('Year');
grid on
grid minor


subplot(212)
plot(Ayears_data(Amask2),Asecond_thickness(Amask2), '-*k');
title('Active Layer Thickness RAW data (all points) Auyuittuq  Measurement 2');
ylabel('Thickness (cm)');
xlabel('Year');
grid on
grid minor

