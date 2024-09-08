READ ME
This file contains instructions on how to use function "critical_flow" and 2 common examples
Function can be inserten in any script and it doesn't require any pre-defined variables.


//////////////////////////////////////////////////////////////////////////////////

%% INSTRUCTION AND DESCRIPTION

Function “critical_flow” can be used for calculation of critical parameters of 
water, vapour and wet steam flows. Function operates in two modes. 
In case 1 cross-section of connecting valve, temperature and pressure in both 
containers are known. Function will calculate critical pressure and critical mass flow.
In case 2 mass flow in the valve, temperature and pressure in both containers are known. 
Function will calculate critical pressure and critical cross-section area.
In both cases function check the phase of the flow, tells if flow between 
containers will be critical, and if it isn't, function will calculate 
values of mass flux and cross-section area for this case.

Here is presented step-by-step instruction of operation of the function:

1.
Function asks to choose in which mode it should operate. User can choose between two cases:
1 – for the problem of unknown mass flux in the valve connecting two containers, 
2 – for problems regarding unknown cross-section area of the valve. 
Type “1” or ”2” to choose between cases.

2.
After choosing the case, function will ask to input initial parameters of both containers 
(pressure and temperature) and, depending on the case chosen, either the mass flow or 
the cross-section area of the valve. In both cases, all values should be positive, 
temperature should be lower than 2000 °C, and pressure should be lower than 1000 bar. 
User can also obtain exact value of saturation temperature for previously set pressure by typing “0” when function asks
for temperature input. This allows for implementation of the function in two
-phase flow problems.

3.
Function checks the phase of the flow.

4.
With that information, function chooses adequate method of calculation of the critical pressure and critical mass flux.

5.
Function compares obtained critical pressure to pressure in the second container. 
If the pressure is lower or the same as the critical pressure, than function states 
that flow is critical. Using critical mass flux, function calculates either the cross-section area or the mass flow.

6.
If the pressure in the second container is higher than the critical pressure, 
than function states that flow is subcritical and chooses correct method of calculation 
of either the mass flow or the cross-section area for given phase of the flow.

//////////////////////////////////////////////////////////////////////////////////

%% EXAMPLES

Example 1 (Find critical mass flow rate through defined valve for a two-phase flow)

Choose a case:
1. Case 1, find critical mass flow rate in defined valve
2. Case 2, find critical cross section area for defined mass flow rate
Enter your choice (1 or 2): 1
You chose Case 1.

DATA:
Enter pressure in the first container (bar): 100
Enter temperature in the first container, enter "0" for saturation temperature (C): 0
Enter pressure in the second container (bar): 50
Enter temperature in the second container, enter "0" for saturation temperature (C): 0
Enter cross section area (m^2): 0.05

FLOW DESCRIPTION:
Two-phase flow % script recognises phase of the flow
Critical flow % by comparison with pressure in second container, script decides if flow is critical or subcritical

RESULTS:
W = 1.6695e+03 [kg/s] % critical mass flow (for pure incompressible liquid flow this value describes mass flow rate for given parameters)
Wmax = 0 % this variable decribes maximal mass flow for pure incompressible liquid flow
Pcrit = 76.5327 [bar] % critical pressure (for graphical decription open file "mass_flux_vs_pressure_for_stagnation_pressure_100.jpg")
A = 0.05 [m^2] % valve cross section (in this case - defined by user)


Example 2 (Find critical cross section area for defined mass flow rate for a signle-phase gas flow)

Choose a case:
1. Case 1, find critical mass flow rate in defined valve
2. Case 2, find critical cross section area for defined mass flow rate
Enter your choice (1 or 2): 2
You chose Case 2.

DATA:
Enter pressure in the first container (bar): 80
Enter temperature in the first container, enter "0" for saturation temperature (C): 500
Enter pressure in the second container (bar): 30
Enter temperature in the second container, enter "0" for saturation temperature (C): 400
Enter mass flow rate in the valve (kg/s): 2000

FLOW DESCRIPTION:
Sigle phase vapour flow
Critical flow

RESULTS:
W = 2000 [kg/s] % critical mass flow (in this case - defined by user)
Wmax = 0 % this variable decribes maximal mass flow for pure incompressible liquid flow
Pcrit = 42.6816 [bar] % critical pressure
A = 0.0157 [m^2] % valve critical cross-section area