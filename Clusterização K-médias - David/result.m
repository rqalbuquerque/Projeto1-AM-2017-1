function  result( best_matrix_membership_degree,best_vector_weights,final_j,shape_view )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
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
 hard_class = zeros(1,2100);
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
    
    [A I] = max([BRICKFACE,CEMENT,FOLIAGE,GRASS,PATH,SKY,WINDOW]);
    
    for k  =  1 : size
       hard_class(hard_partition{i}(k))  = I;  
    end
end

[AR,RI,MI,HI]=RandIndex(partition_original,hard_class);

fprintf('\nIndice de Rand Corrigido: %d\n',AR);

end

