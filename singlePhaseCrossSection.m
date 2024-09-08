function [Acrit, Pcrit] = singlePhaseCrossSection(P, T, W)
%% function singlePhaseMassFlow calculates critical cross section area and critical pressure for the valve of known mass flow rate and conditions in first container.

cp = XSteam('Cp_pT',P, T); % Specific isobaric heat capacity
cv = XSteam('Cv_pT',P, T); % Specific isochoric heat capacity
k = cp / cv; % calculation of heat capacity ratio
R = cp - cv; % calculation of gas constant
Pcrit = P * (2 / (k + 1)) ^ (k / (k - 1)); % critical pressure [bar]
Acrit = W / ((Pcrit * (10^5) / sqrt(T + 273.15)) * sqrt(k / R) * sqrt( (2 / (k + 1)) ^ ((k + 1) / (k - 1)) )); % critical cross section [m^2]
end
