function index_folds = GeneratesKFoldsIndexes(M, k)
    %% Vari�veis
    %Tamanho de cada fold
    n = ceil(M/k);

    %% Mistura os indices
    indexes = randperm(M);
    
    %% Gera os folds
    index_folds = buffer(indexes,n)';
    
end