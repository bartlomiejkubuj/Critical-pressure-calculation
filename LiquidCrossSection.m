function [A] = LiquidCrossSection(P1, T1, P2, W)
%% function LiquidCrossSection calculates cross-section area of the valve for incompressible liquid flow. 
% as the flow is incompressible, critical flow is not possible
    rho = XSteam('rho_pT',P1,T1); % water density
    A = W / sqrt(2 * rho * (P1 - P2)); % valve cross section area
end