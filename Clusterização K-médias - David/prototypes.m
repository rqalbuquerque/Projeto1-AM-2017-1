function [ vector_prototypes ] = prototypes( vector_matrix_dissimilarity,vector_weights,matrix_membership_degree,N,K,q )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

vector_prototypes = cell(7,1);

for k = 1:K,
    
    for h = 1 : N,
        sum_object = 0.0;
        
        for i = 1 : N,
            first_partial = 0.0;
            
            for j = 1 : 2,
                first_partial = (first_partial + (vector_weights{k}(j)*vector_matrix_dissimilarity{j}(i,h)));
                
            end
            
            sum_object = (sum_object + ((matrix_membership_degree(i,k)^1.6)*first_partial));
            
        end
      
        vector_prototypes_argmin(h) = sum_object;
        
    end
    
    for g = 1:q,
   
    [M,I] = min(vector_prototypes_argmin);
  
    vector_prototypes{k}(g) =  I;
    vector_prototypes_argmin(I) = 100000000000000000000000000000000000000000000;
    end
end
    
end

   

