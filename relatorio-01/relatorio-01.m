%%
clc;
clear;
close all;

%% Exercício 1 - Análise de três medições

x = input('Digite a primeira medição: ');
y = input('Digite a segunda medição: ');
z = input('Digite a terceira medição: ');

vetor = [x y z]

media = mean(vetor)
maior = max(vetor)
menor = min(vetor)

if media >= 8
    classificacao = 'Resultado alto'
elseif media >= 5
    classificacao = 'Resultado intermediário'
else
    classificacao = 'Resultado baixo'
end

fprintf('Média: %.2f\n', media);

%% Exercício 2 – Processamento de um vetor com for

A = [3 8 2 10 5 7 1 6];
B = zeros(size(A));

for i = 1:1:length(A)
    if A(i) >= 6
        B(i) = 2 * A(i);
    else
        B(i) = A(i) + 3;
    end
end

A
B
somaB = sum(B)
mediaB = mean(B)
maiorB = max(B)
menorB = min(B)

%% Exercício 3 – Identificação de números pares em um vetor

A = [14 7 20 9 6 11 18 5];
B = zeros(size(A));

contador = 0;

for i = 1:1:length(A)
    if rem(A(i), 2) == 0
        B(i) = A(i);
        contador = contador + 1;
    else
        B(i) = 0;
    end
end

B
contador

%% Exercício 4 – Calculadora com menu usando switch

x = input('Digite o primeiro valor: ');
y = input('Digite o segundo valor: ');

fprintf('1 - Soma\n');
fprintf('2 - Subtração\n');
fprintf('3 - Multiplicação\n');
fprintf('4 - Divisão\n');
op = input('Escolha uma operação: ');

switch op
    case 1
        resultado = x + y;
        fprintf('Resultado da soma: %.2f\n', resultado);

    case 2
        resultado = x - y;
        fprintf('Resultado da subtração: %.2f\n', resultado);

    case 3
        resultado = x * y;
        fprintf('Resultado da multiplicação: %.2f\n', resultado);

    case 4
        if y == 0
            fprintf('A operação não pode ser realizada (divisão por zero).\n');
        else
            resultado = x / y;
            fprintf('Resultado da divisão: %.2f\n', resultado);
        end

    otherwise
        fprintf('Opção inválida.\n');
end

%% Exercício 5 – Acumulador com while

soma = 0;
contador = 0;

while soma <= 4
    valor = rand

    soma = soma + valor

    contador = contador + 1;

end

if contador > 8
   disp('Muitas repetições.');
else
    disp('Poucas repetições.');
end

contador

%% Exercício 6 – Processamento de uma matriz com dois laços for

A = [2 7 4 9 ; 6 1 8 3];
B = zeros(size(A));

for j = 1:1:size(A, 1)
    for i = 1:1:size(A, 2)
        if A(j, i) > 5
            B(j, i) = 2 * A(j, i);
        else
            B(j, i) = A(j, i) + 5;
        end
    end
end

A
B
B'
B(1, :)
B(:, 3)

%% Exercício 7 – Função com duas saídas para analisar um vetor

A = [5 12 7 3 9 14];

[soma, media] = analisa_vetor(A);

if media >= 8
    classificacao = 'Média elevada'
else
    classificacao = 'Média abaixo de 8'
end

fprintf('Soma dos elementos: %.2f\n', soma);
fprintf('Média dos elementos: %.2f\n', media);

%% Exercício 8 – Função para transformar uma matriz

A = [1 5 3 8; 6 2 7 4];
B = zeros(size(A));

B = transforma_matriz(A, B)
%% Exercício 9 – Entrada como texto e conversão numérica

x = input('Digite o primeiro valor: ', 's');
y = input('Digite o segundo valor: ', 's');

fprintf('\nTextos recebidos:\n');
disp(x);
disp(y);

x = str2num(x);
y = str2num(y);

soma = x + y
multiplicacao = x * y;

if soma > 20
    classificacao = 'Soma alta'
elseif soma == 20
    classificacao = 'Soma igual a 20'
else
    classificacao = 'Soma baixa'
end

%% Exercício 10 – Desafio integrador: análise de dados e escolha de gráfico

dados = [12 18 10 25 15];

soma = sum(dados)
media = mean(dados)
maior = max(dados)
menor = min(dados)

contador = 0

for i = 1:length(dados)
    if dados(i) >= media
        contador = contador + 1;
    end
end

fprintf('1 - Gráfico de barras\n');
fprintf('2 - Gráfico de pizza\n');

op = input('Escolha uma opção: ');

switch op
    case 1
        bar(dados);
        title('Gráfico de Barras dos Dados');

    case 2
        pie3(dados);
        title('Gráfico de Pizza dos Dados');

    otherwise
        warning('Nenhum gráfico foi criado.');
end

if contador > length(dados) / 2
    fprintf('Maioria dos valores acima ou igual à média.\n');
else
    fprintf('Menos da metade dos valores acima ou igual à média.\n');
end