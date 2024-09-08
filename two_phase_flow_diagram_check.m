clc, clear
p = linspace(70, 150, 500);

for i = 1:500
    [Gcrit(i), Pcrit(i)] = critical_two_phase_flow_mass_flux(p(i));
end
plot(p,Gcrit);