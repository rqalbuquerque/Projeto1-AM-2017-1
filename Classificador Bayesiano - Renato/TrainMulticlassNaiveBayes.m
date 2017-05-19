function model = TrainMulticlassNaiveBayes(data_base, class_names)
    %% Particiona os dados de entrada
    M = size(data_base,1);
    d = size(data_base{1,2},2);
    C = size(class_names,1);
    class_samples = PartitionsData(data_base,class_names);

    %% -------------------------------- Treino --------------------------------

    %Parametros da normal multivariada
    MU = zeros(C,d);
    SIGMA = zeros(C,d);
    for i=1:C
        indexes = class_samples{i};
        MU(i,:) = mean(cell2mat(data_base(indexes,2)));
        SIGMA(i,:) = var(cell2mat(data_base(indexes,2)),1);
    end

    %Probabilidade a Priori
    priori_prob = zeros(C,1);
    for i=1:C
        indexes = class_samples{i};
        priori_prob(i) = length(indexes)/M;
    end
    
    %Construção do modelo
    model = struct('priori_prob',priori_prob,'mu',MU,'sigma',SIGMA);
end