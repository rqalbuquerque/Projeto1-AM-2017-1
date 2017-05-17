% Classificador Bayseano 
% Estimativa de parametros baseada em maxima verossimilhanca

%Limpa variáveis
clc; clear;

%Carrega base de dados
rgb_view_Path = '../Data Base Image Segmentation/RGB_view_order.csv';
RGB_view_db = load_data_base(rgb_view_Path);

%Declaração das classes na ordem que aparecem nos dados
% TODO - automatizar obtenção dos nomes das classes
classNames = {'BRICKFACE'; 'CEMENT'; 'FOLIAGE'; 'GRASS'; 'PATH'; 'SKY'; 'WINDOW'};

%Particiona os dados de entrada
M = size(RGB_view_db.data(:,1),1);
d = size(RGB_view_db.data(1,:),2);
C = size(classNames,1);
classSamples = partitions_data(RGB_view_db,classNames);

% -------------------------------- Treino --------------------------------

%Probabilidade a Priori
priori_prob = zeros(C,1);
for i=1:C
    indexes = classSamples{i};
    priori_prob(i) = length(indexes)/M;
end

%Probabilidade a Posteriori
MU = zeros(C,d);
SIGMA = zeros(C,d);
for i=1:C
    indexes = classSamples{i};
    MU(i,:) = mean(RGB_view_db.data(indexes,:));
    SIGMA(i,:) = std(RGB_view_db.data(indexes,:));
end

density = zeros(C,1);
for i=1:C
	X = RGB_view_db.data(2000,:);
	density(i) = (2*pi)^(-d/2) * exp (-sumsq ((X-MU(i,:))/SIGMA(i,:), 2)/2) / prod (SIGMA(i,:));
    %density(i) = mvnpdf(RGB_view_db.data(1199,:),MU(i,:),SIGMA(i,:));
end

density
for i=1:C
    (density(i)*priori_prob(i))/((density')*priori_prob)
end
