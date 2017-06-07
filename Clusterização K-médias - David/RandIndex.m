function [adjusted_index]=RandIndex(contigency_table)
    total = 2100;
    index = 0.0;
   
    for i = 1 : 7
        result = 0.0;
       for j = 1: 7 
           n = contigency_table(i,j);
           result = result + ((n*(n-1))/2);
       end
       index = index + result;
    end
    
    expected_index = 0.0;
    second_partial = 0.0;
    for i = 1 : 7
       first_partial = 0.0;
       for j = 1: 7 
           n = sum(contigency_table(:,j));
           first_partial = first_partial + ((n*(n-1))/2);
       end
       n = sum(contigency_table(i,:));
       second_partial = second_partial + (((n*(n-1))/2) * first_partial) ;
    end
    expected_index = (second_partial / ((total*(total-1))/2));
    
    
    max_index = 0.0;
    first_partial = 0.0;
    for i = 1: 7 
        n = sum(contigency_table(i,:));
        first_partial = first_partial + ((n*(n-1))/2);
    end
    
    second_partial = 0.0;
    for j = 1: 7 
        n = sum(contigency_table(:,j));
        second_partial = second_partial + ((n*(n-1))/2);
    end
    
    
    max_index = (0.5 * (first_partial + second_partial ));
    
    
    adjusted_index = ((index - expected_index) / (max_index - expected_index));
end

