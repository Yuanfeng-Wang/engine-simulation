function [ dQ ] = fct_echange_chaleur( h_c, y, theta )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    global d_alesage Vm d_piston Dadm Dech ign tps_comb N

    %surfaces
    %1=culasse
    %2=chemise
    %3=piston
    %4=soupape d'admission
    %5=soupape d'�chappement
    
    T_parois = zeros (1,5);
    T_parois(1) = 450;
    T_parois(2) = 478;
    T_parois(3) = 629;
    T_parois(4) = 418;
    T_parois(5) = 842;
    s = zeros (1,5);
    S = zeros (1,5);
    [V] = fct_volume(theta);
    Vb = y(6) * V;
    Vu = (1-y(6)) * V;


    
    s(1) = pi * d_alesage / 2 * sqrt((d_alesage/2)^2 + ...
        (12 * Vm / (pi * d_alesage))^2);
    s(3) = d_piston ^ 2 * pi / 4;
    s(4) = Dadm ^ 2 * pi / 4;
    s(5) = Dech ^ 2 * pi / 4;

    if (mod(theta, 720)>=0 && mod(theta, 720)<=(ign+tps_comb))
        for i = 1:5
           S(i) = Vu / V * s(i);
        end 
        S(2) = 4 * V / d_alesage; % je pense que ce n'est pas V mais Vu
        % consid�rant que les gaz en contact avec la paroi sont des gaz 
        % frais
    else
        for i = 1:5
            S(i) = Vb / V * s(i);
        end
        S(2) = 4 * V / d_alesage; % je pense que ce n'est pas V mais Vb
        
        % consid�rant que les gaz en contact avec la paroi ne sont que des 
        % gaz br�l�s
    end
    
    dQ = 1 / (6 * N) * sum(h_c * (T_parois - y(2)).* S);
    
end

