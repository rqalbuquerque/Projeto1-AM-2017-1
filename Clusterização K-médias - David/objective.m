function [ result ] = objective( vector_matrix_dissimilarity,vector_prototypes,vector_weights,matrix_membership_degree, K,P,N,q )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
result = 0.0;
    for k = 1 : K,
        sum_object = 0.0;
        for i = 1 : N,
            first_partial = 0.0;
            sum_distance = 0.0;
            for p = 1 : P,
                for g = 1 : q,
                    sum_distance = sum_distance + vector_matrix_dissimilarity{p}(i,vector_prototypes{k}(g));
                end
                first_partial = first_partial + vector_weights{k}(p)*sum_distance;
            end
            sum_object = sum_object + (matrix_membership_degree(i,k)^1.6)*first_partial;
        end
        result = result +sum_object;
    end

end

