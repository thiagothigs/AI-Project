% TESTE DE EFICIÊNCIA DO RECONHECEDOR PARA DIFERENTES CONFIGURAÇÕES DA RNA
% Algoritmo para simular N vezes a rede em diferentes configurações
% Exibe somente as médias finais para cada configuração

clc
clear all
close all

tic
fid = fopen('resultado_simulacao.xls','w+');

fprintf(fid,'ANÁLISE SISTEMA DE RECONHECIMENTO DE FALA QUANTO À VARIAÇÃO DE PARÂMETROS\n');
fprintf(fid,'(S)\tBTF\tNúmero Iteracões');
fprintf(fid,'\t(0)Treino\t(1)Treino\t(2)Treino\t(3)Treino\t(4)Treino\t(5)Treino\t(6)Treino\t(7)Treino\t(8)Treino\t(9)Treino\t(Geral)Treino');
fprintf(fid,'\t(0)Teste\t(1)Teste\t(2)Teste\t(3)Teste\t(4)Teste\t(5)Teste\t(6)Teste\t(7)Teste\t(8)Teste\t(9)Teste\t(Geral)Teste');

N = 20; % Número de repetições para cada configuração
Smin = 10; % Número mínimo de neurônios por camada
Smax = 30; % Número máximo de neurônios por camada
BTF = '';
% acerto_dadostreino = 0;
% acerto_dadosteste = 0;
total_iteracoes = 0; % Total de iterações realizadas pelo algoritmo.
total_esperado_iteracoes=3*(Smax/Smin)*N;

for S=Smin:10:Smax
    %Variação dos parâmetros BTF
        for k=1:3
            switch k
                case 1
                    BTF='trainlm';
%                 case 2
%                     BTF='trainbfg';
                case 2
                    BTF='trainrp';
                case 3
                    BTF='traingd';
            end
    
    soma_acertos_dadosteste = zeros(1,11);
    soma_acertos_dadostreino = zeros(1,11);
    
    for n=1:N % Repetições do teste para uma mesma configuração
        
        % CRIAÇÃO DA REDE NEURAL
        net = cria_rede(S,BTF);
       
        %cria_rede(10,'TANSIG','TRAINLM','LEARNGD','MSE',{'fixunknowns','removeconstantrows','mapminmax'},{'removeconstantrows','mapminmax'},'dividerand');
        %SIMULA REDE
        taxas_acerto = simula_rede(net);
        
        %OBS: taxas_acerto{1,1}(1:12): porcentagem de acertos para variaveis de TREINO
        %     taxas_acerto{1,2}(1:12): porcentagem de acertos para variaveis de TESTE
        
        %Criação de tabela com os dados de configuração da rede e as taxas de
        %acerto
        
        for h=1:11
            
            soma_acertos_dadosteste(h) = soma_acertos_dadosteste(h)+taxas_acerto{1,2}(h);
            soma_acertos_dadostreino(h) = soma_acertos_dadostreino(h)+taxas_acerto{1,1}(h);
            
        end
        
        total_iteracoes = total_iteracoes+1;
        
        clc;
        fprintf('Porcentagem Concluída: %.3f %', (total_iteracoes/total_esperado_iteracoes)*100);
        
    end
    
    % Cálculo da média final após N iterações
    for h=1:11
        media_acertos_dadosteste(h) = soma_acertos_dadosteste(h)/N;
        media_acertos_dadostreino(h) = soma_acertos_dadostreino(h)/N;
    end
    
    fprintf(fid,'\n%i \t%s \t%i',S,BTF,N);
    %fprintf(fid,'\n%i \t %s \t %s \t %s \t %s \t %s \t %s \t %s\t%i',S,TF_fprint,BTF,BLF,PF,IPF_fprint,OPF_fprint,DDF,N);
    fprintf(fid,'\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f',media_acertos_dadostreino(1), media_acertos_dadostreino(2), media_acertos_dadostreino(3), media_acertos_dadostreino(4), media_acertos_dadostreino(5), media_acertos_dadostreino(6), media_acertos_dadostreino(7), media_acertos_dadostreino(8),media_acertos_dadostreino(9), media_acertos_dadostreino(10),media_acertos_dadostreino(11));
    fprintf(fid,'\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f\t%.3f',media_acertos_dadosteste(1), media_acertos_dadosteste(2),media_acertos_dadosteste(3),media_acertos_dadosteste(4),media_acertos_dadosteste(5), media_acertos_dadosteste(6),media_acertos_dadosteste(7), media_acertos_dadosteste(8),media_acertos_dadosteste(9), media_acertos_dadosteste(10),media_acertos_dadosteste(11));
    
    
end
end

fprintf(fid,'\n\nTOTAL DE ITERAÇÕES DA ANÁLISE DO RECONHECEDOR DE FALA: %i ITERAÇÕES.',total_iteracoes);
tempo = toc;
fprintf(fid,'\n\nTempo de execução: %g minutos\n',tempo/60);
fclose(fid);