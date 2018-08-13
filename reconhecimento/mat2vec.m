
for i=1:10 % Representa as palavras gravadas em áudio: zero, um, ..., dez.
    for k=1:20 % Acessa a k-ésima gravação de um determinado número em áudio.
      % dados = unique(reshape(dataInput{k,i},1,[]));
      dados = reshape(dataInput{k,i},1,[]);
      dataIn{k,i} = dados;
    end
end