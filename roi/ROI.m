function [] = ROI()
% 1. Detecta o rosto
% 2. Identifica caracter�sticas faciais para rastrear
% 3. Rastreia regi�o da boca - ROI

% Nome dos arquivos que ser�o carregados
namefile = [{'zero_'}, {'um_'},{'dois_'},{'tres_'},{'quatro_'}, {'cinco_'},...
    {'seis_'}, {'sete_'}, {'oito_'}, {'nove_'}];

for k=1:10
    for j=1:20
        
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
        fprintf('�udio: %g...\n', k-1)
    end
end

save box box

end