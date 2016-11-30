function hw4()
    clc;
    close all;
    IC = [ 2 1 0 ];
    k = [ 1 1 ];
    [N,T] = SSA(IC,k);
    fig = figure;
    stairs(T,N(:,1),'r');
    hold on;
    stairs(T,N(:,2),'g');
    stairs(T,N(:,3),'b');
    axis([ 0 10 0 3 ]);
    xlabel('Time (arbitrary unit)');
    ylabel('Number of Molecules');
    legend('A','B','C');
    saveas(fig,'../img/c.1.jpg');

    IC = [ 10 5 0 ];
    k = [ 1 1/5 ];
    [N,T] = SSA(IC,k);
    fig = figure;
    stairs(T,N(:,1),'r');
    hold on;
    stairs(T,N(:,2),'g');
    stairs(T,N(:,3),'b');
    axis([ 0 10 0 15 ]);
    xlabel('Time (arbitrary unit)');
    ylabel('Number of Molecules');
    legend('A','B','C');
    saveas(fig,'../img/c.2.jpg');

    IC = [ 100 50 0 ];
    k = [ 1 1/50 ];
    [N,T] = SSA(IC,k);
    fig = figure;
    stairs(T,N(:,1),'r');
    hold on;
    stairs(T,N(:,2),'g');
    stairs(T,N(:,3),'b');
    xlabel('Time (arbitrary unit)');
    ylabel('Number of Molecules');
    axis([ 0 10 0 150 ]);
    legend('A','B','C');
    saveas(fig,'../img/c.3.jpg'); 
    
    IC = [ 2 1 0 ];
    k = [ 1 1 ];
    fig = ensemble(IC,k,3);
    saveas(fig,'../img/d.1.jpg');
    fig = ensemble(IC,k,10);
    saveas(fig,'../img/d.2.jpg');
    fig = ensemble(IC,k,100);
    saveas(fig,'../img/d.3.jpg');
    
    tspan = [0 10];
    y0 = [ 2; 1; 0;];
    [t,y] = ode45(@ODE_e,tspan,y0);
    fig = figure;
    plot(t,y(:,1),'r');
    hold on;
    plot(t,y(:,2),'g');
    plot(t,y(:,3),'b');
    xlabel('Time (s)');
    ylabel('Concentration (mM)');
    axis([ 0 10 0 3]);
    legend('A','B','C');
    saveas(fig,'../img/e.jpg');


end

function fig = ensemble(IC,k,n)
    fig = figure;
    [N,T] = SSA(IC,k);
    ax1 = subplot(3,1,1);
    hold on;
    ax2 = subplot(3,1,2);
    hold on;
    ax3 = subplot(3,1,3);
    hold on;
    stairs(ax1,T,N(:,1),'Color',[0.5 0.5 0.5]);
    stairs(ax2,T,N(:,2),'Color',[0.5 0.5 0.5]);
    stairs(ax3,T,N(:,3),'Color',[0.5 0.5 0.5]);
    state(1)=interp1(T,N(:,1),10,'previous');
    N_T = N;
    for i = 1:n-1
        [N,T] = SSA(IC,k);
        stairs(ax1,T,N(:,1),'Color',[0.5 0.5 0.5]);
        stairs(ax2,T,N(:,2),'Color',[0.5 0.5 0.5]);
        stairs(ax3,T,N(:,3),'Color',[0.5 0.5 0.5]);
        state(n)=interp1(T,N(:,1),10,'previous');
        N_T = N_T + N;
    end
    N_T = N_T/n;
    stairs(ax1,T,N_T(:,1),'Color','black','LineWidth',5);
    stairs(ax2,T,N_T(:,2),'Color','black','LineWidth',5);
    stairs(ax3,T,N_T(:,3),'Color','black','LineWidth',5);
    title(ax1,'A');
    title(ax2,'B');
    title(ax3,'C');
    xlabel(ax1,'Time (arbitrary unit)');
    xlabel(ax2,'Time (arbitrary unit)');
    ylabel(ax2,'Number of Molecules');
    xlabel(ax3,'Time (arbitrary unit)');
    axis([ ax1 ax2 ax3 ],[ 0 10 0 3 ]);
    C = categorical(state,[0 1 2],{'(0,3,2)','(1,2,1)','(2,1,0)'});
    [N,Categories] = histcounts(C);
    N
    Categories
end

function [N,T]= SSA(IC,k)
    A = IC(1);
    B = IC(2);
    C = IC(3);
    k1 = k(1);
    km1 = k(2);
    t = 0;
    Tend = 10000;
    T(1) = 0;
    N(1,:) = [ A B C];
    for j = 2:Tend
        a1 = k1 * A;
        am1 = km1 * B *C;
        asum = a1 + am1;
        % update time
        t = t + log(1/rand(1))/asum;
        % state transition
        mu = rand(1);
        if mu < a1/asum
            if A - 1 >= 0
                B = B + 1;
                C = C + 1;
                A = A - 1;
            end
        else  %  a1/asum  <=  mu < 1
            if C - 1 >= 0 && B -1 >= 0
                A = A + 1;
                B = B - 1;
                C = C - 1;
            end
        end
        T(j) = t;
        N(j,:) = [A B C];
    end
end

function dydt = ODE_e(t,y)
    k1 = 1;
    km1 = 1;
    dydt(1,1) = - k1 * y(1) + km1 * y(2) * y(3);
    dydt(2,1) = k1 * y(1) - km1 * y(2) * y(3);
    dydt(3,1) = k1 * y(1) - km1 * y(2) * y(3);
end
