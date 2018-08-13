% Criando uma rede para o reconhecimento e classificação dos padrões
% A rede feedforwardnet engloba duas funções:
%   1. patternnet: reconhecimento e classificação de padrões
%   2. fitnet: regressão e curvefiting

function [net] = cria_rede(S,BTF)

load dadosTreinoNew; % 100x370
load target; % 4x100

%Dados de Entrada
input = dadosTreinoNew';
%Criacao da rede neural feed-forward
%net = newff(input, target, S);
net = feedforwardnet(S,BTF);
net = train(net, input, target);
nntraintool('close') % Fecha janela de teste.

end
% 
% function[net]=cria_rede(S,TF,BTF,BLF,PF,IPF,OPF,DDF)
% 
% load dadosTreinoNew;
% load target;
% 
% %Dados de Entrada
% input = dadosTreinoNew';
% %Criacao da rede neural feed-forward
% net = newff(input,target,S,TF,BTF,BLF,PF,IPF,OPF,DDF);
% net = train(net, input, target)
% nntraintool('close') % Fecha janela de teste.
% 
% end