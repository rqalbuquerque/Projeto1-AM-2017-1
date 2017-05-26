
%Lendo os dados das views
%Dados das planilhas foram colocados em ordem de acordo com a classes
shape_view_order = '../Data Base Image Segmentation/shape_view_order.csv';
RGB_view_order = '../Data Base Image Segmentation/RGB_view_order.csv';
delimiterIn = ',';
headerlinesIn = 1;
%obtendo as views que serão utilizadas para obter a partição
RGB_view = importdata(RGB_view_order,delimiterIn,headerlinesIn);
shape_view = importdata(shape_view_order,delimiterIn,headerlinesIn);

%criando a celular para armzenar as matrizes de dissmilaridade
vector_matrix_dissimilarity = cell(2,1);

%obtendo a matriz de dissmilaridade para cada view
vector_matrix_dissimilarity{1} = squareform(pdist(shape_view.data,'euclidean'));  % euclidean distance
vector_matrix_dissimilarity{2} = squareform(pdist(RGB_view.data,'euclidean'));  % euclidean distance 


f = [];
% Inicialização
[ vector_weights, vector_prototypes] = initParams(2100,7);

% Matriz de Pertinencia
matrix_membership_degree = pertinence( vector_matrix_dissimilarity,vector_prototypes,vector_weights,7,2100,3);

for iterator = 1 : 5,
    
    % Calculate Objective
    J = objective( vector_matrix_dissimilarity,vector_prototypes,vector_weights,matrix_membership_degree, 7,2100,3 );
    
    f = [f J];
    
    % calculate prototypes
    vector_prototypes = prototypes( vector_matrix_dissimilarity,vector_weights,matrix_membership_degree,2100,7,3);
    % calculate vectors weights
    vector_weights = weights( vector_matrix_dissimilarity,vector_prototypes,matrix_membership_degree, 7,2100,3 );

    % test calculate weights vector
    sum_weights = 0;
    for i = 1:7,
        sum_weights = sum_weights + prod(vector_weights{1});
    end
    sum_weights
    
    % Pertinence Matrix
    matrix_membership_degree = pertinence( vector_matrix_dissimilarity,vector_prototypes,vector_weights, 7,2100,3);
    
    
  
end

J = objective( vector_matrix_dissimilarity,vector_prototypes,vector_weights,matrix_membership_degree, 7,2100,3 );
f = [f J];

    