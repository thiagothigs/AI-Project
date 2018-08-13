%Criando a matriz de TESTE e de RESULTADO ESPERADO

function [target] = criaTarget()

%-----------------MONTAGEM TESTE-----------------
j=1;%Contagem das linhas da matriz input que terá um total de 110 linhas, 10 amostras para cada número.

for i=1:10%Cada uma dos vinte números gravados em áudio: zero, um, ..., dez
    for n=1:10%Leva em consideração somente as 10 primeiras gravações de cada numero em audio
        for k=1:20%Varre os 20 menores desvios da matriz nMenoresDesvios
            
            %dadosTeste(j,k)=coeficientes_ceps{n,i}(nMenoresDesvios{1,i}(k,2),nMenoresDesvios{1,i}(k,3));
            
            %----------------MONTAGEM TARGET--------------------
            switch i
                case 1
                    target(j,1:4)=[0 0 0 0];
                case 2
                    target(j,1:4)=[0 0 0 1];
                case 3
                    target(j,1:4)=[0 0 1 0];
                case 4
                    target(j,1:4)=[0 0 1 1];
                case 5
                    target(j,1:4)=[0 1 0 0];
                case 6
                    target(j,1:4)=[0 1 0 1];
                case 7
                    target(j,1:4)=[0 1 1 0];
                case 8
                    target(j,1:4)=[0 1 1 1];
                case 9
                    target(j,1:4)=[1 0 0 0];
                case 10
                    target(j,1:4)=[1 0 0 1];
            end
            %______________________FIM MONTAGEM TARGET______________________
        end
        j=j+1;
    end
end

target=target';
end