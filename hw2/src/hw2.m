function hw2()
    clc;
    close all;

    tspan = [0 6];
    t_window = 1:10;
    
    % question 3.7.5
    y0 = [ 0.3; 0.2; 0.1;];
    [t1,y1] = ode45(@ODE_3_7_5_a,tspan,y0);
    [t2,y2] = ode45(@ODE_3_7_5_c,tspan,y0); 
    y0 = [ 6; 4; 4;];
    [t3,y3] = ode45(@ODE_3_7_5_a,tspan,y0);
    [t4,y4] = ode45(@ODE_3_7_5_c,tspan,y0);

    fig = figure;
    plot(t1, y1(:,1), 'r', t1, y1(:,2), 'g', t1, y1(:,3), 'b');
    hold on;
    xlabel('Time (min)');
    ylabel('Concentration (mM)');
    legend('S1','S2','S3');
    saveas(fig,'../img/3.7.5.a.1.jpg');
    plot(t2, y2(:,1), 'r-.', t2, y2(:,2), 'g-.', t2, y2(:,3), 'b-.');
    legend('S1 (original model)','S2 (original model)','S3 (original model)', ...
        'S1 (simple model)','S2 (simple model)','S3 (simple model)');
    saveas(fig,'../img/3.7.5.c.1.jpg');
    fig = figure;
    plot(t3, y3(:,1), 'r', t3, y3(:,2), 'g', t3, y3(:,3), 'b');
    hold on;
    xlabel('Time (min)');
    ylabel('Concentration (mM)');
    legend('S1','S2','S3'); 
    saveas(fig,'../img/3.7.5.a.2.jpg');  
    plot(t4, y4(:,1), 'r-.', t4, y4(:,2), 'g-.', t4, y4(:,3), 'b-.');
    legend('S1 (original model)','S2 (original model)','S3 (original model)', ...
        'S1 (simple model)','S2 (simple model)','S3 (simple model)');
    saveas(fig,'../img/3.7.5.c.2.jpg');
    axis([0,6,0,0.5]);
    saveas(fig,'../img/3.7.5.c.2_s.jpg');
end

function dydt = ODE_3_7_5_a(t,y) % question 3.7.5 a)
    V_max1 = 9;
    V_max2 = 12;
    V_max3 = 15;
    K_M1 = 1;
    K_M2 = 0.4;
    K_M3 = 3;
    v0 = 2;
    v1 = V_max1 * y(1) / ( K_M1 + y(1) );
    v2 = V_max2 * y(2) / ( K_M2 + y(2) );
    v3 = V_max3 * y(3) / ( K_M3 + y(3) );
    dydt(1) = v0 - v1; % dS1/dt
    dydt(2) = v1 - v2; % dS2/dt
    dydt(3) = v2 - v3; % dS3/dt
    dydt = dydt';
end

function dydt = ODE_3_7_5_c(t,y) % question 3.7.5 c)
    V_max1 = 9;
    V_max2 = 12;
    V_max3 = 15;
    K_M1 = 1;
    K_M2 = 0.4;
    K_M3 = 3;
    k1 = V_max1 / K_M1;
    k2 = V_max2 / K_M2;
    k3 = V_max3 / K_M3;
    v0 = 2;
    v1 = k1 * y(1);
    v2 = k2 * y(2);
    v3 = k3 * y(3);
    dydt(1) = v0 - v1; % dS1/dt
    dydt(2) = v1 - v2; % dS2/dt
    dydt(3) = v2 - v3; % dS3/dt
    dydt = dydt';
end
