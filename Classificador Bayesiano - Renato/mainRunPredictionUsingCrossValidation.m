%% Script para teste dos classificadores Bayesianos utilizando Valida��o cruzada
% Valida��o cruzada estratificada

%% Limpa vari�veis
clc; clear;

%% Carrega base de dados
% TODO - automatizar a separa��o das views
rgb_view_Path = '../Data Base Image Segmentation/RGB_view_order.csv';
shape_view_Path = '../Data Base Image Segmentation/shape_view_order.csv';
rgb_view_db = LoadDataBase(rgb_view_Path);
shape_view_db = LoadDataBase(shape_view_Path);

%% Gera os folds
k = 10;
M = size(rg_view_db,1);
index_folds = GeneratesKFoldsIndexes(M,k);


