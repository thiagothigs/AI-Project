function [] = limiarBanco()

%% Limiar de valores

% Valores com velocidade abaixo de 10^-3 serão desconsiderados, uma vez que
% não estão contribuindo para as informações do Fluxo Óptico aumentando
% então a probabilidade de haver mais erros na extração das
% características.

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