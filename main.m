% Código Principal

% Chama todas as funções!
% Calcula Fluxo Óptico
% Cria Banco de Dados
% Limiariza as imagens
% Normaliza todos os Frames
% Calcula PCA
% Realiza o Reconhecimento de Padrões

clc
clear all
close all

addpath('criaVideo', 'opticalFlow', 'roi', 'pca', 'reconhecimento');

% 1. Detecta o rosto
% 2. Identifica características faciais para rastrear
% 3. Rastreia região da boca

%% Chamando função detecção da região de interesse - ROI (Detecta BOCA)

fprintf('Detecção da Boca...\n');
ROI();

%% Nome dos arquivos que serão carregados
namefile = [{'zero_'}, {'um_'},{'dois_'},{'tres_'},{'quatro_'}, {'cinco_'},...
    {'seis_'}, {'sete_'}, {'oito_'}, {'nove_'}];

load box;
box = box';


fprintf('Cálculo do Fluxo Óptico...\n');
for k=1:10 % Coluna
    for j=1:20 % Linha
         
        % Adaptação para leitura automática dos Vídeos
        videos = strcat(char(namefile(k)),num2str(j),'.mp4');
        % Ler TODOS os vídeos
        videoReader = vision.VideoFileReader(videos);
        % Padronização: Converte e dimensiona imagem de entrada para determinado tipo de dados de saída;
        hidtc = vision.ImageDataTypeConverter;
        %% Criando Vídeo Player
        videoPlayer = vision.VideoPlayer;
        
        %% Lendo primeiro frame
        videoFrame = step(videoReader);
        
        %% Cria e inicializa Tracker (perseguidor)
        % detecta pontos para track
        bbox = box{k,j};
        fprintf('Áudio: %g \tGravação: %g\n',k-1,j);
             
        %% Loop através do vídeo
        ite = 1;
        while ~isDone(videoReader)
            %% obter o próximo frame
            videoFrame = step(videoReader); % quadros do vídeo
            im_frames = step(hidtc, videoFrame);
            imagem{ite} = imcrop(im_frames,bbox);
            ite = ite + 1;
        end
        
        save 'newImage.mat' imagem
        
        %% Release video reader e writer
        release(videoPlayer);
        release(videoReader);
        delete(videoPlayer); % delete will cause the viewer to close
        
        %% Criando vídeo somente com a região de interesse (ROI) - Boca
        criaNovoVideo();
        
        %% Visualizando Matriz de Fluxo Óptico
        %uxv_LK = calcula_OF_LucasKanade(); % Neste caso concluiu-se que é o método mais robusto
        uxv_HS = calcula_OF_HornShunck();
        % visualiza_matrizOF(uxv_LK);
        
        % Armazena vetores de áudios em uma matriz de células
        
        bancoImagens{j,k} = imagem;
        bancoDados_FO{j,k} = uxv_HS;
        
    end
    %k + k + 1; % até 10, pois são 10 números diferentes
end

save bancoDados_FO bancoDados_FO

%% Limiarizando o BANCO DE DADOS

% Aqui todas as velocidades calculadas, via Optical Flow, passaram por uma
% função de  limiarização, onde valores abaixo de 10^-3, não foram
% considerados como velocidades estáticas, ou seja, sem movimentos!

fprintf('Limiarização do Banco de Dados...\n');
limiarBanco();

%% Normalizando Banco de Dados

% Deixa todos os frames do mesmo tamanho [mxn]
fprintf('Normalização do Banco de Dados...\n');
normalizaBanco();

%% Extração das Características Principais - PCA
fprintf('Extraindo PCA...\n');
extraiPCA();

%% Preparação dos dados de TESTE e TREINAMENTO da Rede Neural
fprintf('Preparando dados TESTE e TREINAMENTO...\n')
preparaDados();

%% Reconhecimento - ANN

fprintf('Pressione uma TECLA para continuar...\n')
pause();

analise_reconhecimento
