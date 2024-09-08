function G = mflux(In1,In2,In3)
%% function mflux calculates mass flux of the wet steam using HEM model.

sl = XSteam('sL_p',In1); % saturated liquid entropy
sv = XSteam('sV_p',In1); % saturated vapour entropy 
il = XSteam('hL_p',In1); % saturated liquid enthalpy
iv = XSteam('hV_p',In1); % saturated vapour enthalpy
rol = XSteam('rhoL_p',In1); % saturated liquid density
rov = XSteam('rhoV_p',In1); % saturated vapour density

X = (In2 - sl) / (sv - sl); % calulation of the quality of the wet steam

i = il + X * (iv - il); % calulation of the enthalpy of the wet steam. In H. Anglart's code: "i = il + X * (il - iv)"

roh = 1 / (1 / rol + X * (1 / rov - 1 / rol)); %% calcualtion of specific density of the wet steam. In H. Anglart's code "roh = 1 / (1 / rol + X / rov )"

G = roh * sqrt(2 * 1000 * (In3 - i)); % Calculation of mass flux of the wet steam. Solution had to be scaled by 1000 due to unit missmatch.
end