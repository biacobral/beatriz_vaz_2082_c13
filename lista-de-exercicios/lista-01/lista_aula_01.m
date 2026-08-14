%%
clc
clear all
close all
%% 1
a = 12
b = 5

soma = a + b
sub = a - b
mult = a * b
div = a / b
expon = a^b

%% 2
raiz = sqrt(144)
arr = round(7.6)
arr2 = ceil(4.01)
resto = rem(250,17)

%% 3
mdc = gcd(24, 36)
mmc = lcm(12, 18)

%% 4
expo = exp(2)
sen = sin(pi/6)
coss = cos(pi/3)
tang = tan(pi/4)

%% 5
vet1 = 1:10
vet2 = 10:-1:1
vet3 = 0:2:20
vet4 = linspace(1,100,5)

%% 6
v = [4 8 15 16 23 42]
v(1)
v(end)
v(2:5) % posicoes de 2 a 4, como é exclusivo mostrar de 2 a 5
v([1, 3, 6])

%% 7
v = [5 10 15 20 25]
len = length(v)
dim = size(v)
soma_vetor = sum(v)
media_vetor = mean(v)
maior = max(v)
menor = min(v)

%% 8
v = [10 20 30 40]
size(v)
v = v'
size(v)

%% 9
a = [3 6 9; 2 4 8; 1 5 7]
a(2, 3)
a(1,:)
a(:, 2)
size(a)

%% 10
A = [1 2; 3 4]
B = [2 0; 1 5]

A + B
A * B
A'

zeros(3, 3)
ones(2, 4)
eye(4)
rand(3)