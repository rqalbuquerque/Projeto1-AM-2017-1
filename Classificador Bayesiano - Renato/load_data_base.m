function data = load_data_base(path_file)

    delimiterIn = ',';
    headerlinesIn = 1;
    data = importdata(path_file,delimiterIn,headerlinesIn);
    
end