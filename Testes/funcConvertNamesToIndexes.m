function indexes = funcConvertNamesToIndexes(x, names)
    
    nSamples = length(x);
    nNames = length(names);
    indexes = zeros(size(x));

    for n=1:nSamples
       for i=1:nNames
           if(strcmp(x(n),names(i)))
               indexes(n) = i;
           end
       end
    end

end