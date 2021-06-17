% turbine controller turing at full power level
%import XSteam;


hc = 1973.37; % [kJ/kg] the specific enthalpy of the exhaust steam
s_sg = 5.86; % [kJ/kg] the specific entropy of the steam in the steam generator
P_sg = 6.4; % [MPa] the steam generator pressure
Pc = 0.008; % [MPa] the condenser pressure
J = 8500; % [kg-m^2] the turbine and generator shaft inertial
eta = 0.85; % the turbine efficiency
Ndes = 3600; % [rpm] the turbine generator shaft speed set point
Pt0 = 819; % [MW] the turbine initial power
Pg0 = 819; % [MW] the generator initial power
C_vsg0 = 1; % the steam valve initial opening
ksg = 79.32; % [kg/(s-MPa)] steam valve coefficient
hsg = XSteam('hV_p', P_sg * 10); % [kJ/kg] steam generator vapor specific enthalpy
