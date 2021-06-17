function dNdt = dNdt(P_g, P_t, N)
    dNdt = (60 / (2*pi))^2 * (P_t - P_g) / (J*N);
end