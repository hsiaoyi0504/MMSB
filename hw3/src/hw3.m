function hw3()
    clc;
    close all;

    tspan = [0 200];

    % question 4.8.6 a)
    y0 = [ 1; 70; 50; 4; ];
    [t1,y1] = ode45(@ODE_4_8_6_a,tspan,y0);
    y0 = [ 1; 0; 115; 4; ];
    [t2,y2] = ode45(@ODE_4_8_6_a,tspan,y0);
    fig = figure;
    plot(y1(:,2),y1(:,3),'b');
    hold on;
    plot(y2(:,2),y2(:,3),'g');
    s1 = linspace(1,70,20);
    s2 = linspace(1,140,20);
    [x,y] = meshgrid(s1,s2);
    u = zeros(size(x));
    v = zeros(size(y));
    t = 0;
    for i = 1:numel(x)
        Yprime = ODE_4_8_6_a(t,[1; x(i); y(i); 4;]);
        u(i) = Yprime(2);
        v(i) = Yprime(3);
        Vmod = sqrt(u(i)^2 + v(i)^2);
        u(i) = u(i)/Vmod;
        v(i) = v(i)/Vmod;
    end
    quiver(x,y,u,v,'r');
    axis([ 0 70 0 120 ]); 
    xlabel('X Concentration (arbitrary unit)');
    ylabel('Y Concentration (arbitrary unit)');
    saveas(fig,'../img/4.8.6.a.jpg');
    
    % question 4.8.6 b)
    tspan = [ 0 1000 ];
    y0 = [ 1; 8; 3; 4; ];
    [t1,y1] = ode45(@ODE_4_8_6_b,tspan,y0);
    y0 = [ 1; 0; 10; 4; ];
    [t2,y2] = ode45(@ODE_4_8_6_b,tspan,y0);
    fig = figure;
    plot(y1(:,2),y1(:,3),'b');
    hold on;
    plot(y2(:,2),y2(:,3),'g');
    s1 = linspace(0.5,8,15);
    s2 = linspace(0.5,12,15);
    [x,y] = meshgrid(s1,s2);
    u = zeros(size(x));
    v = zeros(size(y));
    t = 0;
    for i = 1:numel(x)
        Yprime = ODE_4_8_6_b(t,[1; x(i); y(i); 4;]);
        u(i) = Yprime(2);
        v(i) = Yprime(3);
        Vmod = sqrt(u(i)^2 + v(i)^2);
        u(i) = u(i)/Vmod;
        v(i) = v(i)/Vmod;
    end
    quiver(x,y,u,v,'r');
    axis([ 0 8 0 12 ]); 
    xlabel('X Concentration (arbitrary unit)');
    ylabel('Y Concentration (arbitrary unit)');
    saveas(fig,'../img/4.8.6.b.jpg');
error();

    % question 4.8.8 b)
    tspan = [0 30];
    y0 = 2.1;
    [t1,y1] = ode45(@ODE_4_8_8_origin,tspan,y0);
    [t2,y2] = ode45(@ODE_4_8_8_approx,tspan,y0); 

    y0 = 3;
    [t3,y3] = ode45(@ODE_4_8_8_origin,tspan,y0);
    [t4,y4] = ode45(@ODE_4_8_8_approx,tspan,y0);
    
    y0 = 12;
    [t5,y5] = ode45(@ODE_4_8_8_origin,tspan,y0);
    [t6,y6] = ode45(@ODE_4_8_8_approx,tspan,y0);
    
    fig = figure;
    plot(t1, y1, 'r', t2, y2, 'r-.');
    hold on;
    plot(t3, y3, 'g', t4, y4, 'g-.');
    plot(t5, y5, 'b', t6, y6, 'b-.');
    xlabel('Time (arbitrary unit)');
    ylabel('Concentration (arbitrary unit)');
    legend('S (original model, initial condition s=2.1)','S (approximated model, initial condition s=2.1)', ...
    'S (original model, initial condition s=3)','S (approximated model, initial condition s=3)',...
    'S (original model, initial condition s=12)','S (approximated model, initial condition s=12)');
    axis([tspan 0 Inf])
    saveas(fig,'../img/4.8.8.b.jpg');
end

function dydt = ODE_4_8_6_a(t,y) % question 4.8.6 a) v)
    k1 = 0.4;
    k2 = 0.2;
    k3 = 0.1;
    dydt(1,1) = 0; %dA/dt
    dydt(2,1) = k1 * y(1) * y(2) - k2 * y(2) * y(2); %dX/dt
    dydt(3,1) = k2 * y(2) * y(2) - k3 * y(3); %dY/dt
    dydt(4,1) = 0; %dB/dt
end

function dydt = ODE_4_8_6_b(t,y) % question 4.8.6 b) v)
    k1 = 0.4;
    k2 = 0.3;
    k3 = 0.1;
    dydt(1,1) = 0; %dA/dt
    dydt(2,1) = k1 * y(1) * y(2) - k2 * y(2) * y(3); %dX/dt
    dydt(3,1) = k2 * y(2) * y(3) - k3 * y(3); %dY/dt
    dydt(4,1) = 0; %dB/dt
end

function dydt = ODE_4_8_8_origin(t,y) % original model for question 4.8.8 b)
    V0 = 2;
    V_max = 3;
    K_M = 1;
    dydt(1) = V0 - V_max * y(1) / ( K_M + y(1) );
end

function dydt = ODE_4_8_8_approx(t,y) % approximated model for question 4.8.8 b)
    V0 = 2;
    V_max = 3;
    K_M = 1;
    dydt(1) = - V_max / K_M / ( 1 + V0 / ( V_max - V0 ) )^2 * ( y(1) - K_M * V0 / ( V_max - V0 ) );
end

