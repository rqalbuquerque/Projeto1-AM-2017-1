%Função que executa validação cruzada estratificada “N times K fold” e
%retorna a acurácia do modelo "model" com relação às classes objetivo "col_classes"
%A entrada model é um modelo treinado inicialmente no conjunto de dados completo (Treinamento + Validação)
%A entrada col_classes é a coluna da classe do conjunto de dados completo (Treinamento + Validação)
%A entrada nTimes é o numero de repetições do k-fold
%A entrada nfold é o número k do k-fold.
function [accuracyAfterNTimesKFold] = funcNTimesKFoldCrossValidation(model,col_classes,nTimes,nFold)

    %Declaração de um vetor para armazenar cada acurácia do loop
    accuracy = 1:nTimes;

    %Retorna k-fold partições estratificadas de acordo com a coluna de
    %classes "col_classes" e o numero de folds "nFold" 
    stratifiedKfold = cvpartition(col_classes,'KFold',nFold);
    
    %loop para repetir o 10-fold cross validation 30 vezes
    for n = 1:nTimes
        %Executa a validação cruzada de acordo com os dados estratificados "stratifiedKfold" e o modelo "model" 
        Mdlcvmodel = crossval(model,'cvpartition',stratifiedKfold);
        %Obtendo o valor da acurácia
        accuracy(n) = sum(strcmp(col_classes,kfoldPredict(Mdlcvmodel))) / numel(col_classes);
    end

    %Acurácia é a média das nTimes medidas  
    accuracyAfterNTimesKFold = sum(accuracy)/nTimes;
end