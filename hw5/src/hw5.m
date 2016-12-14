function hw5()
    clc
    close all;
    %% question 2 b
    A = [-1.2 0; 48 -2;];
    B = [10; 0;];
    C = [0 1];
    D = 0;
    [num den] = ss2tf(A,B,C,D);
    sys = tf(num,den);
    fig = figure;
    bode(sys);
    saveas(fig,'../img/2.b.jpg');
    A = [-3 0; 48 -2;];
    [num den] = ss2tf(A,B,C,D);
    sys = tf(num,den);
    fig = figure;
    bode(sys);
    saveas(fig,'../img/2.c.jpg');
end
