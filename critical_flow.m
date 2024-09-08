function [W, Wmax, A, Pcrit] = critical_flow()
%% function critical_flow can be used for calculation of critical parameters of water, vapour and wet steam flows
% Function operates for two cases. In case 1 cross-section of
% connecting valve, temperature and pressure in both containers are known.
% Function calculates critical pressure and critical mass flow.
% In case 2 mass flow in the valve, temperature and pressure in both
% containers are known.
% Function calculates critical pressure and critical cross-section area.
% In both cases function checks the phase of the flow, tells if flow between
% containers will be critical, and if it isn't, function will calulate
% values of mass flux and cross-section area for this case.
%% Display menu to choose between cases
fprintf('Choose a case:\n');
fprintf('1. Case 1, find critical mass flow rate in defined valve\n');
fprintf('2. Case 2, find critical cross section area for defined mass flow rate\n');
%% Ask the user to select a case
choice = input('Enter your choice (1 or 2): ');
%% Perform actions based on the chosen case
switch choice
%% 1. CASE 1: Find critical mass flow rate for a container and valve of know cross section area
    case 1
        disp('You chose Case 1.');

        [P1, T1, P2, T2, A] = input_pressure_temperature_cross_section(); %Function reading inputs for case 1
        phase = check_water_flow_state(P1, T1); % Function checking phase of the flow

    if  strcmp(phase, 'Superheated Vapor')
        [Wcrit, Pcrit] = singlePhaseMassFlow(P1, T1, A); % calculation of critical mass flow and maximal pressure in second container to obtain critical flow
        crit = check_if_critical_flow(P2, Pcrit); % function comparing critical pressure to pressure in second container
        if strcmp(crit, 'Critical flow') % calculation of flow rate for critical flow
            W = Wcrit;
            Wmax = 0;

        elseif strcmp(phase, 'Subcritical flow')
            W = SubcriticalSinglePhaseMassFlow(P1, P2, T1, A); % calculation of flow rate for subcritical flow
            Wmax = 0;
        end

    elseif strcmp(phase, 'Liquid')
        fprintf('Incompressible fluid flow (no critical flow)');
        [W, Wmax] = LiquidMassFlow(P1, T1, P2, A); %Incompressible fluid flow (no critical flow)
        Pcrit = 0;

    elseif strcmp(phase, 'Two-Phase')
        [Gcrit, Pcrit] = critical_two_phase_flow_mass_flux(P1); % calculation of critical mass flux maximal pressure in second container to obtain critical flow
        crit = check_if_critical_flow(P2, Pcrit); % function comparing critical pressure to pressure in second container
        if strcmp(crit, 'Critical flow') % calculation of flow rate for critical flow
            W = Gcrit * A;
            Wmax = 0;

        elseif strcmp(phase, 'Subcritical flow') % calculation of flow rate for subcritical flow
            s0 = XSteam('sL_p',P1);
            h0 = XSteam('hL_p',P1);
            G = mflux(P2,s0,h0);
            W = G * A;
            Wmax = 0;
        end
    end
%% 2. CASE 2: Find critical cross section area for a container and valve of know mass flow rate
    case 2
        Wmax = 0;
        disp('You chose Case 2.');
        [P1, T1, P2, T2, W] = input_pressure_temperature_mass_flow(); %Function reading inputs for case 2
        phase = check_water_flow_state(P1, T1); % Function checking phase of the flow
        

        if strcmp(phase, 'Superheated Vapor')
        [Acrit, Pcrit] = singlePhaseCrossSection(P1, T1, W); % calculation of critical cross section area and maximal pressure in second container to obtain critical flow
        crit = check_if_critical_flow(P2, Pcrit);

            if strcmp(crit, 'Critical flow') % calculation of cross section area for critical flow
                A = Acrit;

            elseif strcmp(phase, 'Subcritical flow')
                A = SubcriticalSinglePhaseCrossSection(P1, P2, T1, W); % calculation of cross section area for subcritical flow
            end

    elseif strcmp(phase, 'Liquid')
        fprintf('Incompressible fluid flow (no critical flow)');
        A = LiquidCrossSection(P1, T1, P2, W); %Incompressible fluid flow (no critical flow)

    elseif strcmp(phase, 'Two-Phase')
        [Gcrit, Pcrit] = critical_two_phase_flow_mass_flux(P1); % calculation of critical mass flux maximal pressure in second container to obtain critical flow
        crit = check_if_critical_flow(P2, Pcrit); % function comparing critical pressure to pressure in second container

        if strcmp(crit, 'Critical flow') % calculation of flow rate for critical flow
            A = W / Gcrit;

        elseif strcmp(phase, 'Subcritical flow') % calculation of cross-section area for subcritical flow
            s0 = XSteam('sL_p',P1);
            h0 = XSteam('hL_p',P1);
            G = mflux(P2,s0,h0);
            A = W / G;
        end
    end

%% 3. ERROR        
    otherwise
        % Handle invalid input
        disp('Invalid choice. Please choose 1 or 2.');
end

%% Display the result
fprintf(['\n RESULTS: \n' ...
    'W = %d [kg/s] \n' ...
    'Wmax = %d [kg/s] \n' ...
    'Pcrit = %d [bar] \n' ...
    'A = %d [m^2] \n'],W,Wmax,Pcrit,A);
end