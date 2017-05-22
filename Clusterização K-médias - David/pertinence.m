function [ matrix_membership_degree ] = pertinence( vector_matrix_dissimilarity,vector_prototypes,vector_weights, K,P,N,q)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
   matrix_membership_degree = zeros(2100,K);
for k = 1: K,   
   for i = 1 : N,
        sum_finish = 0.0;
        for h = 1: K,
            sum_numerator = 0.0;
            sum_denominator = 0.0;
            numerator = 0.0;
            denominator = 0.0;
            
            for p = 1 : P,
                for g = 1 : q,
                    sum_numerator = sum_numerator + vector_matrix_dissimilarity{p}(i,vector_prototypes{k}(g));
                    sum_denominator = sum_denominator + vector_matrix_dissimilarity{p}(i,vector_prototypes{h}(g));
                end
                numerator = numerator + vector_weights{k}(p)*sum_numerator;
                denominator = denominator + vector_weights{h}(p)*sum_denominator;
                partial = (numerator/denominator)^(1.0/(1.6-1.0));
            end
            
            sum_finish = sum_finish + partial;
        end
        matrix_membership_degree(i,k) =  sum_finish^(-1);
        
    end

end

