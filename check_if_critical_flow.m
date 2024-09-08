function crit = check_if_critical_flow(P2, Pcrit)
    %% Check if the flow is critical or subsonic using calculated critical pressure

    if P2 <= Pcrit % Pressure in second container is lower than required treshold
        crit = 'Critical flow';
        fprintf('Critical flow\n');

    elseif P2 > Pcrit % Pressure in second container is higher than required treshold
        crit = 'Subcritical flow';
        fprintf('Subcritical flow\n');

end