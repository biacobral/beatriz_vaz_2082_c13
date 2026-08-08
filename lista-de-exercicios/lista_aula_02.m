%%
clc;
clear all;
close all;

%% 1
cidade = input("Digite o nome de uma cidade: ", 's')
fprintf('Cidade escolhida: %s\n', cidade);

%% 2
x = 7
if x > 10
    disp("Maior que 10")
elseif x==10
    disp("Igual a 10")
else 
    disp("Menor que 10")
end

%% 3
for i = 1:1:5
        result = i * 3
end

%% 4
x = 0;
i = 0;

while i < 5
    x = x + 1
    i = i + 1;
end

%% 5.a
opcao = 2;

switch opcao
    case 1
        disp("Opção A");
    case 2
        disp("Opção B");
    case 3
        disp("Opção C"); 
    otherwise
        disp("Opção inválida");
end 

%% 5.b
funcao_triplo(6)