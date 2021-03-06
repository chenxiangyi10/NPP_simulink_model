% 

%{ 
external reference (steam its generation and use)
Plant information
    Power level, 2568 MWt
    Power level, 846 MWe
    Num of steam generators, 2
Steam generator design conditions
    Primay T(hot), 317.7 C
    Primary T(cold), 290.0 C
    Primary flow, 8273.16 kg/s
    Primary opearting pressure, 15.17 MPa
    Secondary steam temperature, 312.8 C
    Secondary feedwater temperature, 237.8 C
    Steam flow, 680.4 kg/s
    Secondary operating pressure, 6.38 MPa
Steam generator design data
    Num of tubes per generator, 15531
    Tube OD, 15.875 mm
    Tube minimum wall thickness, 0.864 mm
    Tube material, Inconel 600
    Surface Area 12356 m^2
    Tube pitch 22.225 mm
    Num of support plates 15
    Support plate type Broached
    Support plate material Carbon Steel
    Integral economizer No
%}

%% these parameters cannot be changes
P_thermal = 2568; % [MWt = 10^3 kJ/s] reactor core thermal power
num_sg = 2; % number of steam generators
P_sg0 = 6.38;  % [MPa] steam generator pressure
W = 680.4; % [kg/s] steam mass flow rate
T_sg_out = XSteam('Tsat_p', P_sg0 * 10) % [C] steam temperature
%T_sg_out2 = 312.8 + 273.15 % [K] steam temperature
h_sg_out = XSteam('hV_T', T_sg_out); % [kJ/kg] steam specific enthalpy
% the feedwater is subcooled
h_sg_in_val = h_sg_out - P_thermal * 1e3 / num_sg / W; % [kJ/kg] feedwater specific enthalpy
s_sg = XSteam('sV_p', P_sg0*10); % [kJ/K]specific entropy of the steam generator steam
eta = 0.809489; % the turbine efficiency
Pc = 0.008; % [MPa] the condenser pressure
Ndes = 3600; % [rpm] the turbine generator shaft speed set point
J = 8500; % [kg-m^2] the turbine and generator shaft inertial

% these parameters are derived
h_c = h_sg_out - eta * (h_sg_out - XSteam('h_ps', Pc*10, s_sg));
T_c = XSteam('T_ph', Pc*10, h_c);
Pt0 = (h_sg_out - h_c) * eta * W *1e-3 *2 ; % 846 [MW] the turbine initial power
Pg0 = Pt0 % [MW] the generator initial power

 