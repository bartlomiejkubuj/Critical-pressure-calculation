%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOT REVISED !!!
% HEM Critical Flow calculation for water-steam mixture
% Rev 0 26-09-2020
% Based on H. Anglart Thermal-Hydraulics in Nuclear Systems   [70]
% There is SciLab code for HEM model developed by Prof. Anglart, and here it is matlab implementation
% X-Steam package was used for steam-water proporties
% INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In1 		- p0 Stagnation pressure, can be a vector or single variable.
% In2		- pr Pressure downwind, can be a vector or single variable
% 
% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% EXAMPLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [out] = ()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Gcr, pcr] = CritFlowHEM(In1,In2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% // HEM critical flow of water-steam
% // This script calculates the steam-water critical mass flow
% // rate using HEM model
% //
% // Stagnation condition
p0 = In1;  				 %Orginal: p0 = 70.0;
n1 = numel(In1);
t0 = XSteam('Tsat_p',p0); %Orginal: t0 = tsat(p0);
%//
s0 = XSteam('sV_p',p0); 	%Orginal: s0 = senvsat(p0); // saturated steam
h0 = XSteam('hV_p',p0)		%Orginal: h0 = hvsat(p0);

pgs = []; G = [];
err = 1.e6; 				%// Initial error
eps = 1; 					%// Required accuracy for mass flux (kg/m2/s)
iter = 0;
%//
%// calculate the mass flux for three different pressures
%//
pr = In2;					%Orginal: pr = [0.95 0.8 0.5];
n2 = numel(In2);

pgs = p0.*pr;  				%Orginal: pgs = p0*pr; 	%// vector with initial guess

%// Define an inline function to calculate mass flux
deff('[G]=mflux(pgs,s0,h0)', ....
['x=(s0-senlsat(pgs))/(senvsat(pgs)-senlsat(pgs))'; ...
'hmix=hlsat(pgs)+x*hfg(pgs)'; ...
'rhom=1/(1/rholsat(pgs)+x/rhovsat(pgs))'; ...
'G=rhom*sqrt(2*(h0-hmix))']);
%//
for 
	i=1:3; G(i)=mflux(pgs(i),s0,h0); 
end
while err > eps;
	A=[1 pr(1) pr(1)*pr(1);1 pr(2) pr(2)*pr(2);1 pr(3) pr(3)*pr(3)];
	Y=A\G; 										%// Parabolic approximation for G=f(p)
	pr(4) = -Y(2)/2/Y(3); 						%// new pressure ratio guess at dG/dp=0
	G(4) = mflux(pr(4)*p0,s0,h0); 				%// New mass flux at dG/dp=0
	[Gn,id]=sort(G); 							%// Sort all values with largest first
	prn=pr(id);
	err = abs(Gn(1)-Gn(2)); 					%// measure of error
	G=[]; G=Gn(1:3); 							%// reject the smallest mass flux
	pgs=[]; pr=[]; pr=prn(1:3);
	pgs=p0*pr;
	iter = iter + 1;
end
Gcr = G(1); 								%// Critical mass flux (kg/m2/s)
pcr = pgs(1); 								%// critical pressure (bar)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%