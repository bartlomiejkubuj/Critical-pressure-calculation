function [Gcrit, Pcrit] = critical_two_phase_flow_mass_flux(In1)
%% function critical_two_phase_flow_mass_flux calculates critical mass flow and critical pressure for wet steam using HEM model.

err = 1.e8;
eps = 0.00000001; % maximal absolute error
iter = 0;
pr = [0.95 0.8 0.2]; %coefficients used for guessing new critical pressure values
s0 = XSteam('sL_p',In1); % stagnation entropy for liquid water. In H. Anglart's code was stagnation entropy for water vapour.
h0 = XSteam('hL_p',In1); % stagnation enthalpy for liquid water. In H. Anglart's code was stagnation enthalpy for water vapour.

pgs = In1 .* pr; % new guesses for critical pressure 

for i=1:3
G(i) = mflux(pgs(i),s0,h0); % calculation of critical mass flux for each pressure guess
end

%% loop which finds highest possible value of critical mass flux
while err > eps

y = max(pr);
z = min(pr);
p_fit = z : (y-z)/199 : y; % new values of pressure coefficients
pgs_fit = In1 .* p_fit; % new pressures in range <z , y>
for i=1: 200
D(i) = mflux(pgs_fit(i),s0,h0); % cacluation of mass fluxes for each point in range <z, y>
end
[Dn,ip] = sort(D,"descend"); % sorting results to find highest mass flux result
G(4) = Dn(1); % addition of fourth element to the initial mass flux matrix
pr(4) = p_fit(ip(1)); % addition of fourth element to the initial pressure coefficient matrix
[Gn,id] = sort(G,"descend"); 
prn = pr(id);
err = abs(Gn(1)-Gn(2)); % calculation of absolute error between two closest, highest results
G = [];
G = Gn(1:3); % removal of the lowest element in mass flux matrix
pgs = [];
pr = [];
pr = prn(1:3); % removal of the element in pressure coefficient matrix, which corresponds to the lowest mass flux
pgs = In1 .* pr; % new guesses of critical pressure values
iter = iter + 1; % if absolute error is higher than in the conditions => next iteration
end

Gcrit = G(1); % critical mass flux [kg / (m^2 * s)]
Pcrit = pgs(1); % critical pressure [bar]

end