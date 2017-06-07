function  result( best_matrix_membership_degree,best_vector_weights,final_j,shape_view ,vector_prototypes)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
fprintf('\n###### Prototipos ######\n');
for i = 1 : 7
    g = sprintf('%d ', vector_prototypes{i});
    fprintf('Group %d: [ %s ] \n',i,g );
end


fprintf('\n###### Vetor de Pesos ######\n');
for i = 1 : 7
    g = sprintf('%f ', best_vector_weights{i});
    fprintf('Group %d: %s \n',i,g );
end

fprintf('\n###### Melhor J ######\n');
fprintf('%f',final_j);

hard_partition = cell(7,1);
classNames = {'BRICKFACE', 'CEMENT', 'FOLIAGE','GRASS', 'PATH', 'SKY','WINDOW'};
array = shape_view.textdata(2:2101,1);

partition_original = zeros(1,2100);

for i = 1:2100
    [A I] = max(best_matrix_membership_degree(i,:));
    hard_partition{I} = [ hard_partition{I} i];
    str = array(i,1);
    index = find(strcmp(classNames,str));
    partition_original(i) = index;
end

fprintf('\n\n### Quantidade de Elementos em cada grupo da partição Hard ###\n');

for i = 1: 7
    fprintf('%d Group: %d \n',i, length(hard_partition{i}));
end
fprintf('\n');

fprintf('\n\n### Partição Exclusiva  ###\n');
contigency_table = zeros(7,7);
for i = 1:7
    size = length(hard_partition{i});
    BRICKFACE = 0;
    CEMENT = 0;
    FOLIAGE = 0;
    GRASS = 0;
    PATH = 0;
    SKY = 0;
    WINDOW = 0;
    
    for j = 1 : size
        
        if strcmp(array( hard_partition{i}(j)),'BRICKFACE')
            BRICKFACE = BRICKFACE + 1;
        elseif strcmp(array( hard_partition{i}(j)),'CEMENT')
            CEMENT = CEMENT +1;
        elseif strcmp(array( hard_partition{i}(j)),'FOLIAGE')
            FOLIAGE = FOLIAGE + 1;
        elseif strcmp(array( hard_partition{i}(j)),'GRASS')
            GRASS = GRASS +1;
        elseif strcmp(array( hard_partition{i}(j)),'PATH')
            PATH = PATH +1;
        elseif strcmp(array( hard_partition{i}(j)),'SKY')
            SKY = SKY +1;
        else
            WINDOW = WINDOW +1;
        end
    end
    
    fprintf('-------- %d GROUP ----------\n',i);
    fprintf('BRICKFACE: %d \n',BRICKFACE);
    fprintf('CEMENT: %d \n',CEMENT);
    fprintf('FOLIAGE: %d \n',FOLIAGE);
    fprintf('GRASS: %d \n',GRASS);
    fprintf('PATH: %d \n',PATH);
    fprintf('SKY: %d \n',SKY);
    fprintf('WINDOW: %d \n',WINDOW);
    fprintf('\n');
    
    
    contigency_table(i,1) = BRICKFACE;
    contigency_table(i,2) = CEMENT;
    contigency_table(i,3) = FOLIAGE;
    contigency_table(i,4) = GRASS;
    contigency_table(i,5) = PATH;
    contigency_table(i,6) = SKY;
    contigency_table(i,7) = WINDOW;
    
end

[indice]=RandIndex(contigency_table);

fprintf('\nIndice de Rand Corrigido: %d\n',indice);

end

