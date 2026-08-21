%%
clc
clear all
close all

%% 1. Funções e gráficos 2D

t = 0:0.1:10;
senoide = 2*sin(3*t);
cossenoide = 2*cos(3*t);

figure;
plot(t,senoide,t,cossenoide)

xlabel('Tempo (s)')
ylabel('Amplitude')

title('Senoide e Cossenoide')

legend('Senoide','Cossenoide')

grid on

fprintf('Quantidade de elementos do vetor de tempo: %d\n', length(t));

%% 2. Entrada de dados, condição e gráfico

a = input('Digite o valor do coeficiente a: ');

if a > 0
    fprintf('O coeficiente a é positivo.\n');
elseif a < 0
    fprintf('O coeficiente a é negativo.\n');
else
    fprintf('O coeficiente a é igual a zero.\n');
end

x = -10:0.1:10;
y = a*x + 2;

figure
plot(x,y,'b','LineWidth',1.5)

grid on
xlabel('x')
ylabel('y')
title('Funcao y = ax + 2')

axes('Position',[0.6 0.5 0.3 0.3])

box on

plot(x,y,'r','LineWidth',1.5)

grid on

xlim([-2 2])

%% 3. Repetição e organização de gráficos

multiplos = zeros(1,5);

for i = 1:5
    multiplos(i) = 3*i;
end

figure

subplot(2,1,1)
plot(multiplos)
xlabel('Posicao')
ylabel('Valor')
title('Cinco primeiros multiplos de 3')
grid on

dobro = 2*multiplos;

subplot(2,1,2)
plot(dobro)
xlabel('Posicao')
ylabel('Valor')
title('Dobro dos multiplos de 3')
grid on

%% 4. Comparação de escalas

t = 0.1:0.1:1000;
y = 50000*exp(-0.05*t);

figure

subplot(2,1,1)
plot(t,y)
grid on
xlabel('Tempo (s)')
ylabel('Amplitude')
title('Escala normal')

subplot(2,1,2)
semilogy(t,y)
grid on
xlabel('Tempo (s)')
ylabel('Amplitude')
title('Escala logaritmica em Y')

%% 5. Gráficos 3D

[x,y] = meshgrid(1:0.5:10,1:20);
z = sin(x) + cos(y);

figure

subplot(2,1,1)
surf(x,y,z)

colormap("summer")
shading interp

xlabel('x')
ylabel('y')
zlabel('z')
title('Superficie z = sen(x) + cos(y)')

subplot(2,1,2)
contour(x,y,z,5)

xlabel('x')
ylabel('y')
title('Curvas de nivel')

grid on