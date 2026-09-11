%%
clc;
clear all;
close all;

%% 1. Identificação de um sistema de primeira ordem a partir de um ensaio

% G(s) = K/(Ts + 1) -> Forma padrao
% Valor final = 1,8
% 63% do valor final em 1,2 s -> T = 1,2 s

% Parametros do sistema
K = 1.8;
T = 1.2;

% Funcao de transferencia
G = tf(K, [T 1]);

% Polo do sistema
pole(G)

% Tempo de subida
tr = 2.2*T;

% Tempo de acomodacao
ts = 4*T;

% Ganho em regime permanente
ganho = K;

fprintf("Tempo de subida = %.2f s\n",tr);
fprintf("Tempo de acomodacao = %.2f s\n",ts);
fprintf("Ganho em regime permanente = %.2f\n",ganho);

% Resposta ao degrau unitario
figure
step(G,8), grid
title("Resposta ao degrau unitario - Sistema de primeira ordem")
xlabel("Tempo (s)")
ylabel("Amplitude")

% Degrau de amplitude 2,5:

% Nova amplitude de entrada
amplitude = 2.5;

% Novo valor final
valor_final = K*amplitude;

fprintf("Novo valor final para degrau de amplitude 2,5 = %.2f\n",valor_final);

% Resposta ao degrau de amplitude 2,5
figure
step(amplitude*G,8), grid
title("Resposta ao degrau de amplitude 2,5")
xlabel("Tempo (s)")
ylabel("Amplitude")

% A constante de tempo T determina a rapidez da resposta:
% quanto menor T, mais rapida e a resposta.

% O polo esta relacionado com T por p = -1/T:
% quanto mais distante da origem, mais rapida e a resposta.

%% 2. Escolha entre três sistemas de segunda ordem

% Sistema A
num_A = 25;
den_A = [1 3 25];
G_A = tf(num_A, den_A);

% Sistema B
num_B = 25;
den_B = [1 10 25];
G_B = tf(num_B, den_B);

% Sistema C
num_C = 25;
den_C = [1 16 25];
G_C = tf(num_C, den_C);

% Polos dos sistemas

pole(G_A)
pole(G_B)
pole(G_C)

% Frequencia natural e coeficiente de amortecimento

% G(s) = wn^2/(s^2 + 2*zeta*wn*s + wn^2)

wn_A = sqrt(25);
zeta_A = 3/(2*wn_A);

wn_B = sqrt(25);
zeta_B = 10/(2*wn_B);

wn_C = sqrt(25);
zeta_C = 16/(2*wn_C);

fprintf("Sistema A: wn = %.2f rad/s, zeta = %.2f\n",wn_A,zeta_A);
fprintf("Sistema B: wn = %.2f rad/s, zeta = %.2f\n",wn_B,zeta_B);
fprintf("Sistema C: wn = %.2f rad/s, zeta = %.2f\n",wn_C,zeta_C);

% Tipo de resposta quanto ao amortecimento:

% Sistema A: subamortecido
% Sistema B: criticamente amortecido
% Sistema C: superamortecido

% Ganho em regime permanente

ganho_A = dcgain(G_A)
ganho_B = dcgain(G_B)
ganho_C = dcgain(G_C)

% Informacoes das respostas ao degrau

info_A = stepinfo(G_A);
info_B = stepinfo(G_B);
info_C = stepinfo(G_C);

tempo_subida_A = info_A.RiseTime
tempo_subida_B = info_B.RiseTime
tempo_subida_C = info_C.RiseTime

tempo_acomodacao_A = info_A.SettlingTime
tempo_acomodacao_B = info_B.SettlingTime
tempo_acomodacao_C = info_C.SettlingTime

sobressinal_A = info_A.Overshoot
sobressinal_B = info_B.Overshoot
sobressinal_C = info_C.Overshoot

% Resposta ao degrau dos tres sistemas

figure
step(G_A,G_B,G_C,8)
grid on
title("Resposta ao degrau - Sistemas de segunda ordem")
xlabel("Tempo (s)")
ylabel("Amplitude")
legend("Sistema A","Sistema B","Sistema C")

% Posicao dos polos

figure
pzmap(G_A,G_B,G_C)
grid on
title("Posicao dos polos dos sistemas")

% O Sistema B e o mais adequado, pois nao apresenta sobressinal
% e possui a resposta mais rapida entre os sistemas sem sobressinal.

%% 3. Avaliação de desempenho de dois sistemas de segunda ordem

% Sistema 1
G_1 = tf(16, [1 2.8 16]);

% Sistema 2
G_2 = tf(25, [1 6.5 25]);

% Vetor de tempo
t = 0:0.001:8;

% Resposta ao degrau

figure
step(G_1, t)
hold on
step(G_2, t)
grid on
title("Resposta ao degrau - Sistemas de segunda ordem")
xlabel("Tempo (s)")
ylabel("Amplitude")
legend("Sistema 1","Sistema 2")
hold off

% Valor final

valor_final_1 = dcgain(G_1)
valor_final_2 = dcgain(G_2)

% Frequencia natural, coeficiente de amortecimento e polos

[wn_1, zeta_1, polos_1] = damp(G_1);
[wn_2, zeta_2, polos_2] = damp(G_2);

wn_1(1)
zeta_1(1)
polos_1

wn_2(1)
zeta_2(1)
polos_2

% Caracteristicas da resposta ao degrau

% Sistema 1
[y_1, t_1] = step(G_1, t);
valor_final_1 = dcgain(G_1);

% Tempo de atraso: instante em que a resposta
% atinge 50% do valor final
indice_atraso_1 = find(y_1 >= 0.5*valor_final_1, 1);
td_1 = t_1(indice_atraso_1);

% Configuracoes utilizadas pelo stepinfo
limites_subida = [0 1];
tolerancia_acomodacao = 0.02;

info_1 = stepinfo(y_1, t_1, valor_final_1, ...
    'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

td_1
info_1.RiseTime
info_1.PeakTime
info_1.Peak
info_1.Overshoot
info_1.SettlingTime

% Caracteristicas da resposta - Sistema 2

[y_2, t_2] = step(G_2, t);
valor_final_2 = dcgain(G_2);

% Tempo de atraso: instante em que a resposta
% atinge 50% do valor final
indice_atraso_2 = find(y_2 >= 0.5*valor_final_2, 1);
td_2 = t_2(indice_atraso_2);

info_2 = stepinfo(y_2, t_2, valor_final_2, ...
    'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

td_2
info_2.RiseTime
info_2.PeakTime
info_2.Peak
info_2.Overshoot
info_2.SettlingTime

% Comparacao dos sistemas

fprintf("Sistema 1:\n");
fprintf("Valor final = %.2f\n",valor_final_1);
fprintf("Tempo de atraso = %.3f s\n",td_1);
fprintf("Tempo de subida = %.3f s\n",info_1.RiseTime);
fprintf("Tempo de pico = %.3f s\n",info_1.PeakTime);
fprintf("Primeiro pico = %.3f\n",info_1.Peak);
fprintf("Sobressinal = %.2f %%\n",info_1.Overshoot);
fprintf("Tempo de acomodacao = %.3f s\n",info_1.SettlingTime);
fprintf("Frequencia natural = %.2f rad/s\n",wn_1(1));
fprintf("Coeficiente de amortecimento = %.2f\n",zeta_1(1));

fprintf("\nSistema 2:\n");
fprintf("Valor final = %.2f\n",valor_final_2);
fprintf("Tempo de atraso = %.3f s\n",td_2);
fprintf("Tempo de subida = %.3f s\n",info_2.RiseTime);
fprintf("Tempo de pico = %.3f s\n",info_2.PeakTime);
fprintf("Primeiro pico = %.3f\n",info_2.Peak);
fprintf("Sobressinal = %.2f %%\n",info_2.Overshoot);
fprintf("Tempo de acomodacao = %.3f s\n",info_2.SettlingTime);
fprintf("Frequencia natural = %.2f rad/s\n",wn_2(1));
fprintf("Coeficiente de amortecimento = %.2f\n",zeta_2(1));

% Analise dos requisitos:

% Requisitos:
% Sobressinal < 10%
% Tempo de acomodacao < 1,5 s

% Sistema 1 nao atende aos requisitos.
% Sistema 2 atende aos dois requisitos.

% O Sistema 1 apresenta maior oscilacao e maior sobressinal,
% alem de possuir um tempo de acomodacao maior.

% O Sistema 2 possui menor sobressinal e acomoda mais rapidamente,
% sendo o sistema escolhido para a aplicacao.

%% 4. Seleção de parâmetros para um sistema de segunda ordem

% Configuracoes dos sistemas de segunda ordem

% G(s) = wn^2/(s^2 + 2*zeta*wn*s + wn^2)

% Configuracao A
zeta_A = 0.35;
wn_A = 6;
G_A = tf(wn_A^2, [1 2*zeta_A*wn_A wn_A^2]);

% Configuracao B
zeta_B = 0.55;
wn_B = 5;
G_B = tf(wn_B^2, [1 2*zeta_B*wn_B wn_B^2]);

% Configuracao C
zeta_C = 0.70;
wn_C = 4;
G_C = tf(wn_C^2, [1 2*zeta_C*wn_C wn_C^2]);

% Configuracao D
zeta_D = 0.80;
wn_D = 3.2;
G_D = tf(wn_D^2, [1 2*zeta_D*wn_D wn_D^2]);

% Polos dos sistemas

pole(G_A)
pole(G_B)
pole(G_C)
pole(G_D)

% Informacoes das respostas ao degrau:

% Configuracoes utilizadas pelo stepinfo
limites_subida = [0 1];
tolerancia_acomodacao = 0.02;

info_A = stepinfo(G_A, ...
    'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

info_B = stepinfo(G_B, ...
    'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

info_C = stepinfo(G_C, ...
    'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

info_D = stepinfo(G_D, ...
    'RiseTimeLimits', limites_subida, ...
    'SettlingTimeThreshold', tolerancia_acomodacao);

% Caracteristicas dos sistemas:

% Sistema A
fprintf("Sistema A\n");
fprintf("Sobressinal = %.2f %%\n",info_A.Overshoot);
fprintf("Tempo de subida = %.3f s\n",info_A.RiseTime);
fprintf("Tempo de pico = %.3f s\n",info_A.PeakTime);
fprintf("Tempo de acomodacao = %.3f s\n",info_A.SettlingTime);
fprintf("Valor final = %.2f\n",dcgain(G_A));

% Sistema B
fprintf("\nSistema B\n");
fprintf("Sobressinal = %.2f %%\n",info_B.Overshoot);
fprintf("Tempo de subida = %.3f s\n",info_B.RiseTime);
fprintf("Tempo de pico = %.3f s\n",info_B.PeakTime);
fprintf("Tempo de acomodacao = %.3f s\n",info_B.SettlingTime);
fprintf("Valor final = %.2f\n",dcgain(G_B));

% Sistema C
fprintf("\nSistema C\n");
fprintf("Sobressinal = %.2f %%\n",info_C.Overshoot);
fprintf("Tempo de subida = %.3f s\n",info_C.RiseTime);
fprintf("Tempo de pico = %.3f s\n",info_C.PeakTime);
fprintf("Tempo de acomodacao = %.3f s\n",info_C.SettlingTime);
fprintf("Valor final = %.2f\n",dcgain(G_C));

% Sistema D
fprintf("\nSistema D\n");
fprintf("Sobressinal = %.2f %%\n",info_D.Overshoot);
fprintf("Tempo de subida = %.3f s\n",info_D.RiseTime);
fprintf("Tempo de pico = %.3f s\n",info_D.PeakTime);
fprintf("Tempo de acomodacao = %.3f s\n",info_D.SettlingTime);
fprintf("Valor final = %.2f\n",dcgain(G_D));

% Resposta ao degrau

t = 0:0.001:8;

figure
step(G_A,t)
hold on
step(G_B,t)
step(G_C,t)
step(G_D,t)
grid on
title("Resposta ao degrau - Quatro configuracoes")
xlabel("Tempo (s)")
ylabel("Amplitude")
legend("Configuracao A","Configuracao B","Configuracao C","Configuracao D")
hold off

% Analise dos requisitos:

% Requisitos:
% Sobressinal < 10%
% Tempo de acomodacao < 1,5 s

% A configuracao A possui sobressinal maior que 10%,
% portanto nao atende aos requisitos.

% A configuracao B possui sobressinal menor que 10%,
% mas o tempo de acomodacao e maior que 1,5 s.

% A configuracao C atende aos dois requisitos.

% A configuracao D atende aos dois requisitos.

% Entre as configuracoes validas, a configuracao C possui
% o menor tempo de subida e foi escolhida.

% No grafico, a configuracao C apresenta uma resposta mais rapida
% que a configuracao D, mantendo o sobressinal dentro do limite.

% A configuracao D tambem atende aos requisitos, mas sua resposta
% e mais lenta devido ao menor valor de wn.

%% 5. Comparação entre sistemas de primeira e segunda ordem

% Equipamentos:

% Equipamento A - Sistema de primeira ordem
G_A = tf(2, [1.2 1]);

% Equipamento B - Sistema de segunda ordem
G_B = tf(32, [1 5.6 16]);

% Vetor de tempo
t = 0:0.001:8;

% Polos

pole(G_A)
pole(G_B)

% Ganho em regime permanente

ganho_A = dcgain(G_A)
ganho_B = dcgain(G_B)

% Resposta ao degrau unitario

[y_A, t_A] = step(G_A,t);
[y_B, t_B] = step(G_B,t);

valor_final_A = dcgain(G_A);
valor_final_B = dcgain(G_B);

% Tempo de subida

% Sistema A - primeira ordem
info_A = stepinfo(y_A,t_A,valor_final_A, ...
    'RiseTimeLimits',[0 1], ...
    'SettlingTimeThreshold',0.02);

% Sistema B - segunda ordem
info_B = stepinfo(y_B,t_B,valor_final_B, ...
    'RiseTimeLimits',[0 1], ...
    'SettlingTimeThreshold',0.02);

tempo_subida_A = info_A.RiseTime
tempo_subida_B = info_B.RiseTime

% Tempo de acomodacao

tempo_acomodacao_A = info_A.SettlingTime
tempo_acomodacao_B = info_B.SettlingTime

% Caracteristicas do Equipamento B:

[wn_B, zeta_B, polos_B] = damp(G_B);

wn_B(1)
zeta_B(1)
polos_B

tempo_pico_B = info_B.PeakTime
primeiro_pico_B = info_B.Peak
sobressinal_B = info_B.Overshoot

% Resposta ao degrau unitario

figure
step(G_A,t)
hold on
step(G_B,t)
grid on
title("Comparacao entre os equipamentos")
xlabel("Tempo (s)")
ylabel("Amplitude")
legend("Equipamento A","Equipamento B")
hold off

% Degrau de amplitude 1,5

amplitude = 1.5;

% Valores finais
valor_final_A_15 = amplitude*dcgain(G_A)
valor_final_B_15 = amplitude*dcgain(G_B)

% Resposta ao degrau de amplitude 1,5

figure
step(amplitude*G_A,t)
hold on
step(amplitude*G_B,t)
grid on
title("Comparacao para degrau de amplitude 1,5")
xlabel("Tempo (s)")
ylabel("Amplitude")
legend("Equipamento A","Equipamento B")
hold off

% Comparacao final

% O Equipamento A apresenta uma resposta mais rapida inicialmente,
% enquanto o Equipamento B apresenta um comportamento oscilatorio.

% O Equipamento A nao possui sobressinal, enquanto o Equipamento B
% possui sobressinal devido ao seu amortecimento menor que 1.

% Os dois equipamentos possuem o mesmo ganho em regime permanente,
% portanto atingem o mesmo valor final para uma mesma entrada.