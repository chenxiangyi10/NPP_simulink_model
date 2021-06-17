function hc = hc(h_sg,  s_sg)
    hc = h_sg - eta * (h_sg - XSteam('h_ps', Pc*10, s_sg));
end