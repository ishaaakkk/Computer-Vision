load("trainedClassifier.mat", "trainedClassifier", "validationAccuracy");
load("descriptorTable.mat", "descriptorTable");
T = descriptorTable;

M            = 16;
Vbins        = 16;
numSWbins    = 10;
lbpBins      = 256;
numBins      = M^2 + Vbins + numSWbins + lbpBins;

predictorNames = arrayfun(@(k) sprintf('histograms%d',k), 1:numBins, ...
    'UniformOutput', false);

mask = T.IsTest == 1;

testData = T(mask, :);

[yfit,scores] = trainedClassifier.predictFcn(testData);

trueLabels = testData.Class;

testAccuracy = mean(yfit == trueLabels);

fprintf('Test set accuracy: %.2f%%\n', testAccuracy*100);

figure;
h = confusionchart(trueLabels, yfit);
h.Title = 'Confusion Matrix on Test Set';
h.RowSummary = 'row-normalized';       % show per-class recall on the right
h.ColumnSummary = 'column-normalized'; % show per-class precision on the bottom

[confMat, classOrder] = confusionmat(trueLabels, yfit);

recallPerClass = diag(confMat) ./ sum(confMat, 2);

fprintf('Per‐class recall:\n');
for k = 1:numel(classOrder)
    fprintf('  %s: %.2f%%\n', string(classOrder(k)), recallPerClass(k)*100);
end

macroRecall = mean(recallPerClass);
fprintf('Macro‐averaged recall: %.2f%%\n', macroRecall*100);