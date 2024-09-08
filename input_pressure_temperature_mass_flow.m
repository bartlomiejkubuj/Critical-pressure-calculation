function [P1, T1, P2, T2, W] = input_pressure_temperature_mass_flow()
%% function input_pressure_temperature_mass_flow is used to input parameters in containers and the mass flux in the valve

    % Ask for pressure and temperature in the first container
    P1 = input('Enter pressure in the first container (bar): ');
    T1 = input('Enter temperature in the first container, enter "0" for saturation temperature (C): ');
        if T1 == 0 % allows for obtaining exact values saturation temperatures
        T1 = XSteam('TSat_p',P1);
        end
    % Ask for pressure and temperature in the second container
    P2 = input('Enter pressure in the second container (bar): ');
    T2 = input('Enter temperature in the second container, enter "0" for saturation temperature (C): ');
        if T2 == 0 % allows for obtaining exact values saturation temperatures
        T2 = XSteam('TSat_p',P2);
        end

    % Ask for mass flow rate in the valve
    W = input('Enter mass flow rate in the valve (kg/s): ');
end