function prediction = PredictUsingMulticlassNaiveBayes(nayve_bayes_model, data_test, class_names)
    %% Variáveis
    M = size(data_test,1);
    C = size(class_names,1);

    %% -------------------------------- Predição --------------------------------

	prediction = cell(M,1);
    p_x_w = zeros(C,1);
    p_w = nayve_bayes_model.priori_prob;
    MU = nayve_bayes_model.mu;
    SIGMA = nayve_bayes_model.sigma;
    
    %Probabilidade a posteriori
    for i=1:M

        x = cell2mat(data_test(i,2));

        for j=1:C
            p_x_w(j) = mvnpdf(x, MU(j,:), SIGMA(j,:)+eps);
        end

        p_w_x = (p_x_w .* p_w) ./ (p_x_w' * p_w);

        [~, idx] = max(p_w_x);

        prediction{i,1} = char(class_names{idx,1});
    end
    
end