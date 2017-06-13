function [ vector_prototypes ] = prototypes( vector_matrix_dissimilarity,vector_weights,matrix_membership_degree,N,K,q )

%vetor de protipos
vector_prototypes = cell(7,1);

for k = 1:K
    for h = 1 : N
        %armazena o resultado do argumento nos somatorios realizados
        sum_object = 0.0;
        
        for i = 1 : N
            %armazena os valores parcias de cada somatorio
            first_partial = 0.0;
            for j = 1 : 2
                %o valor parcial armazer o valor da dissimilaridade de
                %um determinado objeto em relação ao possivel prototipo
                %mutiplicado pelo peso da influencia da matriz de
                %dissimilaridade
                first_partial = (first_partial + (vector_weights{k}(j)*vector_matrix_dissimilarity{j}(i,h)));
            end
            %Armazena os valores  da mutiplicação da matriz de pertinencia
            %pelo valor parcial obtido anteriormente
            sum_object = (sum_object + ((matrix_membership_degree(i,k)^1.6)*first_partial));
            
        end
        
        %insere em um vetor de argumentos que será utilizado para obter os
        %prototipos que apresentaram menor argumento
        vector_prototypes_argmin(h) = sum_object;
        
    end
    
    %nesse laço são obtidos todos os prototipos que irão representar os
    %clusters
    for g = 1:q,
        
        % pega o argumento minimo da no vetor de argumentos, I indica o
        % protipo escolhido
        [M,I] = min(vector_prototypes_argmin);
        
        %insere o protipo ao cluster referente
        vector_prototypes{k}(g) =  I;
        vector_prototypes_argmin(I) = 10^30;
    end
end

end



