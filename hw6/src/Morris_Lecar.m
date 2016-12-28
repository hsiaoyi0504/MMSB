%file morris_lecar.m
%Morris-Lecar model of excitable barnacle muscle fiber
%adapted from Morris and Lecar (1981) Biophysical Journal 35 pp. 193-231
%Figures 8.6 and 8.7

function morris_lecar
close all
%declare model parameters
global C;
global gbarCa;
global ECa;
global gbarK;
global EK;
global gleak;
global Eleak;
global v1;
global v2;
global v3;
global v4;
global phi;
global tau;
global flag;
global Iapplied;

%assign parameter values
C= 20 ; %microfarad/cm^2 
gbarCa=4.4; % millisiemens/ cm^2 
ECa=120; %millivolts
gbarK=8;% millisiemens/ cm^2 
EK=-84; %millivolts
gleak=2;% millisiemens/ cm^2 
Eleak=-60;%millivolts
v1=-1.2; %millivolts
v2= 18 ; %millivolts
v3= 2 ; %millivolts
v4= 30; %millivolts
phi = 0.04; % per millisecond
tau=0.8;

Iapplied=0;

%set simulation parameters
OPTIONS = odeset('RelTol',1e-9,'AbsTol',1e-9, 'refine',5, 'MaxStep', 1);
ODEFUN=@morris_lecar_ddt;
Tend=200;

%set initial conditions (state=(V,w))
%rest:
S00=[-60.8554    0.0149];

flag = 0;
[t1,S1]=ode15s(ODEFUN, [0 100], S00);
fig = figure;
plot(t1, S1(:,1));
xlabel('Time (msec)');
ylabel('Voltage (mV)');
title('V(t)');
axis([0 100 -80 40]);
saveas(fig,'../img/2.a.v.jpg');
fig = figure();
plot(t1, S1(:,2));
xlabel('Time (msec)');
ylabel('Voltage (mV)');
title('w(t)');
axis([0 100 0 1]);
saveas(fig,'../img/2.a.w.jpg');

fig = figure;
plot(t1, S1(:,1));
xlabel('Time (msec)');
ylabel('Voltage (mV)');
title('V(t)');
saveas(fig,'../img/2.a.v-l.jpg');
fig = figure;
plot(t1, S1(:,2));
xlabel('Time (msec)');
ylabel('Voltage (mV)');
title('w(t)');
saveas(fig,'../img/2.a.w-l.jpg');

flag = 1;
[t1,S1]=ode15s(ODEFUN, [0 200], S00);
fig = figure;
plot(t1, S1(:,1));
xlabel('Time (msec)');
ylabel('Voltage (mV)');
title('V(t)');
saveas(fig,'../img/2.b.v.jpg');
fig = figure;
plot(t1, S1(:,2));
xlabel('Time (msec)');
ylabel('Voltage (mV)');
title('w(t)');
axis([0 200 0 1]);
saveas(fig,'../img/2.b.w.jpg');

flag = 2;
[t1,S1]=ode15s(ODEFUN, [0 300], S00);
fig = figure;
plot(t1, S1(:,1));
xlabel('Time (msec)');
ylabel('Voltage (mV)');
title('V(t)');
saveas(fig,'../img/2.c.v.jpg');
fig = figure;
plot(t1, S1(:,2));
title('w(t)');
xlabel('Time (msec)');
ylabel('Voltage (mV)');
axis([0 300 0 1]);
saveas(fig,'../img/2.c.w.jpg');

flag = 3;
[t1,S1]=ode15s(ODEFUN, [0 300], S00);
fig = figure;
plot(t1, S1(:,1));
xlabel('Time (msec)');
ylabel('Voltage (mV)');
title('V(t)');
saveas(fig,'../img/2.d.v.jpg');
fig = figure;
plot(t1, S1(:,2));
xlabel('Time (msec)');
ylabel('Voltage (mV)');
title('w(t)');
axis([ 0 300 0 1]);
saveas(fig,'../img/2.d.w.jpg');

flag = 4;
[t1,S1]=ode15s(ODEFUN, [0 300], S00);
fig = figure;
plot(t1, S1(:,1));
title('V(t)');
xlabel('Time (msec)');
ylabel('Voltage (mV)');
saveas(fig,'../img/2.e.v.jpg');
fig = figure;
plot(t1, S1(:,2));
title('w(t)');
xlabel('Time (msec)');
ylabel('Voltage (mV)');
axis([ 0 300 0 1]);
saveas(fig,'../img/2.e.w.jpg');

end

%dynamics
function dS = morris_lecar_ddt(t,S)

global C;
global gbarCa;
global ECa;
global gbarK;
global EK;
global gleak;
global Eleak;
global v1;
global v2;
global v3;
global v4;
global phi;
global tau;
global Iapplied;
global flag;

if flag == 1
    if t>= 100 && t<=110
        Iapplied = 150;
    else
        Iapplied = 0;
    end
elseif flag > 1
    if flag == 2
        tsep = 100;
    elseif flag == 3
        tsep = 60;
    elseif flag == 4
        tsep = 30;
    else
        tsep = 100;
    end
    if (t>= 100 && t<=110) || (t>=110+tsep && t<=110+tsep+10)
        Iapplied = 150;
    else
        Iapplied = 0;
    end
else
    Iapplied = 0;
end

%locally define state variables:
V=S(1);
w=S(2);

%local functions:
m_inf = (0.5*(1+tanh((V-v1)/v2)));
w_inf = (0.5*(1+tanh((V-v3)/v4)));

ddt_V = (1/C)*(gbarCa*m_inf*(ECa-V) + gbarK*w*(EK-V) + gleak*(Eleak-V)+Iapplied);
ddt_w = phi*(w_inf-w)/(tau);

dS=[ddt_V; ddt_w];

end

%change properties of last curve in current figure
%Examples:
%     setcurve('color','red')
%     setcurve('color','green','linestyle','--')
%Type  help plot  to see available colors and line styles 
function setcurve(varargin)
h=get(gca,'children');
set(h(1),varargin{:})
end
 
