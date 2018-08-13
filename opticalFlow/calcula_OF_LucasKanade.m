function [uxv_LK] = calcula_OF_LucasKanade()
% Realiza leitura de amostras de áudio e vídeo do arquivo de vídeo;
hvfr = vision.VideoFileReader('recorte_boca.avi', ...
    'ImageColorSpace', 'Intensity', ...
    'VideoOutputDataType', 'uint8');

% Padronização: Converte e dimensiona imagem de entrada para determinado
% tipo de dados de saída;
hidtc = vision.ImageDataTypeConverter;

% Retorna um objeto do Sistema de fluxo óptico, HOF, que estima a direção e
% velocidade do movimento do objeto de uma imagem para outra, ou de um
% quadro do vídeo para outro.
hof = vision.OpticalFlow('ReferenceFrameDelay', 1);
% Método de cálculo do Fluxo Óptico - Lucas Kanade (Ver Bibliografia)
hof.Method = 'Lucas-Kanade';
%hof.ImageSmoothingFilterStandardDeviation = 1.5;
hof.NoiseReductionThreshold = 0.0009;

% Threshold for noise reduction Specify the motion threshold between each
% image or video frame as a positive scalar number. The higher the number,
% the less small movements impact the optical flow calculation. This
% property applies when you set the Method property to Lucas-Kanade. This
% property is tunable. Default: 0.0039

% Especificação do formato da saída de velocidade.
% hof.OutputValue = 'Horizontal and vertical components in complex form'; % Especificação do formato da saída de velocidade.
hof.OutputValue = 'Magnitude-squared';

% Desenha retângulos, linhas, polígonos, ou círculos em imagens:

% HSHAPEINS = vision.ShapeInserter retorna um objeto do sistema, HSHAPEINS,
% que atrai vários retângulos, linhas, polígonos ou círculos em imagens,
% substituindo os valores de pixel.
hsi = vision.ShapeInserter('Shape','Lines', 'BorderColor','Custom', ...
    'CustomBorderColor', 255);

% Toca o vídeo ou imagem de exibição: retorna um objeto do sistema de
% exibição de vídeo, HVP, para visualizar sequências de vídeo ou de imagem
% na tela no MATLAB.
hvp = vision.VideoPlayer('Name', 'Motion Vector');

n=0; % Contagem número de quadros;
%ite=1;
while ~isDone(hvfr)%isDone: Indica se a operação está completa quando se trabalha com interface, ou seja, indica se o vídeo chegou ao final.
    
    frame = step(hvfr); % Quadros da imagem;
    %frame = step(imcrop(hvfr{n+1}, bbox));
    im = step(hidtc, frame); % converte a imagem para precisão ‘simples’.
    %imagem{ite} = imcrop(im,bbox);
    of = step(hof, im); % processa o fluxo óptico para o video.
    
    %If you select Magnitude-squared, the block outputs the optical flow
    %matrix where each element is of the form u^2 + v^2. If you select Horizontal
    %and vertical components in complex form, the block outputs the optical
    %flow matrix where each element is of the form u+j*v.
    
%    lines = videooptflowlines(of, 20); % Gera pontos de coordenada.
   % out   =  step(hsi, im, lines); % Desenha linhas para indicar fluxo.
    %step(hvp, out);                % Visualização do vídeo.
    
    n=n+1; % Número de quadros;
    uxv_LK{n} = of; % Matriz de fluxo óptico; SOMENTE COMP. VERTICAL
    %ite = ite + 1;
end

% save 'newImage.mat' imagem load('newImage.mat', imagem)

%release(hvp);%Libera a interface e todos os recursos utilizados pela
%interface; release(hvfr);%Libera a interface e todos os recursos
%utilizados pela interface;

end