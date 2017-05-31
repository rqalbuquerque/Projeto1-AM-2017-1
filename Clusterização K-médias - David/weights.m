function [ vector_weights ] = weights( vector_matrix_dissimilarity,vector_prototypes,matrix_membership_degree, K,N,q )
%UNTITLED4 Summary of this function goes here
%Detailed explanation goes here

vector_weights = cell(7,1);

for k = 1 : K,
    for j = 1 : 2,
        denominator = 0.0;
        for i = 1 : N,
            sum_denominator = 0.0;
            for g = 1 : q,
                sum_denominator = (sum_denominator + (vector_matrix_dissimilarity{j}(i,vector_prototypes{k}(g))));
            end
            denominator = (denominator + (sum_denominator*(matrix_membership_degree(i,k)^(1.6))));
        end
       
        mult = 1.0;
        for h = 1: 2,
            numerator = 0.0;
            for i = 1 : N,
                sum_numerator = 0.0;
                for g = 1 : q,
                    sum_numerator = (sum_numerator + (vector_matrix_dissimilarity{h}(i,vector_prototypes{k}(g))));
                end
                numerator = (numerator + (sum_numerator*(matrix_membership_degree(i,k)^(1.6))));
            end
            
            mult = mult * numerator;
        end
        
        vector_weights{k}(j) = ((mult^(1/2))/denominator);
    end
    
end

end

