function hw1()
    close all
    tspan = [0 5];
    y0 = [1; 1; 1/2; 0; 0; 0;];
    [t,y] = ode45(@ODE1,tspan,y0);
    figure;
    plot(t, y(:,1), '-s', t, y(:,2), '-+', t, y(:,3), '-.', t, y(:,4), '-*', t, y(:,5), '-o',t,y(:,6), '-x');
    xlabel('Time (sec)');
    ylabel('Concentration (mM)');
    legend('A','B','C','D','E','F');
    figure;
end

function dydt = ODE1(t,y) % question 2.4.7 a) iii)
    k1 = 3;
    k2 = 1;
    k3 = 4;
    v1 = k1 * y(1) * y(2);
    v2 = k2 * y(4);
    v3 = k3 * y(3);
    dydt(1) =-v1; % dA/dt
    dydt(2) =-v1 + v2; % dB/dt
    dydt(3) = v1 - v3; % dC/dt
    dydt(4) = v1 - v2; % dD/dt
    dydt(5) = v3; % dE/dt
    dydt(6) = v3; % dF/dt
    dydt = dydt';
end

function dydt = ODE2(t,y) % question 2.4.7 b) iii)
    k0 = 0.5;
    k1 = 3;
    k2 = 1;
    k3 = 4;
    k4 = 1;
    k5 = 1;
    v0 = k0;
    v1 = k1 * y(1) * y(2);
    v2 = k2 * y(4);
    v3 = k3 * y(3);
    v4 = k4 * y(4);
    v5 = k5 * y(5);
    dydt(1) = v0 - v1; % dA/dt
    dydt(2) =-v1 + v2; % dB/dt
    dydt(3) = v1 - v3; % dC/dt
    dydt(4) = v1 - v2; % dD/dt
    dydt(5) = v3 - v4; % dE/dt
    dydt(6) = v3 - v5; % dF/dt
    dydt = dydt';
end


