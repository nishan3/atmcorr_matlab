% This code calls atmcorr_param
% Nishan Bhattarai, nbhattarATsyr.edu, nbhattarATumich.edu
% Last modified: Sep 10, 2018; Matlab version: 2017a
% This code runs http://atmcorr.gsfc.nasa.gov/atm_corr.html that uses 
% input parameters and uses the National Centers for Environmental Prediction (NCEP)
% modeled atmospheric global profiles for a particular date, time
% and location as input. Using commercially-available MODTRAN
% software and a suite of integration algorithm to compute site-specific
% atmospheric transmission, and upwelling and downwelling
% radiances

% source: https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1294665
% NASA ACPC, Atmospheric Correction Parameter Calculator

% cd ('E:\atmcorr_matlab');
close all; clear;
cd 
stlon =-97.488;
stlat = 36.6058;
year = 2015;
month = 5;
day = 30;
imghr = 10;
imgmm = 30;
profile_option = 2;
stdatm_opt = 1;
landsattype = 8;

% email = 'your email'; %PLESE DO NOT USE MY EMAIL- The system will
% automatically send an email to the given address (from Barsi, NASA), once
% the parameters are estimated.

email = 'onlynishan@gmail.com';



% [Lu,Ld,t] = atmcorr_param(year,month,day,imghr,imgmm,stlat,stlon,landsattype,email,profile_option,stdatm_opt);
[Lu,Ld,t] = atmcorr_param(year,month,day,imghr,imgmm,stlat,stlon,landsattype,email);

%% to run a loop.
%It's really annoying to run the website and manually input the parameters.
% A loop calling this function will sove this issue


% 1) Have input variables in a table/mat
% 2) create loop and save outputs in table/mat
% 3) use different email in every step (repeat after 3rd or 4th loop) to
% avoid possible problems 










