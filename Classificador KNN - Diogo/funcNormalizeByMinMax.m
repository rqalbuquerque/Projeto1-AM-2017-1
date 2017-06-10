function normData = funcNormalizeByMinMax(data)

    minVal = min(data);
    maxVal = max(data);
    normData = (data - minVal) / ( maxVal - minVal );

end