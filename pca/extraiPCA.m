% UNIVERSIDADE FEDERAL DE SÃO JOÃO DEL REI
% THIAGO VINÍCIUS DANTAS FERRAZ
% TRABALHO DE CONCLUSÃO DE CURSO
% RECONHECIMENTO DE FALA UTILIZANDO OPTICAL FLOW, PCA E REDES NEURAIS

% ESTE CÓDIGO REALIZA:
% EXTRAÇÃO DAS COMPONENTES PRINCIPAIS
% CRIAÇÃO NOVA MATRIZ DENOMINADA DADOS DE ENTRADA (SERÁ LANÇADA NA REDE
% NEURAL)

function [] = extraiPCA()

% Carregando o Banco de Dados. Este banco contém as matrizes de fluxo
% óptico relativo a cada vídeo gravado dos algarimos "0" a "9".
load dataBase.mat; % armazenado na variável bancoDados_FO

% p é coluna
% q é linha
for p=1:10 % 10 corresponde ao número de algarismos - 0 a 9
    for q=1:20 % 20 corresponde ao número de gravações de cada algarimo
        palavra = dataBase{q,p}; % banco de dados principal (conjunto de células)
        
        % Extração dos Parâmetros Principais - PCA
        
        for i=1:10 % 10 corresnponde ao números de frames que serão percorridos
            [coef, score, latent, ~,percVAR,~] = pca(abs(palavra{1,i}')); % número de colunas deve ser menor que linhas
            coeficientes{i} = coef; % coeficientes, parâmetros principais
            coeffs{q,p} = coeficientes;
            % Linhas de X correspondem a observações e Colunas correspondem
            % às variáveis. A matriz dos coeficientes é p x p.
            percentual{i} = percVAR; % percentual da variância para cada frame
            percents{q,p} = percentual;
            %latencia{i} = latent;
            %latents{q,p} = latencia;
        end
        
        % Ajuste da nova matriz: Os coeficientes de um vídeo estão divididos
        % em 10 frames neste caso. Logo foi extraído o PCA de todos estes
        % frames. Visando manter coerência no trabalho, as duas primeiras
        % colunas (que possui maior % de variância) de cada frame do vídeo
        % foram colocadas em uma nova matriz. A intenção é formar os dados
        % de entrada para a Rede Neural.
        
        dataInput = [];
        dataPer = [];
        for ii = 1:10
            dataInput = [dataInput, coeficientes{1,ii}(:,1)];
            % dataInput é a matriz com os parâmetros principais de todos os
            % frames, ou seja, a concatenação das duas primeiras colunas de
            % cada frame.
            % 33x20
            % Nova matriz de células
            dadosRedeNeural{q,p} = dataInput;
            
            dataPer = [dataPer, percentual{1,ii}(1)]; % variância de cada matriz frame
            % Guardando dentro de uma nova matriz de células
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

% Próximo passo: Preparação dos dados para Rede Neural FeedForward

end