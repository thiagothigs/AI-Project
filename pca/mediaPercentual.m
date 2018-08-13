clc
clear all
close all

%% Média das Variâncias

load dadosPercentual.mat

% Data
dataPercent = dadosPercentual;

% Engine
B = cellfun(@isnan,dataPercent,'Un',0);
% for ii = 1:length(x)
%     x{ii}(B{ii}) = 0;
% end

for i=1:10
    for j=1:20
        dataPercent{j,i}(B{j,i}) = 0;
    end
end

%% 1 linha
for i=1:10
    for j=1:20
        mediaPer1 = mean(dataPercent{j,i}(1,1:10));
        mediaPer2 = mean(dataPercent{j,i}(2,1:10));
        mediaPer3 = mean(dataPercent{j,i}(3,1:10));
        mediaPer4 = mean(dataPercent{j,i}(4,1:10));
        mediaPer5 = mean(dataPercent{j,i}(5,1:10));
        mediaPer6 = mean(dataPercent{j,i}(6,1:10));
        mediaPer7 = mean(dataPercent{j,i}(7,1:10));
        
        mediaPerTot1 = mediaPer1;
        mediaPerTot2 = mediaPer1+mediaPer2;
        mediaPerTot3 = mediaPer1+mediaPer2+mediaPer3;
        mediaPerTot4 = mediaPer1+mediaPer2+mediaPer3+mediaPer4;
        mediaPerTot5 = mediaPer1+mediaPer2+mediaPer3+mediaPer5;
        mediaPerTot6 = mediaPer1+mediaPer2+mediaPer3+mediaPer5+mediaPer6;
        mediaPerTot7 = mediaPer1+mediaPer2+mediaPer3+mediaPer5+mediaPer6+mediaPer7;
        meanPerc{j,i} = mediaPerTot7;
    end
end