% Classificador Bayseano 
% Estimativa de parametros baseada em maxima verossimilhanca

%Limpa variáveis
clc; clear;

%Carrega base de dados
rgb_view_Path = '..\\Data Base Image Segmentation\\RGB_view_order.csv';
RGB_view_db = load_data_base(rgb_view_Path);

%Declaração das classes na ordem que aparecem nos dados
% TODO - automatizar obtenção dos nomes das classes
classNames = {'BRICKFACE'; 'CEMENT'; 'FOLIAGE'; 'GRASS'; 'PATH'; 'SKY'; 'WINDOW'};

%Particiona os dados de entrada
M = size(RGB_view_db.data(:,1),1);
d = size(RGB_view_db.data(1,:),2);
C = size(classNames,1);
classSamplesMap = partitions_data(RGB_view_db,classNames');

% -------------------------------- Treino --------------------------------

%Probabilidade a Priori
priori_prob = zeros(C,1);
for i=1:C
    indexes = classSamplesMap(i);
    priori_prob(i) = length(indexes)/M;
end

%Probabilidade a Posteriori
MU = zeros(C,d);
SIGMA = zeros(C,d);
for i=1:C
    indexes = classSamplesMap(i);
    MU(i,:) = mean(RGB_view_db.data(indexes,:));
    SIGMA(i,:) = std(RGB_view_db.data(indexes,:));
end

density = zeros(C,1);
for i=1:C
    density(i) = mvnpdf(RGB_view_db.data(1199,:),MU(i,:),SIGMA(i,:));
end

for i=1:C
    (density(i)*priori_prob(i))/((density')*priori_prob)
end

%Gera os folds de treinamento e teste
%k = 10;
%[RGB_view_train, RGB_view_test] = generate_folds(RGB_view_db, k);
%[shape_view_train, shape_view_test] = generate_folds(shape_view_db, k);


