%%
%Fun��o que aplica o Friedman test sobre o conjunto de elementos.
%Entrada:
% x     - matriz com o conjunto de valores para aplica��o do teste.
%         dimens�es: N x k 
%         Tipicamente: N - tamanhos do conjunto de dados
%                      k - n�mero de avalia��es
% conf  - n�vel de confian�a para a estat�stica de teste.
%Sa�da:
% pValue    - p-value para a estat�stica chi-square
% fEst      - estat�stica de teste
% cValue    - valor cr�tico da distribui��o F com k-1 e (k-1)(N-1) graus
%             de liberdade

%%
function [pValue, fEst, cValue, meanRanks] = funcApplyFriedmanTest(x, conf)
    
    [N, k] = size(x);
    cValue = 0;
    fEst = 0;
    
    % apply Friedman test
    [pValue,tbl,stats] = friedman(x, 1, 'off');
    
    % test estat�stic
    meanRanks = stats.meanranks;
    X2_F = (12*N/(k*k+k))*(sum(meanRanks.^2 - (k*(k+1)^2)/4));
    fEst = ((N-1)*X2_F) / (N*(k-1)-X2_F);
    
    % critical value
    cValue = finv(conf,k-1,(k-1)*(N-1));
end






