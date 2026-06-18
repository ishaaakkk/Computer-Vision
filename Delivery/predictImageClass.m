function [label, scores] = predictImageClass(imagePath)
    % 1) Load the trained model
    S = load('trainedClassifier.mat','trainedClassifier');
    trainedClassifier = S.trainedClassifier;
    predictorNames     = trainedClassifier.RequiredVariables;

    % 2) Read and resize
    img = imread(imagePath);
    img = imresize(img, [128 128]);

    % 3) Extract the 538-D feature vector
    % 3.1) Joint UV histogram
    hsvImg = rgb2hsv(img);
    H = hsvImg(:,:,1); S = hsvImg(:,:,2); V = hsvImg(:,:,3);
    Hrad = H * 2*pi;
    u = S.*cos(Hrad); v = S.*sin(Hrad);
    edgesUV = linspace(-1,1,17);
    jointUV = histcounts2(u(:), v(:), edgesUV, edgesUV);
    jointUV = jointUV / sum(jointUV(:));

    % 3.2) V histogram
    histV = histcounts(V, linspace(0,1,17));
    histV = histV / sum(histV);

    % 3.3) Stroke‐width histogram via black‐hat
    grayImg = im2gray(img);
    se       = strel('disk',5);
    blackh   = imbothat(grayImg, se);
    bwStroke = imbinarize(blackh,'adaptive', ...
                          'ForegroundPolarity','dark', ...
                          'Sensitivity',0.4);
    bwStroke = imopen(bwStroke, strel('line',3,0));
    bwStroke = imclose(bwStroke, strel('line',5,90));
    skel     = bwskel(bwStroke);
    dt       = bwdist(~bwStroke);
    widths   = 2 * dt(skel);
    widths(widths>20) = 20;
    edgesSW  = linspace(0,20,11);
    histSW   = histcounts(widths, edgesSW);
    if ~isempty(widths), histSW = histSW / sum(histSW); end

    % 3.4) Manual LBP 3×3
    gray8 = im2uint8(grayImg);
    [hgt,wid] = size(gray8);
    lbpImage = zeros(hgt,wid,'uint8');
    for y = 2:hgt-1
        for x = 2:wid-1
            c = gray8(y,x);
            n = [gray8(y-1,x-1), gray8(y-1,x),   gray8(y-1,x+1), ...
                 gray8(y,  x+1), gray8(y+1,x+1), gray8(y+1,x),   ...
                 gray8(y+1,x-1), gray8(y,  x-1)];
            code = uint8(sum((n>=c).*2.^(0:7)));
            lbpImage(y,x) = code;
        end
    end
    lbpHist = histcounts(lbpImage(:), 0:256);
    if sum(lbpHist)>0, lbpHist = lbpHist / sum(lbpHist); end

    % 4) Concatenate into table
    featureVector = [ jointUV(:)' , histV , histSW , lbpHist ];
    T = array2table(featureVector, 'VariableNames', predictorNames);

    % 5) Predict
    [label, scores] = trainedClassifier.predictFcn(T);
end
