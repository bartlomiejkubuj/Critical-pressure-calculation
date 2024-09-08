function [A] = SubcriticalSinglePhaseCrossSection(P1, P2, T, W)
%% function SubcriticalSinglePhaseCrossSection calculates cross section of the valve of known mass flow rate and conditions in both containers.
% It can be used for subcritcial superheated vapor flows

cp = XSteam('Cp_pT',P1, T); % Specific isobaric heat capacity
cv = XSteam('Cv_pT',P1, T); % Specific isochoric heat capacity
k = cp / cv; % calculation of heat capacity ratio
R = cp - cv; % calculation of gas constant
A = (W / (P1 * (10^5)) / sqrt(T + 273.15)) * sqrt(2 * k / (R * (k - 1) )) * sqrt( (P2 / P1) ^ (2 / k) - (P2 / P1) ^ ((k + 1) / k)); %cross section area [m^2]

end