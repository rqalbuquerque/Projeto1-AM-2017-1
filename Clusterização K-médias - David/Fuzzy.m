%Lendo os dados das views
%Dados das planilhas foram colocados em ordem de acordo com a classes
shape_view_order = '../Data Base Image Segmentation/shape_view_order.csv';
RGB_view_order = '../Data Base Image Segmentation/RGB_view_order.csv';
delimiterIn = ',';
headerlinesIn = 1;
%obtendo as views que ser�o utilizadas para obter a parti��o
RGB_view = importdata(RGB_view_order,delimiterIn,headerlinesIn);
shape_view = importdata(shape_view_order,delimiterIn,headerlinesIn);
hard_partition = cell(7,1);
%criando a celular para armzenar as matrizes de dissmilaridade
vector_matrix_dissimilarity = cell(2,1);

%obtendo a matriz de dissmilaridade para cada view
vector_matrix_dissimilarity{1} = squareform(pdist(shape_view.data,'euclidean'));  % euclidean distance
vector_matrix_dissimilarity{2} = squareform(pdist(RGB_view.data,'euclidean'));  % euclidean distance

%condi��o de parada
epson = 10^(-5);

%agrupa os valores da fun��o objetivo
f = [];

for aplic = 1: 1
    % Inicializa��o
    [ vector_weights, vector_prototypes] = initParams(2100,7);
    fprintf('\n###### Prototipos ######\n');
    for i = 1 : 7
        g = sprintf('%d ', vector_prototypes{i});
        fprintf('Group %d: [ %s ] \n',i,g );
    end
    
    % Matriz de Pertinencia
    matrix_membership_degree = pertinence( vector_matrix_dissimilarity,vector_prototypes,vector_weights,7,2100,3);
    
    %calculate objective
    J = objective( vector_matrix_dissimilarity,vector_prototypes,vector_weights,matrix_membership_degree, 7,2100,3 );
    f = [f J];
    J
    for iterator = 1 : 20
        
        % calculate prototypes
        vector_prototypes = prototypes( vector_matrix_dissimilarity,vector_weights,matrix_membership_degree,2100,7,3);
        fprintf('\n###### Prototipos ######\n');
        for i = 1 : 7
            g = sprintf('%d ', vector_prototypes{i});
            fprintf('Group %d: [ %s ] \n',i,g );
        end
        % calculate vectors weights
        vector_weights = weights( vector_matrix_dissimilarity,vector_prototypes,matrix_membership_degree, 7,2100,3 );
        fprintf('\n###### Vetor de Pesos ######\n');
        for i = 1 : 7
            g = sprintf('%f ', vector_weights{i});
            fprintf('Group %d: %s \n',i,g );
        end
        % Pertinence Matrix
        matrix_membership_degree = pertinence( vector_matrix_dissimilarity,vector_prototypes,vector_weights, 7,2100,3);
        
        %calculate objective
        J = objective( vector_matrix_dissimilarity,vector_prototypes,vector_weights,matrix_membership_degree, 7,2100,3 );
        f = [f J];
        J
        
        if abs(f(iterator) - J) < epson
            iterator = 20;
        end
        
    end
    
    %caso for a primeira aplica��o aramazenar o primeiro J, caso contrario
    %ir� comparar os demais J's obtidos nas demais aplica��es para se obter
    %o melhor
    if aplic == 1
        best_vector_prototypes = vector_prototypes;
        best_vector_weights = vector_weights;
        best_matrix_membership_degree = matrix_membership_degree;
        best_J = f;
        final_j = J;
    else
        if final_j > J
            best_vector_prototypes = vector_prototypes;
            best_vector_weights = vector_weights;
            best_matrix_membership_degree = matrix_membership_degree;
            best_J = f;
            final_j = J;
        end
    end
    
    fprintf('\nAplica��o %d: %f\n',aplic,J);
    
    f = [];
    
    
end

%retorna o resultado da melhor parti��o
result( best_matrix_membership_degree,best_vector_weights,final_j,shape_view);



    