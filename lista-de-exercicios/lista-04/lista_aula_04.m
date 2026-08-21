%%
clc
clear all
close all

%% 1. Sistema massa–mola–amortecedor — Caixa Branca

M = 2;
B = 3;
K = 8;

num = 1;

den = [M B K];

G1 = tf(num, den);

G1

figure
step(G1, 15)

grid on

xlabel("Tempo (s)")
ylabel("Deslocamento (m)")
title("Sistema massa-mola-amortecedor - Caixa branca")

%% 2. Circuito RC — Caixa Cinza

R = 1000;
tau = 2;
C = tau/R;

num = 1;
den = [R*C 1];

G1 = tf(num, den);

C
G1

figure
step(G1, 10)

grid on

xlabel("Tempo (s)")
ylabel("Tensao de saida (V)")
title("Circuito RC - Caixa cinza")

%% 3. Sistema massa–atrito — Caixa Cinza

M = 4;
F = 1;
v = 0.5;

B = F/v;

num = 1;
den = [M B];

G1 = tf(num, den);

B
G1

figure
step(G1)

grid on

xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema massa-atrito - Caixa cinza")