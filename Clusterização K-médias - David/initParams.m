function [ vector_weights, vector_prototypes ,vector_matrix_dissimilarity ] = initParams( count,A )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
shape_view = zeros(2100,9);
RGB_view = zeros(2100,10);


vector_weights = cell(7,1);
vector_prototypes = cell(7,1);
vector_matrix_dissimilarity = cell(7,1);

i = 1;
svrow = 1;
rgbvrow = 1;

%initialization
while i < count,
    for sv = 1: 9,
        shape_view(svrow,sv) = A(i);
        i = i + 1;
        
    end
    for rgbv = 1:10
        RGB_view(rgbvrow,rgbv) = A(i);
        i = i + 1;
    end
    svrow = svrow +1;
    rgbvrow = rgbvrow + 1;
end


radom_vector = randperm(2100);
j = radom_vector(1);
%doing shape view

for i = 1: 9,
    D = pdist(shape_view(:,i),'euclidean');  % euclidean distance
    Matrix = squareform(D);  %matriz de dissmilaridade
    vector_matrix_dissimilarity{i} = Matrix;
end
for i = 1: 7,
    vector_prototypes{i} = [radom_vector(j) radom_vector(j+1) radom_vector(j+2)];
    vector_weights{i} = ones(1,9); %returns an vector of 9 index of ones .
    j = radom_vector(i+1);
end

end

