function [ result ] = objective( vector_matrix_dissimilarity,vector_prototypes,vector_weights,matrix_membership_degree, K,N,q )
 %armazena o resultado do argumento nos somatorios realizados
result = 0.0;
    for k = 1 : K,
        sum_object = 0.0;
        for i = 1 : N,
            first_partial = 0.0;
            sum_distance = 0.0;
            for j = 1 : 2,
                for g = 1 : q,
                    %o valor sum_distance armazena o valor da dissimilaridade de
                    %um determinado objeto em relação aos prototipos de um
                    %determinado cluster
                    
                    sum_distance = (sum_distance + (vector_matrix_dissimilarity{j}(i,vector_prototypes{k}(g))));
                end
                %multiplica os valores do vetor de pesos de um determinado
                %cluster pelo valor obtido em sum_distance
                first_partial = (first_partial + (vector_weights{k}(j)*sum_distance));
            end
            %mutiplica a pertinencia desse objeto a um determinado cluster
            %em relação ao valor armazenado em first_partial
            sum_object = (sum_object + ((matrix_membership_degree(i,k)^(1.6))*first_partial));
        end
        %armazena os valors de cada um dos clusters
        result = result + sum_object;
    end

end

