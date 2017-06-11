clc; clear;

%Lendo os dados das views
%Dados das planilhas foram colocados em ordem de acordo com a classes
shape_view_order = '..\Data Base Image Segmentation\shape_view_order.csv';
RGB_view_order = '..\Data Base Image Segmentation\RGB_view_order.csv';
delimiterIn = ',';
headerlinesIn = 1;
RGB_view = importdata(RGB_view_order,delimiterIn,headerlinesIn);
shape_view = importdata(shape_view_order,delimiterIn,headerlinesIn);

%Dados da coluna das classes
Y1 = shape_view.textdata(2:2101,1);
%Y2 = RGB_view.textdata(2:2101,1);
%Y3 = shape_view.textdata(2:2101,1);
%Y4 = RGB_view.textdata(2:2101,1);

%Declaração das classes na ordem que aparecem nos dados
classNames = {'BRICKFACE', 'CEMENT', 'FOLIAGE','GRASS', 'PATH', 'SKY','WINDOW'}; 

%Dados shape_view normalizados
normDataV1_shape = funcNormalizeByMinMax(shape_view.data(1:2100,1));
normDataV2_shape = funcNormalizeByMinMax(shape_view.data(1:2100,2));
normDataV3_shape = funcNormalizeByMinMax(shape_view.data(1:2100,3));
normDataV4_shape = funcNormalizeByMinMax(shape_view.data(1:2100,4));
normDataV5_shape = funcNormalizeByMinMax(shape_view.data(1:2100,5));
normDataV6_shape = funcNormalizeByMinMax(shape_view.data(1:2100,6));
normDataV7_shape = funcNormalizeByMinMax(shape_view.data(1:2100,7));
normDataV8_shape = funcNormalizeByMinMax(shape_view.data(1:2100,8));
normDataV9_shape = funcNormalizeByMinMax(shape_view.data(1:2100,9));
shape_view_norm = [normDataV1_shape,normDataV2_shape,normDataV4_shape,normDataV5_shape,normDataV6_shape,normDataV7_shape,normDataV8_shape,normDataV9_shape];

%Dados RGB_view normalizados 
normDataV1_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,1));
normDataV2_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,2));
normDataV3_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,3));
normDataV4_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,4));
normDataV5_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,5));
normDataV6_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,6));
normDataV7_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,7));
normDataV8_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,8));
normDataV9_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,9));
normDataV10_RGB = funcNormalizeByMinMax(RGB_view.data(1:2100,10));
RGB_view_norm = [normDataV1_RGB,normDataV2_RGB,normDataV3_RGB,normDataV4_RGB,normDataV5_RGB,normDataV6_RGB,normDataV7_RGB,normDataV8_RGB,normDataV9_RGB,normDataV10_RGB];

%Declaração das distribuições em cada variável para o Naive Bayes
distribuition1 = {'normal','normal','normal','normal','normal','normal'};
distribuition2 = {'normal','normal','normal','normal','normal','normal','normal','normal','normal','normal'};

%Caso da variância da coluna seja zero para o Naive Bayes, a coluna é eliminada(solução encontrada no MATLAB Answers)
shape_view.data(:,3)=[];
shape_view.data(:,3)=[];
shape_view.data(:,3)=[];

%Função naive bayes
Mdl1 = fitcnb(shape_view.data,Y1,'ClassNames',classNames,'Distribution', distribuition1);
Mdl2 = fitcnb(RGB_view.data,Y1,'ClassNames',classNames,'Distribution', distribuition2);

%Função KNN
Mdl3 = fitcknn(shape_view_norm,Y1,'ClassNames',classNames,'Distance','euclidean','NumNeighbors',3); %3 melhor acurácia
Mdl4 = fitcknn(RGB_view_norm,Y1,'ClassNames',classNames,'Distance','euclidean','NumNeighbors',3); %3 melhor acurácia

%Declaração dos vetores
accuracyNBShapeView = zeros(30,1);
accuracyNBRGBView = zeros(30,1);
accuracyKNNShapeView = zeros(30,1);
accuracyKNNRGBView = zeros(30,1);
accuracyCvVote = zeros(30,1);

Y1num = funcConvertNamesToIndexes(Y1, classNames);

%30 repetições do 10-fold cross validation 
 for i = 1:30
        %Dividindo os dados com estratificação
        stratifiedKfold1 = cvpartition(Y1,'KFold',10);
        Mdl1cvmodel = crossval(Mdl1,'cvpartition',stratifiedKfold1);
        accuracyNBShapeView(i) = sum(strcmp(Y1,kfoldPredict(Mdl1cvmodel))) / numel(Y1);
        Mdl2cvmodel = crossval(Mdl2,'cvpartition',stratifiedKfold1);
        accuracyNBRGBView(i) = sum(strcmp(Y1,kfoldPredict(Mdl2cvmodel))) / numel(Y1);
        Mdl3cvmodel = crossval(Mdl3,'cvpartition',stratifiedKfold1);
        accuracyKNNShapeView(i) = sum(strcmp(Y1,kfoldPredict(Mdl3cvmodel))) / numel(Y1);
        Mdl4cvmodel = crossval(Mdl4,'cvpartition',stratifiedKfold1);
        accuracyKNNRGBView(i) = sum(strcmp(Y1,kfoldPredict(Mdl4cvmodel))) / numel(Y1);
        
        % voto majoritario
        %Y1num = funcConvertNamesToIndexes(Y1, classNames);
        predMdlcvmodelnum = [funcConvertNamesToIndexes(kfoldPredict(Mdl1cvmodel), classNames), ...
                             funcConvertNamesToIndexes(kfoldPredict(Mdl2cvmodel), classNames),...
                             funcConvertNamesToIndexes(kfoldPredict(Mdl3cvmodel), classNames),...
                             funcConvertNamesToIndexes(kfoldPredict(Mdl4cvmodel), classNames)];
                         
        predMdlcvmodelnumCvVote = mode(predMdlcvmodelnum,2);
        accuracyCvVote(i) =  sum(Y1num==predMdlcvmodelnumCvVote) / numel(Y1);   
 end

%Taxa de erro
errorRateNBShapeView = 1-accuracyNBShapeView;
errorRateNBRGBView = 1 - accuracyNBRGBView;
errorRateKNNShapeView = 1 - accuracyKNNShapeView;
errorRateKNNRGBView = 1 - accuracyKNNRGBView;
errorRateCvVote = 1 - accuracyCvVote;
 
%Média da acurácia 
accuracyNB1After30Kfold = sum(accuracyNBShapeView)/30;
accuracyNB2After30Kfold = sum(accuracyNBRGBView)/30;
accuracyKNN1After30Kfold = sum(accuracyKNNShapeView)/30;
accuracyKNN2After30Kfold = sum(accuracyKNNRGBView)/30;
accuracyVoteAfter30Kfold = sum(accuracyCvVote)/30;

%Valor de confiança
conf = 0.95;

%Estimativa pontual e intervalo de confianca (alpha = 0.05) da taxa de erro
[pdNBShapeView,ciNBShapeView] = funcGenConfidenceInterval(errorRateNBShapeView, conf);
[pdNBRGBView,ciNBRGBView] = funcGenConfidenceInterval(errorRateNBRGBView, conf);
[pdKNNShapeView,ciKNNShapeView] = funcGenConfidenceInterval(errorRateKNNShapeView, conf);
[pdKNNRGBView,ciKNNRGBView] = funcGenConfidenceInterval(errorRateKNNRGBView, conf);
[pdVote,ciVote] = funcGenConfidenceInterval(errorRateCvVote, conf);

%Teste de Friedman para a taxa de acerto
accuracyAllClassifiers = [accuracyNBShapeView, ...
                          accuracyNBRGBView, ...
                          accuracyKNNShapeView, ...
                          accuracyKNNRGBView, ...
                          accuracyCvVote];
[hypothesis, fEst, cValue, meanRanks] = funcApplyFriedmanTest(accuracyAllClassifiers, conf);

%Se rejeitar a hipotese nula realiza pós-teste utilizando Nemenyi test
if hypothesis == 1
    N = size(accuracyAllClassifiers,1);
    k = size(accuracyAllClassifiers,2);
    [ntest] = funcApplyNemenyiTest(N, k, meanRanks, conf);
end







