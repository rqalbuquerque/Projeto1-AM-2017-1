%Função que executa validação cruzada estratificada “30 times 10 fold” e
%retorna a acurácia do modelo "model" com relação às classes objetivo "col_classes"
%A entrada model é um modelo treinado inicialmente no conjunto de dados completo (Treinamento + Validação)
%A entrada col_classes é a coluna da classe do conjunto de dados completo (Treinamento + Validação)
function [accuracyAfter30Times10Fold] = func30Times10FoldCrossValidation (model,col_classes)

  % Declaração de um vetor para armazenar cada acurácia do loop;
  accuracy = 1:30;

  %loop para repetir o 10-fold cross-validation n 30 vezes
  for n = 1:30
    %Obtendo o resultado do 10-fold cross validation 
    Mdlcvmodel = crossval(model,'KFold',10);
    %Obtendo o valor da acurácia
    accuracy(n) = sum(strcmp(col_classes,kfoldPredict(Mdlcvmodel))) / numel(col_classes);
  end

  %Acurácia final é a média das 30 medidas de acurácia   
  accuracyAfter30Times10Fold = sum(accuracy)/n;
end
