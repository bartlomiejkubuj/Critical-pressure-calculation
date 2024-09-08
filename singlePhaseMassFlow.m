function [Wcrit, Pcrit] = singlePhaseMassFlow(P, T, A)
%% function singlePhaseMassFlow calculates critical mass flow and critical pressure for the valve of known cross section area and conditions in first container.

cp = XSteam('Cp_pT',P, T); % Specific isobaric heat capacity
cv = XSteam('Cv_pT',P, T); % Specific isochoric heat capacity
k = cp / cv; % calculation of heat capacity ratio
R = cp - cv; % calculation of gas constant
Pcrit = P * ( (2 / (k + 1)) ^ (k / (k - 1)) ); % critical pressure [bar]
Wcrit = (A * (Pcrit * (10^5)) / sqrt(T + 273.15)) * sqrt(k / R) * sqrt( (2 / (k + 1)) ^ ((k + 1) / (k - 1)) ); % mass flow [kg/s]
end

