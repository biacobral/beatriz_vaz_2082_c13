clc;
clear all;
close all;
%% 1. Sistema massa–atrito e comparação gráfica — Caixa Branca

M1 = 2;
B1 = 3;

num1 = 1;
den1 = [M1 B1];

G1 = tf(num1, den1);

M2 = 4;
B2 = 6;

num2 = 1;
den2 = [M2 B2];

G2 = tf(num2, den2);

G1
G2

figure

step(G1,20)
hold on

step(G2,20)

plot([0 0 20],[0 1 1],"r--","LineWidth",1)

grid on

xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Comparacao dos sistemas massa-atrito")
legend("Sistema 1","Sistema 2","Forca aplicada","Location","southeast")

hold off

figure

subplot(2,1,1)
step(G1,20)
grid on
xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema massa-atrito 1")

subplot(2,1,2)
step(G2,20)
grid on
xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema massa-atrito 2")

figure

step(G1,20)
hold on
step(G2,20)

plot([0 0 20],[0 1 1],"r--","LineWidth",1)

grid on

xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Comparacao dos sistemas massa-atrito")
legend("Sistema 1","Sistema 2","Forca aplicada","Location","southeast")

axes('Position',[0.55 0.55 0.3 0.3])

box on

step(G1,5)
hold on
step(G2,5)

grid on

xlim([0 5])

hold off

%% 2. Circuito RC e comparação de escalas — Caixa Cinza

R = 2000;
tau = 2.5;

C = tau/R;

fprintf("Valor da capacitancia C = %.5f F\n",C);

num = 1;
den = [R*C 1];

G1 = tf(num,den);

G1

figure
step(G1,15)

grid on
xlabel("Tempo (s)")
ylabel("Tensao de saida (V)")
title("Circuito RC - Caixa cinza")

Rteste = 100:100:10000;

tauteste = Rteste*C;

figure

subplot(2,2,1)
plot(Rteste,tauteste)
grid on
xlabel("Resistencia (Ohm)")
ylabel("Constante de tempo (s)")
title("Escala normal")

subplot(2,2,2)
semilogy(Rteste,tauteste)
grid on
xlabel("Resistencia (Ohm)")
ylabel("Constante de tempo (s)")
title("Escala logaritmica em Y")

subplot(2,2,3)
semilogx(Rteste,tauteste)
grid on
xlabel("Resistencia (Ohm)")
ylabel("Constante de tempo (s)")
title("Escala logaritmica em X")

subplot(2,2,4)
loglog(Rteste,tauteste)
grid on
xlabel("Resistencia (Ohm)")
ylabel("Constante de tempo (s)")
title("Escala logaritmica em X e Y")

%% 3. Identificação e visualização de dados experimentais — Caixa Preta

t = (0:25)';

u = [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

y = [0.008 0.012 0.006 0.010 0.020 0.382 0.671 0.903 1.082 1.226 1.335 1.425 ...
    1.492 1.547 1.587 1.618 1.642 1.660 1.674 1.684 1.692 1.698 1.702 1.706 1.709 ...
    1.711]';

figure

subplot(2,1,1)
plot(t,u)
grid on
xlabel("Tempo (s)")
ylabel("Entrada")
title("Entrada experimental")

subplot(2,1,2)
plot(t,y)
grid on
xlabel("Tempo (s)")
ylabel("Saida")
title("Saida experimental")

figure

plot3(t,u,y)

grid on

xlabel("Tempo (s)")
ylabel("Entrada")
zlabel("Saida")
title("Dados experimentais")

Ts = 1;

dados = iddata(y,u,Ts);

G = tfest(dados,1,0);

G

figure
compare(dados,G)

figure
step(G,25)

grid on

xlabel("Tempo (s)")
ylabel("Saida")
title("Resposta ao degrau - Modelo identificado")

%% 4. Análise de diferentes circuitos RC — Caixa Cinza

R1 = 1000;
tau1 = 1.2;

R2 = 2000;
tau2 = 2.8;

R3 = 3000;
tau3 = 3.9;

R4 = 5000;
tau4 = 7.0;

C1 = tau1/R1;
C2 = tau2/R2;
C3 = tau3/R3;
C4 = tau4/R4;

fprintf("C1 = %.4f F\n",C1);
fprintf("C2 = %.4f F\n",C2);
fprintf("C3 = %.4f F\n",C3);
fprintf("C4 = %.4f F\n",C4);

R = [R1 R2 R3 R4];
tau = [tau1 tau2 tau3 tau4];
C = [C1 C2 C3 C4];

figure

plot3(R,tau,C,'o-','LineWidth',1.5)

grid on

xlabel("Resistencia (Ohm)")
ylabel("Constante de tempo (s)")
zlabel("Capacitancia (F)")
title("Experimentos com circuitos RC")

R = R3;
tau = tau3;
C = C3;

num = 1;
den = [R*C 1];

G3 = tf(num,den);

G3

figure

step(G3,20)

grid on

xlabel("Tempo (s)")
ylabel("Tensao de saida (V)")
title("Circuito RC - Experimento 3")

axes('Position',[0.55 0.55 0.3 0.3])

box on

step(G3,20)

grid on

xlim([0 5])

%% 5. Análise completa de três tipos de modelagem

M = 3;
B = 5;

numA = 1;
denA = [M B];

GA = tf(numA,denA);

R = 1500;
tau = 3;

C = tau/R;

numB = 1;
denB = [R*C 1];

GB = tf(numB,denB);

t = (0:20)';

u = [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';

y = [0.010 0.006 0.012 0.018 0.408 0.706 0.934 1.103 1.229 1.322 1.391 1.441 ...
1.479 1.505 1.526 1.540 1.551 1.558 1.564 1.568 1.571]';

Ts = 1;

dados = iddata(y,u,Ts);

GC = tfest(dados,1,0);

GA

fprintf("Capacitancia do Sistema B = %.4f F\n",C);

GB

GC

figure

subplot(3,1,1)
step(GA,20)
grid on
xlabel("Tempo (s)")
ylabel("Velocidade (m/s)")
title("Sistema A - Caixa Branca")

subplot(3,1,2)
step(GB,20)
grid on
xlabel("Tempo (s)")
ylabel("Tensao (V)")
title("Sistema B - Caixa Cinza")

subplot(3,1,3)
step(GC,20)
grid on
xlabel("Tempo (s)")
ylabel("Saida")
title("Sistema C - Caixa Preta")

figure

subplot(2,1,1)
plot(t,u)
grid on
xlabel("Tempo (s)")
ylabel("Entrada")
title("Entrada - Sistema C")

subplot(2,1,2)
plot(t,y)
grid on
xlabel("Tempo (s)")
ylabel("Saida")
title("Saida - Sistema C")

figure
compare(dados,GC)


%% Classificacao dos sistemas

% Sistema A e caixa branca porque o modelo matematico do sistema e conhecido.

% Sistema B e caixa cinza porque parte do modelo e conhecida e um parametro
% foi obtido a partir de um dado experimental.

% Sistema C e caixa preta porque o modelo e desconhecido e foi obtido
% diretamente a partir dos dados experimentais.