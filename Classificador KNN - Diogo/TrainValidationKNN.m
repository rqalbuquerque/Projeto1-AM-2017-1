%Lendo os dados das views
%Dados das planilhas foram colocados em ordem de acordo com a classes
shape_view_order_train = 'D:\\UFPE\\Mestrado\\2017.1\\Aprendizagem de Máquina\\Francisco\\Projeto\\Dados\\shape_view_order_train.csv';
shape_view_order_val = 'D:\\UFPE\\Mestrado\\2017.1\\Aprendizagem de Máquina\\Francisco\\Projeto\\Dados\\shape_view_order_val.csv';
RGB_view_order_train = 'D:\\UFPE\\Mestrado\\2017.1\\Aprendizagem de Máquina\\Francisco\\Projeto\\Dados\\RGB_view_order_train.csv';
RGB_view_order_val = 'D:\\UFPE\\Mestrado\\2017.1\\Aprendizagem de Máquina\\Francisco\\Projeto\\Dados\\RGB_view_order_val.csv';
delimiterIn = ',';
headerlinesIn = 1;
shape_view_train = importdata(shape_view_order_train,delimiterIn,headerlinesIn);
shape_view_val = importdata(shape_view_order_val,delimiterIn,headerlinesIn);
RGB_view_train = importdata(RGB_view_order_train,delimiterIn,headerlinesIn);
RGB_view_val = importdata(RGB_view_order_val,delimiterIn,headerlinesIn);

%Dados da coluna das classes
Y3_train = shape_view_train.textdata(2:1401,1);
Y3_val = shape_view_val.textdata(2:701,1);
Y4_train = RGB_view_train.textdata(2:1401,1);
Y4_val = RGB_view_val.textdata(2:701,1);

%frequency table of data in vector Y1 and Y2
tabulate(Y3_train)
tabulate(Y3_val)
tabulate(Y4_train)
tabulate(Y4_val)

%Declaração das classes na ordem que aparecem nos dados
classNames = {'BRICKFACE', 'CEMENT', 'FOLIAGE','GRASS', 'PATH', 'SKY','WINDOW'}; 

%Declaração dos vetores
 accuracy3_train = 1:20;
 accuracyPercentage3_train = 1:20;
 accuracy3_val = 1:20;
 accuracyPercentage3_val = 1:20;
 accuracy4_train = 1:20;
 accuracyPercentage4_train = 1:20;
 accuracy4_val = 1:20;
 accuracyPercentage4_val = 1:20;
%Loop necessário para escolher o número de vizinhos entre 1 e 20(pelos testes o melhor valor de K é 1 para ambas as views.)
 for n = 1:20
    %Função KNN
    Mdl3_train = fitcknn(shape_view_train.data,Y3_train,'ClassNames',classNames,'Distance','euclidean','NumNeighbors',n);
    Mdl3_val = fitcknn(shape_view_val.data,Y3_val,'ClassNames',classNames,'Distance','euclidean','NumNeighbors',n);
    Mdl4_train = fitcknn(RGB_view_train.data,Y4_train,'ClassNames',classNames,'Distance','euclidean','NumNeighbors',n);
    Mdl4_val = fitcknn(RGB_view_val.data,Y4_val,'ClassNames',classNames,'Distance','euclidean','NumNeighbors',n);
    
    %Predict KNN
    predKNN1_train = predict(Mdl3_train,shape_view_train.data);
    predKNN1_val = predict(Mdl3_val,shape_view_val.data);
    predKNN2_train = predict(Mdl4_train,RGB_view_train.data);
    predKNN2_val = predict(Mdl4_val,RGB_view_val.data);
    %Accuracy in percentage
    accuracy3_train(n) = sum(strcmp(Y3_train,predKNN1_train)) / numel(Y3_train);
    accuracyPercentage3_train(n) = 100*accuracy3_train(n);
    accuracy3_val(n) = sum(strcmp(Y3_val,predKNN1_val)) / numel(Y3_val);
    accuracyPercentage3_val(n) = 100*accuracy3_val(n);
    accuracy4_train(n) = sum(strcmp(Y4_train,predKNN2_train)) / numel(Y4_train);
    accuracyPercentage4_train(n) = 100*accuracy4_train(n);
    accuracy4_val(n) = sum(strcmp(Y4_val,predKNN2_val)) / numel(Y4_val);
    accuracyPercentage4_val(n) = 100*accuracy4_val(n);
 end












