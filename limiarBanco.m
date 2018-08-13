function [] = limiarBanco()

%% Limiar de valores

% Valores com velocidade abaixo de 10^-3 ser�o desconsiderados, uma vez que
% n�o est�o contribuindo para as informa��es do Fluxo �ptico aumentando
% ent�o a probabilidade de haver mais erros na extra��o das
% caracter�sticas.

load bancoDados_FO

for i=1:20
    for j=1:10
        for k=1:10 % Frames
            bancoNovo = bancoDados_FO{i,j}{k};
            bancoNovo(bancoNovo < 10^-3) = 0;
            bancoDadosFluxo{i,j}{k} = bancoNovo;
        end
    end
end

save bancoDadosFluxo bancoDadosFluxo

end