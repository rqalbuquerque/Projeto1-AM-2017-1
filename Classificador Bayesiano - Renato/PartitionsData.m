function class_indexes = PartitionsData(data_base, class_names)
    %% Variáveis
	class_names = class_names';
    c = size(class_names,2);
    M = size(data_base,1);
    class_indexes = cell(c,1);
    
    %% Particiona os dados por classe
    for i=1:M
        c = data_base{i,1};
        index = find(strcmp(class_names, c));
        class_indexes{index} = [class_indexes{index} i];
    end
    
end