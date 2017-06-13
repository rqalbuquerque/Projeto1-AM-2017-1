function [ vector_weights ] = weights( vector_matrix_dissimilarity,vector_prototypes,matrix_membership_degree, K,N,q )

vector_weights = cell(7,1);

for k = 1 : K
    for j = 1 : 2
        %armazena o valor do denominador da equação que esta fixa em uma
        %unica view 
        denominator = 0.0;
        for i = 1 : N
            %armazena os valores da dissimilaridade de uma determinada view
            %fixada referente a um determinado objeto do conjunto de dados
            sum_denominator = 0.0;
            for g = 1 : q
                sum_denominator = (sum_denominator + (vector_matrix_dissimilarity{j}(i,vector_prototypes{k}(g))));
            end
            %armazena o valor do somatorio assima mutiplizado pela matriz
            %de pertinencia de cada objeto referente a um determinado
            %cluster
            denominator = (denominator + (sum_denominator*(matrix_membership_degree(i,k)^(1.6))));
        end
       
        mult = 1.0;
        for h = 1: 2
            %armazena o valor do numerador da equação que percorre as duas
            %views
            numerator = 0.0;
            for i = 1 : N
                %armazena os valores da dissimilaridade de uma determinada view
                %referente a um determinado objeto do conjunto de dados
                sum_numerator = 0.0;
                for g = 1 : q
                    sum_numerator = (sum_numerator + (vector_matrix_dissimilarity{h}(i,vector_prototypes{k}(g))));
                end
                %armazena o valor do somatorio assima mutiplicado pela matriz
                %de pertinencia de cada objeto referente a um determinado
                %cluster
                numerator = (numerator + (sum_numerator*(matrix_membership_degree(i,k)^(1.6))));
            end
            
            %realiza a mutiplicação do numerador 
            mult = mult * numerator;
        end
        %armazena o valor do peso de uma determinada view
        vector_weights{k}(j) = ((mult^(1/2))/denominator);
    end
    
end

end

