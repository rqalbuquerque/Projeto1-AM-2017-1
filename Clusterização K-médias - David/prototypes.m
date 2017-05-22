function [ vector_prototypes ] = prototypes( vector_matrix_dissimilarity,vector_weights,matrix_membership_degree,P,N,q )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
vector_prototypes_argmin = zeros(7,N);
vector_prototypes = cell(7,1);

for h = 1 : N,
    sum_object_1 = 0.0;
    sum_object_2 = 0.0;
    sum_object_3 = 0.0;
    sum_object_4 = 0.0;
    sum_object_5 = 0.0;
    sum_object_6 = 0.0;
    sum_object_7 = 0.0;
    
    for i = 1 : N,
        first_partial_1 = 0.0;
        first_partial_2 = 0.0;
        first_partial_3 = 0.0;
        first_partial_4 = 0.0;
        first_partial_5 = 0.0;
        first_partial_6 = 0.0;
        first_partial_7 = 0.0;
        
        for p = 1 : P,
            first_partial_1 = first_partial_1 + (vector_weights{1}(p)*vector_matrix_dissimilarity{p}(i,h));
            first_partial_2 = first_partial_2 + (vector_weights{2}(p)*vector_matrix_dissimilarity{p}(i,h));
            first_partial_3 = first_partial_3 + (vector_weights{3}(p)*vector_matrix_dissimilarity{p}(i,h));
            first_partial_4 = first_partial_4 + (vector_weights{4}(p)*vector_matrix_dissimilarity{p}(i,h));
            first_partial_5 = first_partial_5 + (vector_weights{5}(p)*vector_matrix_dissimilarity{p}(i,h));
            first_partial_6 = first_partial_6 + (vector_weights{6}(p)*vector_matrix_dissimilarity{p}(i,h));
            first_partial_7 = first_partial_7 + (vector_weights{7}(p)*vector_matrix_dissimilarity{p}(i,h));
        end
        
        sum_object_1 = sum_object_1 + ((matrix_membership_degree(i,1)^1.6)*first_partial_1);
        sum_object_2 = sum_object_2 + ((matrix_membership_degree(i,2)^1.6)*first_partial_2);
        sum_object_3 = sum_object_3 + ((matrix_membership_degree(i,3)^1.6)*first_partial_3);
        sum_object_4 = sum_object_4 + ((matrix_membership_degree(i,4)^1.6)*first_partial_4);
        sum_object_5 = sum_object_5 + ((matrix_membership_degree(i,5)^1.6)*first_partial_5);
        sum_object_6 = sum_object_6 + ((matrix_membership_degree(i,6)^1.6)*first_partial_6);
        sum_object_7 = sum_object_7 + ((matrix_membership_degree(i,7)^1.6)*first_partial_7);
    end
    
    vector_prototypes_argmin(1,h) = sum_object_1;
    vector_prototypes_argmin(2,h) = sum_object_2;
    vector_prototypes_argmin(3,h) = sum_object_3;
    vector_prototypes_argmin(4,h) = sum_object_4;
    vector_prototypes_argmin(5,h) = sum_object_5;
    vector_prototypes_argmin(6,h) = sum_object_6;
    vector_prototypes_argmin(7,h) = sum_object_7;
    
end

   

for g = 1:q,
    vector_prototypes_argmin
    [M,I] = min(vector_prototypes_argmin, [],2);
    
    I
    vector_prototypes{1}(g) =  I(1);
    vector_prototypes{2}(g) =  I(2);
    vector_prototypes{3}(g) =  I(3);
    vector_prototypes{4}(g) =  I(4);
    vector_prototypes{5}(g) =  I(5);
    vector_prototypes{6}(g) =  I(6);
    vector_prototypes{7}(g) =  I(7);
    
    vector_prototypes_argmin(1,I(1)) = 100000;
    vector_prototypes_argmin(2,I(2)) = 100000;
    vector_prototypes_argmin(3,I(3)) = 100000;
    vector_prototypes_argmin(4,I(4)) = 100000;
    vector_prototypes_argmin(5,I(5)) = 100000;
    vector_prototypes_argmin(6,I(6)) = 100000;
    vector_prototypes_argmin(7,I(7)) = 100000;
end

end

