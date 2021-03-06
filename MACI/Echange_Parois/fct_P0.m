function [ P0etPlage,T0etPlage ] = fct_P0( cond_init, ths )
%FCT_P0 Summary of this function goes here
%   Detailed explanation goes here
    
    options = odeset('Mass', 'M(t,y)', 'RelTol', 1e-3, ...
                     'AbsTol', [1e2, 1e-1, 1e-7, 1e-7, 1e-7, 1e-2, 1e-7]);
    
    % Initialisation
    y0 = [cond_init.P0, cond_init.T0, cond_init.m0, ...
          cond_init.mu0, cond_init.mb0, cond_init.f0, ...
          cond_init.mcapa0];
    [theta, M] = ode45('systemeFunction1', 0:1:720, y0, options);
    while true
        % Sauvegarde
        M_prev = M;
        % It�ration
        y0 = M(end, :);
        [theta, M] = ode45('systemeFunction1', 0:1:720, y0, options);
        % V�rification de satisfaction du crit�re d'arr�t
        if ths > (max(M_prev(:,5)) - max(M(:,5)))
            break;
        end
    end
    P0etPlage.theta=theta;
    P0etPlage.pression=M(:,1);
    T0etPlage.theta=theta;
    T0etPlage.temperature=M(:,2);
end

