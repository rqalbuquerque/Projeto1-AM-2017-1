%Lendo os dados das views
%Dados das planilhas foram colocados em ordem de acordo com a classes
shape_view_order = 'D:\\UFPE\\Mestrado\\2017.1\\Aprendizagem de M�quina\\Francisco\\Projeto\\Dados\\shape_view_order.csv';
RGB_view_order = 'D:\\UFPE\\Mestrado\\2017.1\\Aprendizagem de M�quina\\Francisco\\Projeto\\Dados\\RGB_view_order.csv';
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

%Dados shape_view
V1_shape = shape_view.data(1:2100,1);
V2_shape = shape_view.data(1:2100,2);
V3_shape = shape_view.data(1:2100,3);
V4_shape = shape_view.data(1:2100,4);
V5_shape = shape_view.data(1:2100,5);
V6_shape = shape_view.data(1:2100,6);
V7_shape = shape_view.data(1:2100,7);
V8_shape = shape_view.data(1:2100,8);
V9_shape = shape_view.data(1:2100,9);

%Dados shape_view normalizados
minValV1_shape = min(V1_shape);
maxValV1_shape = max(V1_shape);
normDataV1_shape = (V1_shape - minValV1_shape) / ( maxValV1_shape - minValV1_shape );
minValV2_shape = min(V2_shape);
maxValV2_shape = max(V2_shape);
normDataV2_shape = (V2_shape - minValV2_shape) / ( maxValV2_shape - minValV2_shape);
minValV3_shape = min(V3_shape);
maxValV3_shape = max(V3_shape);
normDataV3_shape = (V3_shape - minValV3_shape) / ( maxValV3_shape - minValV3_shape);
minValV4_shape = min(V4_shape);
maxValV4_shape = max(V4_shape);
normDataV4_shape = (V4_shape - minValV4_shape) / ( maxValV4_shape - minValV4_shape);
minValV5_shape = min(V5_shape);
maxValV5_shape = max(V5_shape);
normDataV5_shape = (V5_shape - minValV5_shape) / ( maxValV5_shape - minValV5_shape);
minValV6_shape = min(V6_shape);
maxValV6_shape = max(V6_shape);
normDataV6_shape = (V6_shape - minValV6_shape) / ( maxValV6_shape - minValV6_shape);
minValV7_shape = min(V7_shape);
maxValV7_shape = max(V7_shape);
normDataV7_shape = (V7_shape - minValV7_shape) / ( maxValV7_shape - minValV7_shape );
minValV8_shape = min(V8_shape);
maxValV8_shape = max(V8_shape);
normDataV8_shape = (V8_shape - minValV8_shape) / ( maxValV8_shape - minValV8_shape );
minValV9_shape = min(V9_shape);
maxValV9_shape = max(V9_shape);
normDataV9_shape = (V9_shape - minValV9_shape) / ( maxValV9_shape - minValV9_shape );
shape_view_norm = [normDataV1_shape,normDataV2_shape,normDataV4_shape,normDataV5_shape,normDataV6_shape,normDataV7_shape,normDataV8_shape,normDataV9_shape];

%Dados RGB_view 
V1_RGB = RGB_view.data(1:2100,1);
V2_RGB = RGB_view.data(1:2100,2);
V3_RGB = RGB_view.data(1:2100,3);
V4_RGB = RGB_view.data(1:2100,4);
V5_RGB = RGB_view.data(1:2100,5);
V6_RGB = RGB_view.data(1:2100,6);
V7_RGB = RGB_view.data(1:2100,7);
V8_RGB = RGB_view.data(1:2100,8);
V9_RGB = RGB_view.data(1:2100,9);
V10_RGB = RGB_view.data(1:2100,9);

%Dados RGB_view normalizados 
minValV1_RGB = min(V1_RGB);
maxValV1_RGB = max(V1_RGB);
normDataV1_RGB = (V1_RGB - minValV1_RGB) / ( maxValV1_RGB - minValV1_RGB );
minValV2_RGB = min(V2_RGB);
maxValV2_RGB = max(V2_RGB);
normDataV2_RGB = (V2_RGB - minValV2_RGB) / ( maxValV2_RGB - minValV2_RGB);
minValV3_RGB = min(V3_RGB);
maxValV3_RGB = max(V3_RGB);
normDataV3_RGB = (V3_RGB - minValV3_RGB) / ( maxValV3_RGB - minValV3_RGB);
minValV4_RGB = min(V4_RGB);
maxValV4_RGB = max(V4_RGB);
normDataV4_RGB = (V4_RGB - minValV4_RGB) / ( maxValV4_RGB - minValV4_RGB);
minValV5_RGB = min(V5_RGB);
maxValV5_RGB = max(V5_RGB);
normDataV5_RGB = (V5_RGB - minValV5_RGB) / ( maxValV5_RGB - minValV5_RGB);
minValV6_RGB = min(V6_RGB);
maxValV6_RGB = max(V6_RGB);
normDataV6_RGB = (V6_RGB - minValV6_RGB) / ( maxValV6_RGB - minValV6_RGB);
minValV7_RGB = min(V7_RGB);
maxValV7_RGB = max(V7_RGB);
normDataV7_RGB = (V7_RGB - minValV7_RGB) / ( maxValV7_RGB - minValV7_RGB );
minValV8_RGB = min(V8_RGB);
maxValV8_RGB = max(V8_RGB);
normDataV8_RGB = (V8_RGB - minValV8_RGB) / ( maxValV8_RGB - minValV8_RGB );
minValV9_RGB = min(V9_RGB);
maxValV9_RGB = max(V9_RGB);
normDataV9_RGB = (V9_RGB - minValV9_RGB) / ( maxValV9_RGB - minValV9_RGB );
minValV10_RGB = min(V10_RGB);
maxValV10_RGB = max(V10_RGB);
normDataV10_RGB = (V10_RGB - minValV10_RGB) / ( maxValV10_RGB - minValV10_RGB );

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
accuracy1 = 1:30;
accuracy2 = 1:30;
accuracy3 = 1:30;
accuracy4 = 1:30;

%30 repeti��es do 10-fold cross validation 
 for i = 1:30
        %Dividindo os dados com estratifica��o
        stratifiedKfold1 = cvpartition(Y1,'KFold',10);
        Mdl1cvmodel = crossval(Mdl1,'cvpartition',stratifiedKfold1);
        accuracy1(i) = sum(strcmp(Y1,kfoldPredict(Mdl1cvmodel))) / numel(Y1);
        Mdl2cvmodel = crossval(Mdl2,'cvpartition',stratifiedKfold1);
        accuracy2(i) = sum(strcmp(Y1,kfoldPredict(Mdl2cvmodel))) / numel(Y1);
        Mdl3cvmodel = crossval(Mdl3,'cvpartition',stratifiedKfold1);
        accuracy3(i) = sum(strcmp(Y1,kfoldPredict(Mdl3cvmodel))) / numel(Y1);
        Mdl4cvmodel = crossval(Mdl4,'cvpartition',stratifiedKfold1);
        accuracy4(i) = sum(strcmp(Y1,kfoldPredict(Mdl4cvmodel))) / numel(Y1);
 end
 
%M�dia da acur�cia 
accuracy1After30Kfold = sum(accuracy1)/30;
accuracy2After30Kfold = sum(accuracy2)/30;
accuracy3After30Kfold = sum(accuracy3)/30;
accuracy4After30Kfold = sum(accuracy4)/30;
 
%Previs�es dos modelos
predMdl1cvmodel = kfoldPredict(Mdl1cvmodel);
predMdl2cvmodel = kfoldPredict(Mdl2cvmodel);
predMdl3cvmodel = kfoldPredict(Mdl3cvmodel);
predMdl4cvmodel = kfoldPredict(Mdl4cvmodel);

%Matriz de 4 colunas com as previs�es dos 4 modelos 
predMdlcvmodel = [predMdl1cvmodel,predMdl2cvmodel,predMdl3cvmodel,predMdl4cvmodel];

%Declara��o de Vetores de n�meros para utilizar como aux�lio na fun��o mode com o voto majorit�rio
predMdl1cvmodelnum = 1:2100;
predMdl2cvmodelnum = 1:2100;
predMdl3cvmodelnum = 1:2100;
predMdl4cvmodelnum = 1:2100;

%Inserindo os n�meros(1 a 7) nos 4 vetores associados �s classes
for n = 1:2100
	if(strcmp(predMdl1cvmodel(n),'BRICKFACE'))
        predMdl1cvmodelnum(n)=1;
	elseif(strcmp(predMdl1cvmodel(n),'CEMENT'))
		predMdl1cvmodelnum(n)=2;
	elseif(strcmp(predMdl1cvmodel(n),'FOLIAGE'))
		predMdl1cvmodelnum(n)=3;
	elseif(strcmp(predMdl1cvmodel(n), 'GRASS'))
		predMdl1cvmodelnum(n)=4;
	elseif(strcmp(predMdl1cvmodel(n),'PATH'))
		predMdl1cvmodelnum(n)=5;
	elseif(strcmp(predMdl1cvmodel(n),'SKY'))
		predMdl1cvmodelnum(n)=6;
	elseif(strcmp(predMdl1cvmodel(n),'WINDOW'))
		predMdl1cvmodelnum(n)=7;
    end
end

for n = 1:2100
	if(strcmp(predMdl2cvmodel(n),'BRICKFACE'))
        predMdl2cvmodelnum(n)=1;
	elseif(strcmp(predMdl2cvmodel(n),'CEMENT'))
		predMdl2cvmodelnum(n)=2;
	elseif(strcmp(predMdl2cvmodel(n),'FOLIAGE'))
		predMdl2cvmodelnum(n)=3;
	elseif(strcmp(predMdl2cvmodel(n),'GRASS'))
		predMdl2cvmodelnum(n)=4;
	elseif(strcmp(predMdl2cvmodel(n),'PATH'))
		predMdl2cvmodelnum(n)=5;
	elseif(strcmp(predMdl2cvmodel(n),'SKY'))
		predMdl2cvmodelnum(n)=6;
	elseif(strcmp(predMdl2cvmodel(n),'WINDOW'))
		predMdl2cvmodelnum(n)=7;
    end
end

for n = 1:2100
	if(strcmp(predMdl3cvmodel(n),'BRICKFACE'))
        predMdl3cvmodelnum(n)=1;
	elseif(strcmp(predMdl3cvmodel(n),'CEMENT'))
		predMdl3cvmodelnum(n)=2;
	elseif(strcmp(predMdl3cvmodel(n),'FOLIAGE'))
		predMdl3cvmodelnum(n)=3;
	elseif(strcmp(predMdl3cvmodel(n),'GRASS'))
		predMdl3cvmodelnum(n)=4;
	elseif(strcmp(predMdl3cvmodel(n),'PATH'))
		predMdl3cvmodelnum(n)=5;
	elseif(strcmp(predMdl3cvmodel(n),'SKY'))
		predMdl3cvmodelnum(n)=6;
	elseif(strcmp(predMdl3cvmodel(n),'WINDOW'))
		predMdl3cvmodelnum(n)=7;
    end
end

for n = 1:2100
	if(strcmp(predMdl4cvmodel(n),'BRICKFACE'))
        predMdl4cvmodelnum(n)=1;
	elseif(strcmp(predMdl4cvmodel(n),'CEMENT'))
		predMdl4cvmodelnum(n)=2;
	elseif(strcmp(predMdl4cvmodel(n),'FOLIAGE'))
		predMdl4cvmodelnum(n)=3;
	elseif(strcmp(predMdl4cvmodel(n),'GRASS'))
		predMdl4cvmodelnum(n)=4;
	elseif(strcmp(predMdl4cvmodel(n),'PATH'))
		predMdl4cvmodelnum(n)=5;
	elseif(strcmp(predMdl4cvmodel(n),'SKY'))
		predMdl4cvmodelnum(n)=6;
	elseif(strcmp(predMdl4cvmodel(n),'WINDOW'))
		predMdl4cvmodelnum(n)=7;
    end
end
 
%Matriz com as previs�es dos 4 modelos agora em n�meros
predMdlcvmodelnum = [predMdl1cvmodelnum;predMdl2cvmodelnum;predMdl3cvmodelnum;predMdl4cvmodelnum];

%Declara��o do vetor para numerar as classes de refer�ncia; 
Y1num = 1:2100;

%Loop para associar o array de classes de refer�ncia em um vetor de n�meros de 1 a 7
for n = 1:2100
	if(strcmp(Y1(n),'BRICKFACE'))
        Y1num(n)=1;
	elseif(strcmp(Y1(n),'CEMENT'))
		Y1num(n)=2;
	elseif(strcmp(Y1(n),'FOLIAGE'))
		Y1num(n)=3;
	elseif(strcmp(Y1(n),'GRASS'))
		Y1num(n)=4;
	elseif(strcmp(Y1(n),'PATH'))
		Y1num(n)=5;
	elseif(strcmp(Y1(n),'SKY'))
		Y1num(n)=6;
	elseif(strcmp(Y1(n),'WINDOW'))
		Y1num(n)=7;
    end
end

%Declara��o dos vetores para acur�cia do voto majorit�rio com cross validation 
accuracyCvVote = 1:10;
accuracyCvVoteAfterKfold = 1:30;

%Loop para 30 repeti��es do 10-fold cross validation
for n = 1:30
    %Dividindo os dados com estratifica��o
    stratifiedKfold1 = cvpartition(Y1,'KFold',10);
    %Voto majorit�rio somente nos 10 conjuntos disjuntos de teste(10-fold cross
    %validation), j� que � desnecess�rio o treinamento
    for i = 1:10 test = stratifiedKfold1.test(i); train = ~test;
        predMdlcvmodelnumCvVote = mode(predMdlcvmodelnum(1:4,test));
        accuracyCvVote(i) =  sum(Y1num(test)==predMdlcvmodelnumCvVote) / 210;   
    end

    %M�dia da acur�cia 
    accuracyCvVoteAfterKfold(n) = sum(accuracyCvVote)/10;
end

%M�dia da acur�cia 
accuracyCvVoteAfter30Kfold = sum(accuracyCvVoteAfterKfold)/30;

%{
%Declara��o de um Vetor de n�meros para utilizar a fun��o mode como voto majorit�rio 
predMdlcvmodelnumVote = 1:2100;


%Voto majorit�rio
for n = 1:2100
     predMdlcvmodelnumVote(n) = mode(predMdlcvmodelnum(1:4,n));
     
end



%Acur�cia ap�s o voto majorit�rio;
accuracyFinal = sum(Y1num==predMdlcvmodelnumVote) / numel(Y1num);
%}

 