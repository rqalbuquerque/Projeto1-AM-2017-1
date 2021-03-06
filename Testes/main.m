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

%Declara��o das classes na ordem que aparecem nos dados
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

%Declara��o das distribui��es em cada vari�vel para o Naive Bayes
distribuition1 = {'normal','normal','normal','normal','normal','normal'};
distribuition2 = {'normal','normal','normal','normal','normal','normal','normal','normal','normal','normal'};

%Caso da vari�ncia da coluna seja zero para o Naive Bayes, a coluna � eliminada(solu��o encontrada no MATLAB Answers)
shape_view.data(:,3)=[];
shape_view.data(:,3)=[];
shape_view.data(:,3)=[];

%Fun��o naive bayes
Mdl1 = fitcnb(shape_view.data,Y1,'ClassNames',classNames,'Distribution', distribuition1);
Mdl2 = fitcnb(RGB_view.data,Y1,'ClassNames',classNames,'Distribution', distribuition2);

%Fun��o KNN
Mdl3 = fitcknn(shape_view_norm,Y1,'ClassNames',classNames,'Distance','euclidean','NumNeighbors',3); %3 melhor acur�cia
Mdl4 = fitcknn(RGB_view_norm,Y1,'ClassNames',classNames,'Distance','euclidean','NumNeighbors',3); %3 melhor acur�cia

%Declara��o dos vetores
accuracyNBShapeView = zeros(30,1);
accuracyNBRGBView = zeros(30,1);
accuracyKNNShapeView = zeros(30,1);
accuracyKNNRGBView = zeros(30,1);
accuracyCvVote = zeros(30,1);

Y1num = funcConvertNamesToIndexes(Y1, classNames);

%30 repeti��es do 10-fold cross validation 
 for i = 1:30
        %Dividindo os dados com estratifica��o
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
 
%M�dia da acur�cia 
accuracyNB1After30Kfold = sum(accuracyNBShapeView)/30;
accuracyNB2After30Kfold = sum(accuracyNBRGBView)/30;
accuracyKNN1After30Kfold = sum(accuracyKNNShapeView)/30;
accuracyKNN2After30Kfold = sum(accuracyKNNRGBView)/30;
accuracyVoteAfter30Kfold = sum(accuracyCvVote)/30;

%Valor de confian�a
conf = 0.95;
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
[hypothesis, stt, cValue, meanRanks] = funcApplyFriedmanTest(accuracyAllClassifiers, conf);

%Se rejeitar a hipotese nula realiza p�s-teste utilizando Nemenyi test
if hypothesis == 1
    N = size(accuracyAllClassifiers,1);
    k = size(accuracyAllClassifiers,2);
    [ntest, qa] = funcApplyNemenyiTest(N, k, meanRanks, conf);
end

%Imprime Resultados
fileID = fopen('Resultados.txt','w');

fprintf(fileID, '--------------------------------------------------------------------------------\n');
fprintf(fileID, 'Estimativa pontual e intervalo de confianca da taxa de erro medio (alpha = 0.05)\n');
fprintf(fileID, '--------------------------------------------------------------------------------\n');
fprintf(fileID, 'Naive Bayes - Shape View\n');
fprintf(fileID, '\tMedia amostral: %.4f\n',pdNBShapeView(1));
fprintf(fileID, '\tIC para Media amostral: %.4f - %.4f\n',ciNBShapeView(1,1),ciNBShapeView(2,1));
fprintf(fileID, '\tVariancia amostral: %.4f\n',pdNBShapeView(2));
fprintf(fileID, '\tIC para Variancia amostral: %.4f - %.4f\n\n',ciNBShapeView(1,2),ciNBShapeView(2,2));

fprintf(fileID, 'Naive Bayes - RGB View\n');
fprintf(fileID, '\tMedia amostral: %.4f\n',pdNBRGBView(1));
fprintf(fileID, '\tIC para Media amostral: %.4f - %.4f\n',ciNBRGBView(1,1),ciNBRGBView(2,1));
fprintf(fileID, '\tVariancia amostral: %.4f\n',pdNBRGBView(2));
fprintf(fileID, '\tIC para Variancia amostral: %.4f - %.4f\n\n',ciNBRGBView(1,2),ciNBRGBView(2,2));

fprintf(fileID, 'KNN - Shape View\n');
fprintf(fileID, '\tMedia amostral: %.4f\n',pdKNNShapeView(1));
fprintf(fileID, '\tIC para Media amostral: %.4f - %.4f\n',ciKNNShapeView(1,1),ciKNNShapeView(2,1));
fprintf(fileID, '\tVariancia amostral: %.4f\n',pdKNNShapeView(2));
fprintf(fileID, '\tIC para Variancia amostral: %.4f - %.4f\n\n',ciKNNShapeView(1,2),ciKNNShapeView(2,2));

fprintf(fileID, 'KNN - RGB View\n');
fprintf(fileID, '\tMedia amostral: %.4f\n',pdKNNRGBView(1));
fprintf(fileID, '\tIC para Media amostral: %.4f - %.4f\n',ciKNNRGBView(1,1),ciKNNRGBView(2,1));
fprintf(fileID, '\tVariancia amostral: %.4f\n',pdKNNRGBView(2));
fprintf(fileID, '\tIC para Variancia amostral: %.4f - %.4f\n\n',ciKNNRGBView(1,2),ciKNNRGBView(2,2));

fprintf(fileID, 'Voto Majoritario\n');
fprintf(fileID, '\tMedia amostral: %.4f\n',pdVote(1));
fprintf(fileID, '\tIC para Media amostral: %.4f - %.4f\n',ciVote(1,1),ciVote(2,1));
fprintf(fileID, '\tVariancia amostral: %.4f\n',pdVote(2));
fprintf(fileID, '\tIC para Variancia amostral: %.4f - %.4f\n',ciVote(1,2),ciVote(2,2));
fprintf(fileID, '--------------------------------------------------------------------------------\n');


fprintf(fileID, '--------------------------------------------------------------------------------\n');
fprintf(fileID, 'Teste de Friedman para a taxa de acerto medio (alpha = 0.05)\n');
fprintf(fileID, '--------------------------------------------------------------------------------\n');
fprintf(fileID, 'Media dos ranques\n');
fprintf(fileID, '\tNaive Bayes - Shape View   -> %.2f\n',meanRanks(1));
fprintf(fileID, '\tNaive Bayes - RGB View     -> %.2f\n',meanRanks(2));
fprintf(fileID, '\tKNN - Shape View           -> %.2f\n',meanRanks(3));
fprintf(fileID, '\tKNN - RGB View             -> %.2f\n',meanRanks(4));
fprintf(fileID, '\tVoto Majoritario           -> %.2f\n\n',meanRanks(5));

fprintf(fileID, 'Valor critico: %.2f\n\n', cValue);

fprintf(fileID, 'Estatistica de teste (F): %.2f\n\n', double(stt));

fprintf(fileID, 'Resultado do teste: \n');
if hypothesis == 1
   fprintf(fileID, '\tRejeita a hipotese nula\n\n');
   fprintf(fileID, 'Resultado da aplicacao de Nemenyi teste:\n');
   
   fprintf(fileID, '\t1 - Naive Bayes - Shape View\n');
   fprintf(fileID, '\t2 - Naive Bayes - RGB View\n');
   fprintf(fileID, '\t3 - KNN - Shape View\n');
   fprintf(fileID, '\t4 - KNN - RGB View\n');
   fprintf(fileID, '\t5 - Voto Majoritario\n\n');

   fprintf(fileID, '\t   ');
   for i=1:size(ntest,1)
       fprintf(fileID, ' %d',i);
   end
   fprintf(fileID, '\n');
   
   fprintf(fileID, '\t   ');
   for i=1:size(ntest,1)
       fprintf(fileID, ' |');
   end
   fprintf(fileID, '\n');
   
   for i=1:size(ntest,1)
       fprintf(fileID, '\t%d -',i);
       for j=1:size(ntest,2)
           fprintf(fileID, ' %d',ntest(i,j));
       end
       fprintf(fileID, '\n');
   end
   
else
    fprintf(fileID, 'Aceita a hipotese nula\n');
end
fprintf(fileID, '--------------------------------------------------------------------------------\n');
