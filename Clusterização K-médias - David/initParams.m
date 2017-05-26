function [ vector_weights, vector_prototypes ] = initParams(n,k )

vector_weights = cell(7,1);
vector_prototypes = cell(7,1);

radom_vector = randperm(n);
j = radom_vector(1);

%inicializando os parametros de peso e de prototipos
for i = 1: k,
    vector_prototypes{i} = [radom_vector(j) radom_vector(j+1) radom_vector(j+2)];
    vector_weights{i} = ones(1,2); 
    j = radom_vector(i+1);
end

end

