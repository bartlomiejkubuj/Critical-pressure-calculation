function [W] = SubcriticalSinglePhaseMassFlow(P1, P2, T, A)
%% function singlePhaseMassFlow calculates mass flow for the valve of known cross section area and conditions in both container.
% It can be used for subcritcial superheated vapor flows

cp = XSteam('Cp_pT',P1, T); % Specific isobaric heat capacity
cv = XSteam('Cv_pT',P1, T); % Specific isochoric heat capacity
k = cp / cv; % calculation of heat capacity ratio
R = cp - cv; % calculation of gas constant
W = (A * (P1 * (10^5)) / sqrt(T)) * sqrt(2 * k / (R * (k - 1) )) * sqrt( (P2 / P1) ^ (2 / k) - (P2 / P1) ^ ((k + 1) / k)); % mass flow [kg/s]

end