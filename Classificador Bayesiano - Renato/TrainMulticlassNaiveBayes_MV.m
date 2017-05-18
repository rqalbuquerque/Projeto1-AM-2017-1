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

%Parametros da normal multivariada
MU = zeros(C,d);
SIGMA = zeros(C,d);
for i=1:C
    indexes = classSamples{i};
    MU(i,:) = mean(RGB_view_db.data(indexes,:));
    SIGMA(i,:) = var(RGB_view_db.data(indexes,:),1);
end

%Probabilidade a Priori
p_w = zeros(C,1);
for i=1:C
    indexes = classSamples{i};
    p_w(i) = length(indexes)/M;
end

%Probabilidade a posteriori
x = RGB_view_db.data(500,:);
p_x_w = zeros(C,1);
for i=1:C
	p_x_w(i) = calc_mvnpdf(x, MU(i,:), SIGMA(i,:));
end

p_w_x = zeros(C,1);
p_w_x = (p_x_w .* p_w) ./ (p_x_w' * p_w);

[value, index] = max(p_w_x);
index