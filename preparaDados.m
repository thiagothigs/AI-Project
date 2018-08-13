function [] = preparaDados()

% Prepara��o dos dados

% 1. Cria Matriz de Teste para Rede Neural - dadosTeste
% 2. Cria Matriz de Treino para Rede Neural - dadosTreino
clc
clear all
close all

load dadosRedeNeural

% for i=1:10 % Representa as palavras gravadas em �udio: zero, um, ..., dez.
%     for k=1:20
%         [tamanho(k),~]=size(dadosRedeNeural{k,i}); % Memoriza o tamanho do vetor da k-�sima grava��o da i-�sima palavra gravada.
%     end
%     tamanho_maximo(i)=max(tamanho');
% end

% maiorLinha = max(tamanho_maximo);

% oldMatrix = ones(42,52);  % The original matrix
% newMatrix = zeros(42,60); % The new matrix (with zeros)
% newMatrix(1:42, 1:52) = oldMatrix; % Overlap the original matrix in the new matrix

% for i=1:10 % Representa as palavras gravadas em �udio: zero, um, ..., dez.
%     for k=1:20 % Acessa a k-�sima grava��o de um determinado n�mero em �udio.
%         dados2 = dadosRedeNeural{k,i}; %Recuperando o arquivo no banco de dados.
%         %dados2 = dados2(:,1)./max(abs(dados2(:,1)));%Normaliza��o dos valores brutos entre -1 e 1.
%         [linhaAtual,coluna]=size(dadosRedeNeural{k,i});
%         line = maiorLinha-linhaAtual;
%         %dados2 = [dadosRedeNeural{k,i}; NaN(line,coluna)];
%         dados2 = [dadosRedeNeural{k,i}; zeros(line,coluna)];
%         dataInput{k,i} = dados2;
%     end
% end

% save dataInput dataInput % mesmo tamanho para todas as matrizes

% Tranforma Matriz para Vetor

for i=1:10 % Representa as palavras gravadas em �udio: zero, um, ..., dez.
    for k=1:20 % Acessa a k-�sima grava��o de um determinado n�mero em �udio.
        % dados = unique(reshape(dataInput{k,i},1,[]));
        dados = reshape(dadosRedeNeural{k,i},1,[]); % Concatena��o dos frames
        dataBaseANN{k,i} = dados;
    end
end

save dataBaseANN dataBaseANN % todos os frames em vetor

%% Dados Teste

for i=1:10 % Representa as palavras gravadas em �udio: zero, um, ..., dez.
    for k=1:10 % Acessa a k-�sima grava��o de um determinado n�mero em �udio.
        % dados = unique(reshape(dataInput{k,i},1,[]));
        dTeste = dataBaseANN{k,i};
        dadosTeste{k,i} = dTeste;
        dadosTesteNew = cat(1, dadosTeste(:));
    end
end

dadosTesteNew = cell2mat(dadosTesteNew);
dadosTesteNew = double(dadosTesteNew);

save dadosTeste dadosTeste
save dadosTesteNew dadosTesteNew

%% Dados Treinamento

for i=1:10 % Representa as palavras gravadas em �udio: zero, um, ..., dez.
    for k=11:20 % Acessa a k-�sima grava��o de um determinado n�mero em �udio.
        % dados = unique(reshape(dataInput{k,i},1,[]));
        dTreino = dataBaseANN{k,i};
        dadosTreino{k-10,i} = dTreino;
        dadosTreinoNew = cat(1, dadosTreino(:));
    end
end

dadosTreinoNew = cell2mat(dadosTreinoNew);
dadosTreinoNew = double(dadosTreinoNew);
save dadosTreino dadosTreino
save dadosTreinoNew dadosTreinoNew

%% Cria TARGET

target = criaTarget();
save target target

end