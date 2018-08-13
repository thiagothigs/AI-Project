function [] = ROI()
% 1. Detecta o rosto
% 2. Identifica características faciais para rastrear
% 3. Rastreia região da boca - ROI

% Nome dos arquivos que serão carregados
namefile = [{'zero_'}, {'um_'},{'dois_'},{'tres_'},{'quatro_'}, {'cinco_'},...
    {'seis_'}, {'sete_'}, {'oito_'}, {'nove_'}];

for k=1:10
    for j=1:20
        
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
        %figure; imshow(videoFrame)
        %title('Frame de entrada');
        
        %% Cria um detector de objeto cascata
        jj = 1;
        while true
            faceDetector = vision.CascadeObjectDetector('Mouth', 'MergeThreshold',jj);
            bbox = step(faceDetector, videoFrame);
            [line, col] = size(bbox);
            if line == 1
                break;
            end
            jj = jj+1;
        end
        box{j,k} = bbox;
        fprintf('Áudio: %g...\n', k-1)
    end
end

save box box

end