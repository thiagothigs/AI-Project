% UNIVERSIDADE FEDERAL DE S�O JO�O DEL REI
% THIAGO VIN�CIUS DANTAS FERRAZ
% TRABALHO DE CONCLUS�O DE CURSO
% RECONHECIMENTO DE FALA UTILIZANDO OPTICAL FLOW, PCA E REDES NEURAIS

% ESTE C�DIGO REALIZA:
% EXTRA��O DAS COMPONENTES PRINCIPAIS
% CRIA��O NOVA MATRIZ DENOMINADA DADOS DE ENTRADA (SER� LAN�ADA NA REDE
% NEURAL)

function [] = extraiPCA()

% Carregando o Banco de Dados. Este banco cont�m as matrizes de fluxo
% �ptico relativo a cada v�deo gravado dos algarimos "0" a "9".
load dataBase.mat; % armazenado na vari�vel bancoDados_FO

% p � coluna
% q � linha
for p=1:10 % 10 corresponde ao n�mero de algarismos - 0 a 9
    for q=1:20 % 20 corresponde ao n�mero de grava��es de cada algarimo
        palavra = dataBase{q,p}; % banco de dados principal (conjunto de c�lulas)
        
        % Extra��o dos Par�metros Principais - PCA
        
        for i=1:10 % 10 corresnponde ao n�meros de frames que ser�o percorridos
            [coef, score, latent, ~,percVAR,~] = pca(abs(palavra{1,i}')); % n�mero de colunas deve ser menor que linhas
            coeficientes{i} = coef; % coeficientes, par�metros principais
            coeffs{q,p} = coeficientes;
            % Linhas de X correspondem a observa��es e Colunas correspondem
            % �s vari�veis. A matriz dos coeficientes � p x p.
            percentual{i} = percVAR; % percentual da vari�ncia para cada frame
            percents{q,p} = percentual;
            %latencia{i} = latent;
            %latents{q,p} = latencia;
        end
        
        % Ajuste da nova matriz: Os coeficientes de um v�deo est�o divididos
        % em 10 frames neste caso. Logo foi extra�do o PCA de todos estes
        % frames. Visando manter coer�ncia no trabalho, as duas primeiras
        % colunas (que possui maior % de vari�ncia) de cada frame do v�deo
        % foram colocadas em uma nova matriz. A inten��o � formar os dados
        % de entrada para a Rede Neural.
        
        dataInput = [];
        dataPer = [];
        for ii = 1:10
            dataInput = [dataInput, coeficientes{1,ii}(:,1)];
            % dataInput � a matriz com os par�metros principais de todos os
            % frames, ou seja, a concatena��o das duas primeiras colunas de
            % cada frame.
            % 33x20
            % Nova matriz de c�lulas
            dadosRedeNeural{q,p} = dataInput;
            
            dataPer = [dataPer, percentual{1,ii}(1)]; % vari�ncia de cada matriz frame
            % Guardando dentro de uma nova matriz de c�lulas
            dadosPercentual{q,p} = dataPer;
        end
        %mediaDadosRedeNeural = mean(dadosRedeNeural{q,p},1);
        %meanDadosRedeNeural{q,p} = mediaDadosRedeNeural;
    end
end

%save meanDadosRedeNeural meanDadosRedeNeural
save coeffs coeffs
save percents percents
save dadosRedeNeural dadosRedeNeural % Preparar para jogar na Rede Neural
save dadosPercentual dadosPercentual
clc % limpa workspace

% Pr�ximo passo: Prepara��o dos dados para Rede Neural FeedForward

end