
for i=1:10 % Representa as palavras gravadas em �udio: zero, um, ..., dez.
    for k=1:20 % Acessa a k-�sima grava��o de um determinado n�mero em �udio.
      % dados = unique(reshape(dataInput{k,i},1,[]));
      dados = reshape(dataInput{k,i},1,[]);
      dataIn{k,i} = dados;
    end
end