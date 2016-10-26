% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert høsten 2006 av Jostein Bakkeheim
% Oppdatert høsten 2008 av Arnfinn Aas Eielsen
% Oppdatert høsten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring

clear all;
close all;
clc;

%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;

%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]

%%%%%%%%%%% From 1.4
V_s = 7;
K_f = -(g*(m_c*l_c-2*m_p*l_h))/(V_s*l_h);
 
%%%%%%%%%%% From 2.1
w_0 = 2.5;

L_1 = K_f*l_p; 
L_2 = g*(m_c*l_c-2*m_p*l_h);
L_3 = K_f*l_h;
L_4 = -L_3;

J_p = 2*m_p*(l_p)^2;
J_e = m_c*(l_c)^2 + 2*m_p*(l_h)^2;
J_y = m_c*(l_c)^2 + 2*m_p*((l_h)^2+(l_p)^2);

K_1 = L_1/J_p;
K_2 = L_3/J_e;
K_3 = L_4*V_s/J_y;

%%%%%%%%%%% Regulator paramaters - Method 1 - w0 og critical damping
Kpp = (w_0)^2/K_1;
Kpd = 2*sqrt(K_1*Kpp)/K_1;
Krp = -1;

h=tf(K_1*Kpp,[1,K_1*Kpd,K_1*Kpp]);
h_l=tf(K_3*Krp,[1,K_3*Krp]);

step(h_l);
