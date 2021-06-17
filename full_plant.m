% full plant
% create the temperature reference function
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
P_thermal0 = 2568; % [MWt = 10^3 kJ/s] reactor core thermal power
num_sg = 2; % number of steam generators
P_sg0 = 6.38;  % [MPa] steam generator pressure
W_o0 = 680.4; % [kg/s] initial steam mass flow rate
W_fw0 = 680.4 % [kg/s] initial feedwater mass flow rate
T_sg_out0 = XSteam('Tsat_p', P_sg0 * 10) % [C] initial steam temperature
%T_sg_out2 = 312.8 + 273.15 % [K] steam temperature
h_sg_out0 = XSteam('hV_T', T_sg_out0); % [kJ/kg] initial steam specific enthalpy
% the feedwater is subcooled
h_fw = h_sg_out0 - P_thermal0 * 1e3 / num_sg / W_o0; % [kJ/kg] feedwater specific enthalpy
s_sg = XSteam('sV_p', P_sg0*10); % [kJ/K]specific entropy of the steam generator steam
eta = 0.809489; % the turbine efficiency
Pc = 0.008; % [MPa] the condenser pressure
Ndes = 3600.0; % [rpm] the turbine generator shaft speed set point
T_h0 = 317.7 % [C] hot leg initial temperature
T_c0 = 290.0 % [C] cold leg initial temperature
T_p0 = (T_h0 + T_c0) / 2 % [C] initial primary side average temperature
%% these parameters are assumed
ff = 0.98 % raction of reactor power deposited in the fuel
lambdas = [0.0124; 0.0305; 0.1110; 0.3010; 1.1400; 3.0100] %  effective precursor decay constants
Lambda = 0.0001 % effective prompt neutron lifetime
betas = [0.000215; 0.001424; 0.001274; 0.002568; 0.000748; 0.000273] % fraction of neutrons from delayed groups
beta = sum(betas) % fuel temperature coefficient
alpha_c = 0.00001 % [/C] coolant temperature coefficient
alpha_f = -0.00005 % [/C] fuel temperature coefficient
mu_f = 26.3 % [MW-s/C] total heat capacity of the fuel and structural material
mu_c = 70.5 % [MW-s/C] total heat capacity of the reactor coolant
J = 8500; % [kg-m^2] the turbine and generator shaft inertial
T_m0 = (T_p0 + T_sg_out0) / 2; % [C] the steam generator metal temperature 
mu_m = 8.46 % [MW-s/C] total heat capacity of the tube metal in thesteam generator
mu_p = 141.0 % [MW-s/C] total heat capacity of the coolant in the steamgenerator primary side
V_sg = 259.92 % [m^3] steam generator volume
V_f0 = 74.94 % [m^3] set ppint of water volume in steam generator in the secondary side
V_fr = 66.71 % [m^3] volume range in steam generator secondary side used in water level controller
T_f0 = 965.28 - 273.15 % [C] fuel temperature initial value

%% these parameters are derived
Z1 = P_thermal0 / (T_p0 - T_m0) / num_sg; % [MW/C] 105.99 heat transfer coefficient between coolant and steam generator tube metal
Z2 = P_thermal0 / (T_m0 - T_sg_out0) / num_sg % [MW/C] 105.99 heat transfer coefficient between steam generator tube metal and secondary water
M_sg = P_thermal0 / (T_h0 - T_c0) / num_sg; % [MW/C] mass flow rate times heat capacity of coolant in the steam generator primary side
h_cd0 = h_sg_out0 - eta * (h_sg_out0 - XSteam('h_ps', Pc*10, s_sg)); % initial condenser specific enthalpy
T_cd0 = XSteam('T_ph', Pc*10, h_cd0); % [C] initial condenser temperature
Pt0 = (h_sg_out0 - h_cd0) * eta * W_o0 *1e-3 *2 ; % 846 [MW] the turbine initial power
Pg0 = Pt0 % [MW] the generator initial power
M = M_sg * 2 % [MW/C] mass flow rate times heat capacity of coolant in the reactor core
Omega = P_thermal0 * ff / (T_f0 - T_h0) % [MW/C] heat transfer coefficient between fuel and coolant




