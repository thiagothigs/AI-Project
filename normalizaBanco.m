function [] = normalizaBanco()
% 1. Fazendo módulo do Banco de Dados (Energia)
% 2. Normalizando Banco de Dados

load bancoDadosFluxo

for i=1:10 % Representa as palavras gravadas em áudio: zero, um, ..., dez.
    for k=1:20
        [tamanho(k),col(k)]=size(bancoDadosFluxo{k,i}{1}); % Memoriza o tamanho do vetor da k-ésima gravação da i-ésima palavra gravada.
    end
    tamanho_maximo(i)=max(tamanho');
    max_col(i) = max(col);
    
end

maiorLinha = max(tamanho_maximo);
maiorColuna = max(max_col);

for i=1:20 % linhas (algarismos)
    
    for j=1:10 % colunas (gravações)
        
        for k=1:10 % frames
            modBanco = abs(bancoDadosFluxo{i,j}{k});
            absBanco{i,j}{k} = modBanco;
        end
        
    end
    
end

for i=1:20 % linhas (algarismos)
    
    for j=1:10 % colunas (gravações)
        
        for k=1:10 % frames
            bancoNorm = absBanco{i,j}{k};
            bancoNorm2 = bancoNorm;
            %bancoNorm2 = bancoNorm ./ (max(bancoNorm(:))); % Normalização
            % Todas as matrizes de mesmo tamanho
            [linhaAtual,colAtual] = size(bancoNorm2);
            line = maiorLinha-linhaAtual;
            coluna = maiorColuna - colAtual;
            
            bancoNorm3 = [bancoNorm2; NaN(line,colAtual)];
            bancoNorm3(isnan(bancoNorm3)) = 0;
            bancoNorm3 = padarray(bancoNorm3, [0 (maiorColuna-colAtual)], 'post');
            dataBase{i,j}{k} = bancoNorm3;
            %padarray(a, [0,2], 'post')
            
        end
        
    end
    
end

save dataBase dataBase;

end