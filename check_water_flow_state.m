function phase = check_water_flow_state(P, T)
    % Check if the water flow is single-phase or two-phase using XSteam
    
    % Check if pressure and temperature are within the valid range for water
    if P <= 0 || T <= 0
        error('Pressure and temperature must be positive values.');
    end
    
    % Check if pressure is within the valid range for XSteam functions
    if P > 1000 || T > 2000
        error('Pressure and tmperature exceeds the critical pressure of water.');
    end
    
    % Get saturation temperature at given pressure
    Tsat = XSteam('tsat_p', P);
    
    % Check if the given pressure and temperature are within the saturation curve
    if T < Tsat
        phase = 'Liquid'; % Below saturation curve: liquid phase
        fprintf('Sigle phase liquid flow\n');
    elseif T > Tsat
        phase = 'Superheated Vapor'; % Above saturation curve: vapor phase
        fprintf('Sigle phase vapour flow\n');
    else
        phase = 'Two-Phase'; % In the two-phase region
        fprintf('Two-phase flow\n');
    end
end