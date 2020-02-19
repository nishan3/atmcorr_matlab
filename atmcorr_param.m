function [Lu,Ld,t] = atmcorr_param(year,month,day,imghr,imgmm,stlat,stlon,landsattype,email,profile_option,stdatm_opt)
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
% url =  'https://atmcorr.gsfc.nasa.gov/';
url = 'https://atmcorr.gsfc.nasa.gov/cgi-bin/atm_corr.pl';
% url = 'https://atmcorr.gsfc.nasa.gov/cgi-bin/atm_corr/atm_corr.pl';



%% INPUTS
% stlon =-97.488;
% stlat = 36.6058;
% year = 2015;
% month = 5;
% day = 30;
% imghr = 10;
% imgmm = 30;
% profile_option = 2;
% stdatm_opt = 1;
% landsattype = 8;
% email = 'your email'; %PLESE DO NOT USE MY EMAIL- The system will
% automatically send an email to the given address (from Barsi, NASA), once
% the parameters are estimated.

%% OUTPUTS
% Lu= upwelling or atmospheric path radiance
% Ld= downwelling or sky radiance
% t=  atmospheric transmission;


if nargin  < 9
    error('Number of Input is less than 9, please check your inputs')
    
elseif nargin  == 9
    disp(' Define atmospheric profile (either closest lat/lon(1) or interpolated (2) and standard atmosphere for upper atmospheric profile: Default options used');
    profile_option = 2;
    
    %     2 = winter, 1= summer: mid-latitude summer/winter standard atmosphere for upper atmospheric profile
    if month < 3||month > 10
         stdatm_opt = 2;
    else
        stdatm_opt =1;
    end
    
    
    elseif nargin  == 10
    disp(' Define standard atmosphere for upper atmospheric profile: Default options used');
    %     2 = winter, 1= summer: mid-latitude summer/winter standard atmosphere for upper atmospheric profile
    if month < 3||month > 10
         stdatm_opt = 2;
    else
        stdatm_opt =1;
    end
    
elseif nargin > 11
    error('Too many input arguments')
    
    
end



% run
yearstr = int2str(year);
monthstr = int2str(month);
daystr = int2str(day);
hourstr = num2str(imghr);
minutestr = num2str(imgmm);
stlonstr = num2str(stlon);
stlatstr = num2str(stlat);
landsattypestr = int2str(landsattype);
profile_optionstr = int2str(profile_option);
stdatm_optstr = int2str(stdatm_opt);



[s,~]=urlread(url, 'get', {'year',yearstr,'month',monthstr,'day',daystr,'hour',hourstr,'minute',minutestr,'thelat',...
    stlatstr,'thelong',stlonstr,'profile_option',profile_optionstr,'stdatm_option',stdatm_optstr,'L57_option',landsattypestr,'user_email',email});

% aa_str=textscan(s,'%s','delimiter','<>, ');
% aa_str = aa_str{1};
% TF = contains(aa_str, "href=");
% aa_link = aa_str{TF==1};
% newStr = erase(aa_link,"href=");
% newStr = erase(newStr,"""");

% try
%     s = webread(newStr);
% catch
% end
s_str=textscan(s,'%s','delimiter','<>, ');
s_str = s_str{1};
s_str= s_str(~cellfun('isempty',s_str));

% up = contains(s_str, "upwelling");
Lu = str2double(s_str{find(contains(s_str, "upwelling")==1)+2});
Ld = str2double(s_str{find(contains(s_str, "downwelling")==1)+2});
t = str2double(s_str{find(contains(s_str, "transmission:")==1)+1});
end

