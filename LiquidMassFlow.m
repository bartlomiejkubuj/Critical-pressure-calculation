function [W, Wmax] = LiquidMassFlow(P1, T1, P2, A)
%% function LiquidMassFlow calculates mass flow in the valve for incompressible liquid flow. 
% as the flow is incompressible, critical flow is not possible
    rho = XSteam('rho_pT',P1,T1); % water density
    W = A * sqrt(2 * rho * (P1 - P2)); % mass flow
    Wmax = A * sqrt(2 * rho * (P1)); % maximal mass flow (for P2 == 0)
end