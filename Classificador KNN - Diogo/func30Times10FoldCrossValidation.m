%Fun��o que executa valida��o cruzada estratificada �30 times 10 fold� e
%retorna a acur�cia do modelo "model" com rela��o �s classes objetivo "col_classes"
%A entrada model � um modelo treinado inicialmente no conjunto de dados completo (Treinamento + Valida��o)
%A entrada col_classes � a coluna da classe do conjunto de dados completo (Treinamento + Valida��o)
function [accuracyAfter30Times10Fold] = func30Times10FoldCrossValidation(model,col_classes)

% Vari�veis
accuracy = 1:30;
%accuracyPercentage = 1:30;

%loop para repetir o 10-fold cross validation 30 vezes
for n = 1:30
Mdl3cvmodel = crossval(model,'KFold',10);
accuracy(n) = sum(strcmp(col_classes,kfoldPredict(Mdl3cvmodel))) / numel(col_classes);
%accuracyPercentage(n) = 100*accuracy(n);
end

%Acur�cia � a m�dia das 30 medidas  
accuracyAfter30Times10Fold = sum(accuracy)/n;
end