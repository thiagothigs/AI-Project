%Função para simular rede neural com dados de treino (input) e dados de
%teste

function [taxas_acerto] = simula_rede(net)

load dadosTesteNew; % 100x370
load dadosTreinoNew;
load target; % 4x100

%Simulacao da rede
teste = dadosTesteNew';
treino = dadosTreinoNew';

% result_test = sim(net,teste); % Simulação com dados de teste
% result_treino = sim(net,treino); % Simulação com dados de treino

result_treino = net(treino); % Simulação com dados de treino
result_test = net(teste); % Simulação com dados de teste

save result_treino result_treino;
save result_test result_test;

result_esperado = target; % Resultado esperado para a saída da rede

% Tratamento da saída da rede para os vetores de teste
% for i=1:100
%     for j=1:4
%          if result_test(j,i)<0.5
%          result_final_dadosteste(j,i)=0;
%          else
%          result_final_dadosteste(j,i)=1;
%          end
%     end
% end

result_test(result_test<0.5)=0;
result_test(result_test>=0.5)=1;
result_final_dadosteste = result_test;

save result_final_dadosteste result_final_dadosteste;

% Tratamento da saída da rede para os vetores de treino
% for i=1:100
%     for j=1:4
%         if result_treino(j,i)<0.5
%         result_final_dadostreino(j,i)=0;
%         else
%         result_final_dadostreino(j,i)=1;
%         end
%     end
% end

result_treino(result_treino<0.5)=0;
result_treino(result_treino>=0.5)=1;
result_final_dadostreino = result_treino;

save result_final_dadostreino result_final_dadostreino;

% ANÁLISE DA SIMULAÇÃO POR PALAVRA GRAVADA
% Transformando a matriz de binários, numa matriz de decimais
for i=1:100
    dec=0;
    for j=1:4
        dec=dec+result_final_dadosteste(j,i)*2^(4-j);      
    end
   result_final_dadosteste_dec(i)=dec;
end
save result_final_dadosteste_dec result_final_dadosteste_dec

for i=1:100
    dec=0;
    for j=1:4
        dec=dec+result_final_dadostreino(j,i)*2^(4-j);      
    end
   result_final_dadostreino_dec(i)=dec;
end

save result_final_dadostreino_dec result_final_dadostreino_dec

for i=1:100
    dec=0;
    for j=1:4
        dec=dec+target(j,i)*2^(4-j);      
    end
   target_dec(i)=dec;
end

save target_dec target_dec

% ANÁLISE DE EFICIÊNCIA PARA TESTE
% Taxa de acerto para a simulação com valores de teste

%fprintf('Fala\t\tEficiencia\n');
geral=0;
for n=0:10:90
    j=0;
    for i=1:10
    
        if target_dec(i+n)==result_final_dadosteste_dec(i+n)
          j=j+1;
          geral=geral+1;
        end
   
    end
taxas_acerto_teste(1+n/10) = j/10; % Guarda as taxas de eficiência para cada palavra. Ex:taxas_acerto_teste(1)=eficiencia para reconhecimento do zero, taxas_acerto_teste(2)=eficiencia para reconhecimento do um, ...

%fprintf('%i \t\t %.2f\n',n/10,j/10);
end

taxas_acerto_teste(11) = geral/100; % Guarda a eficiência geral na 12a posicao.
%fprintf('geral \t\t %.2f\n',geral/110);

%ANALISE DE EFICIENCIA PARA TREINO
%Taxa de acerto para a simulação com valores de treino

%fprintf('Fala\t\tEficiencia\n');
geral=0;
for n=0:10:90
    j=0;
    for i=1:10
    
        if target_dec(i+n)==result_final_dadostreino_dec(i+n)
          j=j+1;
          geral=geral+1;
        end
   
    end
taxas_acerto_treino(1+n/10) = j/10; % Guarda as taxas de eficiência para cada palavra. Ex:taxas_acerto_teste(1)=eficiencia para reconhecimento do zero, taxas_acerto_teste(2)=eficiencia para reconhecimento do um, ...

%fprintf('%i \t\t %.2f\n',n/10,j/10);
end

taxas_acerto_treino(11) = geral/100; % Guarda a eficiência geral na 12a posicao.
%fprintf('geral \t\t %.2f\n',geral/110);

taxas_acerto{1,1} = taxas_acerto_treino;
taxas_acerto{1,2} = taxas_acerto_teste;