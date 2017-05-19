%% Script para teste dos classificadores Bayesianos utilizando Validação cruzada
% Validação cruzada estratificada

%% Limpa variáveis
clc; clear;

%% Carrega base de dados
% TODO - automatizar a separação das views
rgb_view_Path = '../Data Base Image Segmentation/RGB_view_order.csv';
shape_view_Path = '../Data Base Image Segmentation/shape_view_order.csv';
rgb_view_db = LoadDataBase(rgb_view_Path);
shape_view_db = LoadDataBase(shape_view_Path);

%% Gera os folds
k = 10;
M = size(rg_view_db,1);
index_folds = GeneratesKFoldsIndexes(M,k);


