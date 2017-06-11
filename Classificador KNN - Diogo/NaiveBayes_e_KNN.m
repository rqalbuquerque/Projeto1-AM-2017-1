
%Lendo os dados das views
%Dados das planilhas foram colocados em ordem de acordo com a classes
shape_view_order = 'shape_view_order.csv';
RGB_view_order = 'RGB_view_order.csv';
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
accuracyNBShapeView = 1:30;
accuracyNBRGBView = 1:30;
accuracyKNNShapeView = 1:30;
accuracyKNNRGBView = 1:30;
accuracyCvVote = 1:30;

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
        predMdlcvmodelnum = [funcConvertNamesToIndexes(kfoldPredict(Mdl1cvmodel), classNames)', ...
                             funcConvertNamesToIndexes(kfoldPredict(Mdl2cvmodel), classNames)',...
                             funcConvertNamesToIndexes(kfoldPredict(Mdl3cvmodel), classNames)',...
                             funcConvertNamesToIndexes(kfoldPredict(Mdl4cvmodel), classNames)'];
                         
        predMdlcvmodelnumCvVote = mode(predMdlcvmodelnum,2);
        accuracyCvVote(i) =  sum(Y1num'==predMdlcvmodelnumCvVote) / numel(Y1);   
 end

 
%M�dia da acur�cia 
accuracy1After30Kfold = sum(accuracyNBShapeView)/30;
accuracy2After30Kfold = sum(accuracyNBRGBView)/30;
accuracy3After30Kfold = sum(accuracyKNNShapeView)/30;
accuracy4After30Kfold = sum(accuracyKNNRGBView)/30;

 %M�dia da acur�cia 
accuracyCvVoteAfter30Kfold = sum(accuracyCvVote)/30;


%{
%Previs�es dos modelos
predMdl1cvmodel = kfoldPredict(Mdl1cvmodel);
predMdl2cvmodel = kfoldPredict(Mdl2cvmodel);
predMdl3cvmodel = kfoldPredict(Mdl3cvmodel);
predMdl4cvmodel = kfoldPredict(Mdl4cvmodel);

%Matriz de 4 colunas com as previs�es dos 4 modelos 
predMdlcvmodel = [predMdl1cvmodel,predMdl2cvmodel,predMdl3cvmodel,predMdl4cvmodel];

%Inserindo os n�meros(1 a 7) nos 4 vetores associados �s classes
predMdl1cvmodelnum = funcConvertNamesToIndexes(predMdl1cvmodel, classNames);
predMdl2cvmodelnum = funcConvertNamesToIndexes(predMdl2cvmodel, classNames);
predMdl3cvmodelnum = funcConvertNamesToIndexes(predMdl3cvmodel, classNames);
predMdl4cvmodelnum = funcConvertNamesToIndexes(predMdl4cvmodel, classNames);

%Matriz com as previs�es dos 4 modelos agora em n�meros
predMdlcvmodelnum = [predMdl1cvmodelnum;predMdl2cvmodelnum;predMdl3cvmodelnum;predMdl4cvmodelnum];

%Loop para associar o array de classes de refer�ncia em um vetor de n�meros de 1 a 7
Y1num = funcConvertNamesToIndexes(Y1, classNames);

%Declara��o dos vetores para acur�cia do voto majorit�rio com cross validation 
accuracyCvVote = 1:10;
accuracyCvVoteAfterKfold = 1:30;

%Loop para 30 repeti��es do 10-fold cross validation
for n = 1:30
    %Dividindo os dados com estratifica��o
    stratifiedKfold1 = cvpartition(Y1,'KFold',10);
    %Voto majorit�rio somente nos 10 conjuntos disjuntos de teste(10-fold cross
    %validation), j� que � desnecess�rio o treinamento
    for i = 1:10 
        test = stratifiedKfold1.test(i); train = ~test;
        predMdlcvmodelnumCvVote = mode(predMdlcvmodelnum(1:4,test));
        accuracyCvVote(i,n) =  sum(Y1num(test)==predMdlcvmodelnumCvVote) / 210;   
    end

    %M�dia da acur�cia 
    accuracyCvVoteAfterKfold(n) = sum(accuracyCvVote(:,n))/10;
end

%M�dia da acur�cia 
accuracyCvVoteAfter30Kfold = sum(accuracyCvVoteAfterKfold)/30;

%} 