%Lendo os dados das views
%Dados das planilhas foram colocados em ordem de acordo com a classes
shape_view_order = 'D:\\UFPE\\Mestrado\\2017.1\\Aprendizagem de Máquina\\Francisco\\Projeto\\Dados\\shape_view_order.csv';
RGB_view_order = 'D:\\UFPE\\Mestrado\\2017.1\\Aprendizagem de Máquina\\Francisco\\Projeto\\Dados\\RGB_view_order.csv';
delimiterIn = ',';
headerlinesIn = 1;
RGB_view = importdata(RGB_view_order,delimiterIn,headerlinesIn);
shape_view = importdata(shape_view_order,delimiterIn,headerlinesIn);

%Dados da coluna das classes
Y1 = shape_view.textdata(2:2101,1);
Y2 = RGB_view.textdata(2:2101,1);
%frequency table of data in vector Y1 and Y2
tabulate(Y1)
tabulate(Y2)
%Declaração das classes na ordem que aparecem nos dados
classNames = {'BRICKFACE', 'CEMENT', 'FOLIAGE','GRASS', 'PATH', 'SKY','WINDOW'}; 
%Declaração das distribuições em cada variável
distribuition1 = {'normal','normal','normal','normal','normal','normal','normal','normal'};
distribuition2 = {'normal','normal','normal','normal','normal','normal','normal','normal','normal','normal'};
%Caso da variância zero na variável REGION-PIXEL-COUNT, a coluna é
%eliminada(solução encontrada no MATLAB Answers)
shape_view.data(:,3)=[];
%Função naive bayes
Mdl1 = fitcnb(shape_view.data,Y1,'ClassNames',classNames,'Distribution', distribuition1);
Mdl2 = fitcnb(RGB_view.data,Y2,'ClassNames',classNames,'Distribution', distribuition2);

%Predict of trained naive Bayes classifier
predNVB1 = predict(Mdl1,shape_view.data);
predNVB2 = predict(Mdl2,RGB_view.data);

%Accuracy in percentage
accuracy1 = sum(strcmp(Y1,predNVB1)) / numel(Y1);
accuracyPercentage1 = 100*accuracy1;
accuracy2 = sum(strcmp(Y2,predNVB2)) / numel(Y2);
accuracyPercentage2 = 100*accuracy2;
