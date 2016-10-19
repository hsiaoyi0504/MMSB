function hw1()
    close all;
    
    tspan = [0 10];
    t_window = 1:10;
    
    % question 2.4.7 a) iii) 
    y0 = [ 1; 1; 1/2; 0; 0; 0;];
    [t,y] = ode45(@ODE1,tspan,y0);
    fig = figure;
    plot(t, y(:,1), '-s', t, y(:,2), '-+', t, y(:,3), '-.', t, y(:,4), '-*', t, y(:,5), '-o',t,y(:,6), '-x');
    xlabel('Time (sec)');
    ylabel('Concentration (mM)');
    legend('A','B','C','D','E','F');
    saveas(fig,'../img/2.4.7.a.iii.jpg');
    
    % question 2.4.7 b) iii)
    y0 = [ 1; 1; 1/2; 0; 0; 0;];
    [t,y] = ode45(@ODE2,tspan,y0);
    fig = figure;
    plot(t, y(:,1), '-s', t, y(:,2), '-+', t, y(:,3), '-.', t, y(:,4), '-*', t, y(:,5), '-o',t,y(:,6), '-x');
    xlabel('Time (sec)');
    ylabel('Concentration (mM)');
    legend('A','B','C','D','E','F');
    saveas(fig,'../img/2.4.7.b.iii.jpg');
    
    % question 2.4.7 b) iv)
    y0 = [ 1; 1; 1/2; 0; 0; 0;];
    [t,y] = ode45(@ODE3,tspan,y0);
    fig = figure;
    plot(t, y(:,1), '-s', t, y(:,2), '-+', t, y(:,3), '-.', t, y(:,4), '-*', t, y(:,5), '-o',t,y(:,6), '-x');
    xlabel('Time (sec)');
    ylabel('Concentration (mM)');
    legend('A','B','C','D','E','F');
    saveas(fig,'../img/2.4.7.b.iv.jpg');
    
    tspan = [0 100];

    % question 2.4.8 a) and c)
    y0 = [ 1.5; 3; 2;];
    [t,y] = ode45(@ODE4,tspan,y0);
    y0 = [ 1.5; 5;];
    [t_reduce,y_reduce] = ode45(@ODE5,tspan,y0);
    % transient
    fig = figure;
    hold on;
    k2 = 0.7;
    km2 = 0.4;
    y_reduce(:,3) = y_reduce(:,2) * k2  / ( k2 + km2 );
    y_reduce(:,2) = y_reduce(:,2) * km2 / ( k2 + km2 );
    plot(t, y(:,1), '-s', t, y(:,2), '-+', t, y(:,3), '-.')
    plot(t_reduce, y_reduce(:,1), '-*', t_reduce, y_reduce(:,2), '-o', t_reduce, y_reduce(:,3), '-x')
    axis([0,6,0,4]);
    xlabel('Time (sec)');
    ylabel('Concentration (mM)');
    title('Transient-state');
    legend('A (original model)','B (original model)','C (original model)', ...
        'A (reduced model)','B (reduced model)','C (reduced model)');
    saveas(fig,'../img/2.4.8.a.transient.jpg');
    % steady-state
    fig = figure;
    hold on;
    plot(t, y(:,1), '-s', t, y(:,2), '-+', t, y(:,3), '-.')
    plot(t_reduce, y_reduce(:,1), '-*', t_reduce, y_reduce(:,2), '-o', t_reduce, y_reduce(:,3), '-x')
    xlabel('Time (sec)');
    ylabel('Concentration (mM)');
    title('Steady-state');
    legend('A','B','C');
    saveas(fig,'../img/2.4.8.a.steady.jpg');
   
    % question 2.4.9 a) and c)
    y0 = [ 6; 0;];
    [t,y] = ode45(@ODE6,tspan,y0);
    k1 = 11;
    km1 = 8;
    y0 = [ 6*km1/(k1+km1); 0;];
    [t_reduce,y_reduce] = ode45(@ODE7,tspan,y0);
    y_reduce(:,2) = k1 / km1 * y_reduce(:,1);
    % transient
    fig = figure;
    hold on;
    plot(t, y(:,1), '-s', t, y(:,2), '-+');
    plot(t_reduce, y_reduce(:,1), '-*', t_reduce, y_reduce(:,2), '-o');
    axis([0,40,0,7]);
    xlabel('Time (sec)');
    ylabel('Concentration (mM)');
    title('Transient-state');
    legend('A (original model)','B (original model)','A (reduced model)','B (reduced model)');
    saveas(fig,'../img/2.4.9.transient.jpg');
    % steady state
    fig = figure;
    hold on;
    plot(t, y(:,1), '-s', t, y(:,2), '-+');
    plot(t_reduce, y_reduce(:,1), '-*', t_reduce, y_reduce(:,2), '-o');
    xlabel('Time (sec)');
    axis([40,100,0,7]);
    ylabel('Concentration (mM)');
    title('Steady-state');
    legend('A (original model)','B (original model)','A (reduced model)','B (reduced model)');
    saveas(fig,'../img/2.4.9.steady.jpg');
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
    k5 = 5;
    v0 = k0;
    v1 = k1 * y(1) * y(2);
    v2 = k2 * y(4);
    v3 = k3 * y(3);
    v4 = k4 * y(5);
    v5 = k5 * y(6);
    dydt(1) = v0 - v1; % dA/dt
    dydt(2) =-v1 + v2; % dB/dt
    dydt(3) = v1 - v3; % dC/dt
    dydt(4) = v1 - v2; % dD/dt
    dydt(5) = v3 - v4; % dE/dt
    dydt(6) = v3 - v5; % dF/dt
    dydt = dydt';
end

function dydt = ODE3(t,y) % question 2.4.7 b) iv)
    k0 = 5;
    k1 = 3;
    k2 = 1;
    k3 = 4;
    k4 = 1;
    k5 = 5;
    v0 = k0;
    v1 = k1 * y(1) * y(2);
    v2 = k2 * y(4);
    v3 = k3 * y(3);
    v4 = k4 * y(5);
    v5 = k5 * y(6);
    dydt(1) = v0 - v1; % dA/dt
    dydt(2) =-v1 + v2; % dB/dt
    dydt(3) = v1 - v3; % dC/dt
    dydt(4) = v1 - v2; % dD/dt
    dydt(5) = v3 - v4; % dE/dt
    dydt(6) = v3 - v5; % dF/dt
    dydt = dydt';
end

function dydt = ODE4(t,y) % question 2.4.8 a)
    k1 = 0.05;
    k2 = 0.7;
    km1 = 0.005;
    km2 = 0.4;
    dydt(1) =-k1 * y(1) + km1 * y(2); % dA/dt
    dydt(2) = k1 * y(1) - km1 * y(2) - k2 * y(2) + km2 * y(3); % dB/dt
    dydt(3) = k2 * y(2) - km2 * y(3); % dC/dt
    dydt = dydt';
end

function dydt = ODE5(t,y) % question 2.4.8 c)
    k1 = 0.05;
    k2 = 0.7;
    km1 = 0.005;
    km2 = 0.4;
    dydt(1) =-k1 * y(1) + km1 * km2 / ( k2 + km2 ) * y(2); % dA/dt
    dydt(2) = k1 * y(1) - km1 * km2 / ( k2 + km2 ) * y(2); % dD/dt
    dydt = dydt';

end

function dydt = ODE6(t,y) % question 2.4.9 a)
    k0 = 1;
    k1 = 11;
    km1 = 8;
    k2 = 0.2;
    dydt(1) = k0 - k2 * y(1) - k1 * y(1) + km1 * y(2); % dA/dt
    dydt(2) = k1 * y(1) - km1 * y(2); % dB/dt
    dydt = dydt';
end

function dydt = ODE7(t,y) % question 2.4.9 c)
    k0 = 1;
    k1 = 11;
    km1 = 8;
    k2 = 0.2;
    dydt(1) = k0 -  k2  * y(1); % dA/dt
    dydt(2) = 0;
    dydt = dydt';
end
