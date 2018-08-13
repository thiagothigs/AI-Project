function [uxv_LK] = calcula_OF_LucasKanade()
% Realiza leitura de amostras de �udio e v�deo do arquivo de v�deo;
hvfr = vision.VideoFileReader('recorte_boca.avi', ...
    'ImageColorSpace', 'Intensity', ...
    'VideoOutputDataType', 'uint8');

% Padroniza��o: Converte e dimensiona imagem de entrada para determinado
% tipo de dados de sa�da;
hidtc = vision.ImageDataTypeConverter;

% Retorna um objeto do Sistema de fluxo �ptico, HOF, que estima a dire��o e
% velocidade do movimento do objeto de uma imagem para outra, ou de um
% quadro do v�deo para outro.
hof = vision.OpticalFlow('ReferenceFrameDelay', 1);
% M�todo de c�lculo do Fluxo �ptico - Lucas Kanade (Ver Bibliografia)
hof.Method = 'Lucas-Kanade';
%hof.ImageSmoothingFilterStandardDeviation = 1.5;
hof.NoiseReductionThreshold = 0.0009;

% Threshold for noise reduction Specify the motion threshold between each
% image or video frame as a positive scalar number. The higher the number,
% the less small movements impact the optical flow calculation. This
% property applies when you set the Method property to Lucas-Kanade. This
% property is tunable. Default: 0.0039

% Especifica��o do formato da sa�da de velocidade.
% hof.OutputValue = 'Horizontal and vertical components in complex form'; % Especifica��o do formato da sa�da de velocidade.
hof.OutputValue = 'Magnitude-squared';

% Desenha ret�ngulos, linhas, pol�gonos, ou c�rculos em imagens:

% HSHAPEINS = vision.ShapeInserter retorna um objeto do sistema, HSHAPEINS,
% que atrai v�rios ret�ngulos, linhas, pol�gonos ou c�rculos em imagens,
% substituindo os valores de pixel.
hsi = vision.ShapeInserter('Shape','Lines', 'BorderColor','Custom', ...
    'CustomBorderColor', 255);

% Toca o v�deo ou imagem de exibi��o: retorna um objeto do sistema de
% exibi��o de v�deo, HVP, para visualizar sequ�ncias de v�deo ou de imagem
% na tela no MATLAB.
hvp = vision.VideoPlayer('Name', 'Motion Vector');

n=0; % Contagem n�mero de quadros;
%ite=1;
while ~isDone(hvfr)%isDone: Indica se a opera��o est� completa quando se trabalha com interface, ou seja, indica se o v�deo chegou ao final.
    
    frame = step(hvfr); % Quadros da imagem;
    %frame = step(imcrop(hvfr{n+1}, bbox));
    im = step(hidtc, frame); % converte a imagem para precis�o �simples�.
    %imagem{ite} = imcrop(im,bbox);
    of = step(hof, im); % processa o fluxo �ptico para o video.
    
    %If you select Magnitude-squared, the block outputs the optical flow
    %matrix where each element is of the form u^2 + v^2. If you select Horizontal
    %and vertical components in complex form, the block outputs the optical
    %flow matrix where each element is of the form u+j*v.
    
%    lines = videooptflowlines(of, 20); % Gera pontos de coordenada.
   % out   =  step(hsi, im, lines); % Desenha linhas para indicar fluxo.
    %step(hvp, out);                % Visualiza��o do v�deo.
    
    n=n+1; % N�mero de quadros;
    uxv_LK{n} = of; % Matriz de fluxo �ptico; SOMENTE COMP. VERTICAL
    %ite = ite + 1;
end

% save 'newImage.mat' imagem load('newImage.mat', imagem)

%release(hvp);%Libera a interface e todos os recursos utilizados pela
%interface; release(hvfr);%Libera a interface e todos os recursos
%utilizados pela interface;

end