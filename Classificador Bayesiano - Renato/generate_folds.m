function [train, test] = generate_folds(data, k)

    train = {};
    test = {};

    %Tamanho de cada fold
    n = floor(size(data,1)/k);

    %Mistura os dados
    ordering = randperm(size(data,1));
    data_shuffled = data(ordering,:);
    
    %Gera os folds
    for i=1:k-1
        train(i,:,:) = data_shuffled((i-1)*n+1:i*n,:);
    end
    test(1,:,:) = data_shuffled((k-1)*n+1:end,:);

end