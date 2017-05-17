function classIndexes = partitions_data(dataBase, classNames)

	classNames = classNames';
	
    c = size(classNames,2);
    n = size(dataBase.data(:,1),1);
    classIndexes = cell(c,1);
    
    for i=1:n
        c = cell2mat(dataBase.textdata(i+1,1));
        index = find(strcmp(classNames, c));
        classIndexes(index) = [classIndexes{index} i];
    end
    
end