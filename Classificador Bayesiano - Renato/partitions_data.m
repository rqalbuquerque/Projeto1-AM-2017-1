function classIndexesMap = partitions_data(dataBase, classNames)

    c = size(classNames,2);
    n = size(dataBase.data(:,1),1);
    classNamesIndexesMap = containers.Map(classNames,num2cell(1:c));
    classIndexesMap = containers.Map(num2cell(1:c),cell(1,c));
    
    for i=1:n
        index = classNamesIndexesMap(char(dataBase.textdata(i+1,1)));
        indexes = [classIndexesMap(index) i];
        classIndexesMap(index) = indexes;
    end
    
end