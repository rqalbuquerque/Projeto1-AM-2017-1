function [ vector_weights ] = weights( vector_matrix_dissimilarity,vector_prototypes,matrix_membership_degree, K,P,N,q )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
vector_weights = cell(7,1);
for k = 1 : K,
    
    for p = 1 : P,
        
        denominator = 0.0;
        for i = 1 : N,
            sum_denominator = 0.0;
            for g = 1 : q,
                sum_denominator = sum_denominator + vector_matrix_dissimilarity{p}(i,vector_prototypes{k}(g));
            end
            denominator = denominator + sum_denominator*(matrix_membership_degree(i,k)^1.6);
            
        end
        if denominator == 0,
            denominator = 0.0000000000000000000000000000000001;
        end
        
        vector_numerator = zeros(1,9);
        for h = 1: P,
            numerator = 0.0;
            for i = 1 : N,
                sum_numerator = 0.0;
                for g = 1 : q,
                    sum_numerator = sum_numerator + vector_matrix_dissimilarity{h}(i,vector_prototypes{k}(g));
                end
                numerator = numerator + sum_numerator*(matrix_membership_degree(i,k)^1.6);
            end
            if numerator == 0,
                numerator = 0.0000000000000000000000000000000001;
            end
            
            
            vector_numerator(h) = numerator;
        end
        
        vector_weights{k}(p) = (prod(vector_numerator)^(1/9))/denominator;
    end
    
end

end

