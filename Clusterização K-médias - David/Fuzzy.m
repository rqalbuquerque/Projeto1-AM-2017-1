
f = [];

fid = fopen('data.txt','r');

fmt=['%*s' repmat('%f',1,19)];
[A,count] = fscanf(fid,fmt);

% Initialization
[ vector_weights, vector_prototypes ,vector_matrix_dissimilarity ] = initParams( count,A );

% Pertinence Matrix
matrix_membership_degree = pertinence( vector_matrix_dissimilarity,vector_prototypes,vector_weights, 7,9,2100,3);
% test calculate pertinence matrix
sum_pertinence = sum(matrix_membership_degree,2);
sum_pertinence = sum(sum_pertinence);
sum_pertinence


for iterator = 1 : 1,
    % Calculate Objective
    J = objective( vector_matrix_dissimilarity,vector_prototypes,vector_weights,matrix_membership_degree, 7,9,2100,3 );
    f = [f J];
    f
    % calculate vectors weights
    vector_weights = weights( vector_matrix_dissimilarity,vector_prototypes,matrix_membership_degree, 7,9,2100,3 );

    % test calculate weights vector
    sum_weights = 0;
    for i = 1:7,
        sum_weights = sum_weights + prod(vector_weights{1});
    end
    sum_weights

    % calculate prototypes
    vector_prototypes = prototypes( vector_matrix_dissimilarity,vector_weights,matrix_membership_degree,9,10,3 );
    
    % Pertinence Matrix
    matrix_membership_degree = pertinence( vector_matrix_dissimilarity,vector_prototypes,vector_weights, 7,9,2100,3);
    % test calculate pertinence matrix
    sum_pertinence = sum(matrix_membership_degree,2);
    sum_pertinence = sum(sum_pertinence);
    sum_pertinence
  
end














