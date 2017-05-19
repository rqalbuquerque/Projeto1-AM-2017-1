function data_base = LoadDataBase(path_file)
        
    delimiterIn = ',';
    headerlinesIn = 1;
    db = importdata(path_file,delimiterIn,headerlinesIn);
    
    M = size(db.data,1);
    data_base = cell(M,2);
    
    for i=1:M
       data_base(i,:) = {db.textdata{i+1}, [db.data(i,:)]};
    end
end