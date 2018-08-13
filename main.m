% C�digo Principal

% Chama todas as fun��es!
% Calcula Fluxo �ptico
% Cria Banco de Dados
% Limiariza as imagens
% Normaliza todos os Frames
% Calcula PCA
% Realiza o Reconhecimento de Padr�es

clc
clear all
close all

addpath('criaVideo', 'opticalFlow', 'roi', 'pca', 'reconhecimento');

% 1. Detecta o rosto
% 2. Identifica caracter�sticas faciais para rastrear
% 3. Rastreia regi�o da boca

%% Chamando fun��o detec��o da regi�o de interesse - ROI (Detecta BOCA)

fprintf('Detec��o da Boca...\n');
ROI();

%% Nome dos arquivos que ser�o carregados
namefile = [{'zero_'}, {'um_'},{'dois_'},{'tres_'},{'quatro_'}, {'cinco_'},...
    {'seis_'}, {'sete_'}, {'oito_'}, {'nove_'}];

load box;
box = box';


fprintf('C�lculo do Fluxo �ptico...\n');
for k=1:10 % Coluna
    for j=1:20 % Linha
         
        % Adapta��o para leitura autom�tica dos V�deos
        videos = strcat(char(namefile(k)),num2str(j),'.mp4');
        % Ler TODOS os v�deos
        videoReader = vision.VideoFileReader(videos);
        % Padroniza��o: Converte e dimensiona imagem de entrada para determinado tipo de dados de sa�da;
        hidtc = vision.ImageDataTypeConverter;
        %% Criando V�deo Player
        videoPlayer = vision.VideoPlayer;
        
        %% Lendo primeiro frame
        videoFrame = step(videoReader);
        
        %% Cria e inicializa Tracker (perseguidor)
        % detecta pontos para track
        bbox = box{k,j};
        fprintf('�udio: %g \tGrava��o: %g\n',k-1,j);
             
        %% Loop atrav�s do v�deo
        ite = 1;
        while ~isDone(videoReader)
            %% obter o pr�ximo frame
            videoFrame = step(videoReader); % quadros do v�deo
            im_frames = step(hidtc, videoFrame);
            imagem{ite} = imcrop(im_frames,bbox);
            ite = ite + 1;
        end
        
        save 'newImage.mat' imagem
        
        %% Release video reader e writer
        release(videoPlayer);
        release(videoReader);
        delete(videoPlayer); % delete will cause the viewer to close
        
        %% Criando v�deo somente com a regi�o de interesse (ROI) - Boca
        criaNovoVideo();
        
        %% Visualizando Matriz de Fluxo �ptico
        %uxv_LK = calcula_OF_LucasKanade(); % Neste caso concluiu-se que � o m�todo mais robusto
        uxv_HS = calcula_OF_HornShunck();
        % visualiza_matrizOF(uxv_LK);
        
        % Armazena vetores de �udios em uma matriz de c�lulas
        
        bancoImagens{j,k} = imagem;
        bancoDados_FO{j,k} = uxv_HS;
        
    end
    %k + k + 1; % at� 10, pois s�o 10 n�meros diferentes
end

save bancoDados_FO bancoDados_FO

%% Limiarizando o BANCO DE DADOS

% Aqui todas as velocidades calculadas, via Optical Flow, passaram por uma
% fun��o de  limiariza��o, onde valores abaixo de 10^-3, n�o foram
% considerados como velocidades est�ticas, ou seja, sem movimentos!

fprintf('Limiariza��o do Banco de Dados...\n');
limiarBanco();

%% Normalizando Banco de Dados

% Deixa todos os frames do mesmo tamanho [mxn]
fprintf('Normaliza��o do Banco de Dados...\n');
normalizaBanco();

%% Extra��o das Caracter�sticas Principais - PCA
fprintf('Extraindo PCA...\n');
extraiPCA();

%% Prepara��o dos dados de TESTE e TREINAMENTO da Rede Neural
fprintf('Preparando dados TESTE e TREINAMENTO...\n')
preparaDados();

%% Reconhecimento - ANN

fprintf('Pressione uma TECLA para continuar...\n')
pause();

analise_reconhecimento
