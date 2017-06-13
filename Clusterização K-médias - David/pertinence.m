function [ matrix_membership_degree ] = pertinence( vector_matrix_dissimilarity,vector_prototypes,vector_weights, K,N,q)

matrix_membership_degree = zeros(2100,K);

for k = 1: K   
   for i = 1 : N
        sum_finish = 0.0;
        for h = 1: K
            %armazena os valores parcias dos somatorios do numerador da função
            sum_numerator = 0.0;
            %armazena os valores parcias dos somatorios do denominador da função
            sum_denominator = 0.0;
            %armazena os valor do numerador da função
            numerator = 0.0;
            %armazena os valor do denominador da função
            denominator = 0.0;
            
            for j = 1 : 2,
                for g = 1 : q,
                    %tanto o sum_numerator e sum_denominator armazenam os valores da dissimilaridade de
                    %um determinado objeto em relação aos prototipos de um
                    %determinado cluster
                    sum_numerator = (sum_numerator + (vector_matrix_dissimilarity{j}(i,vector_prototypes{k}(g))));
                    sum_denominator = (sum_denominator + (vector_matrix_dissimilarity{j}(i,vector_prototypes{h}(g))));
                end
                % o numerador e o denominador armazenam os valores da
                % mutiplicação do vetor de pesos de um determinado cluster
                % em relação ao resultado obtido anteriormente
                numerator = (numerator + (vector_weights{k}(j)*sum_numerator));
                denominator = denominator + (vector_weights{h}(j)*sum_denominator);
            end
            %Armzena o resultado parcial da pertinencia do objeto relativo
            %a um determinado cluster
            partial = ((numerator/denominator)^(1.0/(1.6-1.0)));
            
            sum_finish = sum_finish + partial;
        end
        %obtem a pertinencia de um determinado objeto a um determinado
        %cluster
        matrix_membership_degree(i,k) =  (sum_finish^(-1));
        
    end

end

