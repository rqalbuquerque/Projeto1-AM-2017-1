%% Script para teste dos classificadores Bayesianos
% Estimativa de parametros baseada em maxima verossimilhança

%% Limpa variáveis
clc; clear;

%% Carrega base de dados
% TODO - automatizar a separação das views
rgb_view_Path = '../Data Base Image Segmentation/RGB_view_order.csv';
shape_view_Path = '../Data Base Image Segmentation/shape_view_order.csv';
rgb_view_db = LoadDataBase(rgb_view_Path);
shape_view_db = LoadDataBase(shape_view_Path);

%% Declaração das classes na ordem que aparecem nos dados
% TODO - automatizar obtenção dos nomes das classes
class_names = {'BRICKFACE'; 'CEMENT'; 'FOLIAGE'; 'GRASS'; 'PATH'; 'SKY'; 'WINDOW'};

%% Treinamento dos modelos
nb_model_rgbView = TrainMulticlassNaiveBayes(rgb_view_db,class_names);
nb_model_shapeView = TrainMulticlassNaiveBayes(shape_view_db,class_names);

%% Predição utilizando os modelos
pred_nb_rgbView = PredictUsingMulticlassNaiveBayes(nb_model_rgbView, rgb_view_db, class_names);
pred_nb_shapeView = PredictUsingMulticlassNaiveBayes(nb_model_shapeView, shape_view_db, class_names);

%% Acurácia em porcetagem
% RGB view
rgb_view_gt = rgb_view_db(:,1);
accuracy1 = sum(strcmp(rgb_view_gt,pred_nb_rgbView)) / numel(rgb_view_gt);
accuracyPercentage1 = 100*accuracy1
% Shape View
shape_view_gt = shape_view_db(:,1);
accuracy2 = sum(strcmp(shape_view_gt,pred_nb_shapeView)) / numel(shape_view_gt);
accuracyPercentage2 = 100*accuracy2
