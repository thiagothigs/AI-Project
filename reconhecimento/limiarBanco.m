clc
clear all
close all

%% Limiar de valores

% Valores com velocidade abaixo de 10^-3 serão desconsiderados, uma vez que
% não estão contribuindo para as informações do Fluxo Óptico aumentando
% então a probabilidade de haver mais erros na extração das
% características.

load dadosRedeNeural

for i=1:20
    for j=1:10
        %for k=1:10 % Frames
            bancoNovo = dadosRedeNeural{i,j};
            bancoNovo(bancoNovo < 10^-3) = 0;
            dadosRedeNeural{i,j} = bancoNovo;
        %end
    end
end

save dadosRedeNeural dadosRedeNeural