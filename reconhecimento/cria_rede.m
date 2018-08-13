% Criando uma rede para o reconhecimento e classifica��o dos padr�es
% A rede feedforwardnet engloba duas fun��es:
%   1. patternnet: reconhecimento e classifica��o de padr�es
%   2. fitnet: regress�o e curvefiting

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