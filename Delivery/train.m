load("descriptorTable.mat", "descriptorTable");
T = descriptorTable;

[trainedClassifier, validationAccuracy] = trainClassifier(T(~T.IsTest,:));

save("trainedClassifier.mat", "trainedClassifier", "validationAccuracy");

fprintf('Train validation accuracy: %.2f%%\n', validationAccuracy*100);