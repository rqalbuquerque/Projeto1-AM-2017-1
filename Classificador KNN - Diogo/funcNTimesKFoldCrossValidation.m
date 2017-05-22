%Fun��o que executa valida��o cruzada estratificada �N times K fold� e
%retorna a acur�cia do modelo "model" com rela��o �s classes objetivo "col_classes"
%A entrada model � um modelo treinado inicialmente no conjunto de dados completo (Treinamento + Valida��o)
%A entrada col_classes � a coluna da classe do conjunto de dados completo (Treinamento + Valida��o)
%A entrada nTimes � o numero de repeti��es do k-fold
%A entrada nfold � o n�mero k do k-fold.
function [accuracyAfterNTimesKFold] = funcNTimesKFoldCrossValidation(model,col_classes,nTimes,nFold)

    %Declara��o de um vetor para armazenar cada acur�cia do loop
    accuracy = 1:nTimes;

    %Retorna k-fold parti��es estratificadas de acordo com a coluna de
    %classes "col_classes" e o numero de folds "nFold" 
    stratifiedKfold = cvpartition(col_classes,'KFold',nFold);
    
    %loop para repetir o 10-fold cross validation 30 vezes
    for n = 1:nTimes
        %Executa a valida��o cruzada de acordo com os dados estratificados "stratifiedKfold" e o modelo "model" 
        Mdlcvmodel = crossval(model,'cvpartition',stratifiedKfold);
        %Obtendo o valor da acur�cia
        accuracy(n) = sum(strcmp(col_classes,kfoldPredict(Mdlcvmodel))) / numel(col_classes);
    end

    %Acur�cia � a m�dia das nTimes medidas  
    accuracyAfterNTimesKFold = sum(accuracy)/nTimes;
end