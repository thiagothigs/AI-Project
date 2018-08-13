function [] = criaNovoVideo()
writerObj = VideoWriter('recorte_boca');
open(writerObj);

load('newImage.mat', 'imagem')
% axis tight set(gca,'nextplot','replacechildren');
% set(gcf,'Renderer','zbuffer');

[line col] = size(imagem);
for i=1:line
    for j=1:col
        im = rgb2gray(imagem{i,j}); % Convertendo imagem para escala de cinza
        
        %imwrite(im,'boca.jpg');
        %boca = imread('boca.jpg');
        %boca = rgb2gray(boca);
        %imshow(I)
        %bocaFil = medfilt2(boca,[1,1]);
        %L = wiener2(I,[2,2]);
        %figure, imshow(L)
        
        novaImagem{i,j} = im; % nova imagem
    end
end
% [line col] = size(imagem);
% for i=1:line
%     for j=1:col
%         im = rgb2gray(imagem{i,j}); % Convertendo imagem para escala de cinza
%         imwrite(im,'boca.jpg')
%         boca = imread('boca','jpg');
%         level = graythresh(boca);
%         BW = im2bw(boca,level);
%         novaImagem{i,j} = BW; % nova imagem
%     end
% end
for k = 1:length(novaImagem)
    clf
    imshow(novaImagem{1,k});
    frame = getframe;
    writeVideo(writerObj,frame);
    
end

close(writerObj);

end