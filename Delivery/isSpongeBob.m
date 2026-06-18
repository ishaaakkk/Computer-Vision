function result = isSpongeBob(imagePath)
    % ------------ PARAMETERS ------------
    scaleFactor     = 3;    % ROI was drawn on 2× image
    patchSizeOrig   = 16;   % half-width in original pixels
    edgeWeight      = 3.0;  % Sobel orientation weight
    MetricThreshRef = 1000;  % stronger SURF threshold for reference
    MetricThreshTr  = 1000;  % for training
    maxStrongPts    = 400;  % keep only top 500 SURF points
    matchThresh     = 0.4;  
    maxRatio        = 0.80; 
    sandVThresh     = 0.90; % skip bright yellow patches (sand)
    SThresh         = 0.30;
    edgesH = [0.00, 0.05, 0.07, 0.09, 0.1, 0.13, 0.21, 0.25, 0.3, 0.35, 0.4, 0.45, 0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85, 0.90, 0.95, 1.00];  % custom hue bins
    numEdgeBins = 4;                  % 4 Sobel orientation bins
    keypointThreshold = 9;
    % --------------------------------------

    %% 1) LOAD & INVERT ROI FOR ORIGINAL REFERENCE
    refPath = './SPONGE_BOB14141.jpg';
    assert(isfile(refPath), 'Reference image not found: %s', refPath);

    IrefRGB = imread(refPath);
    IrefGray= im2single(rgb2gray(IrefRGB));

    % Load ROI drawn on 3× reference
    refROIfile = './SPONGE_BOB14141_ROI.mat';
    assert(isfile(refROIfile), 'Missing refROI.mat (must contain polyVerts in 3× coords).');
    data = load(refROIfile, 'polyVerts');
    polyVerts2x = data.polyVerts;  % N×2 [x y] in 3× image

    % Divide by scaleFactor to get ROI in original resolution
    polyVertsOrig = round(polyVerts2x / scaleFactor);

    % Build binary mask on original reference size
    [hRef, wRef, ~] = size(IrefRGB);
    maskRef = poly2mask(polyVertsOrig(:,1), polyVertsOrig(:,2), hRef, wRef);

    %% 2) DETECT & FILTER REFERENCE KEYPOINTS (original res)
    ptsRefAll = detectSURFFeatures(IrefGray, ...
                   'MetricThreshold', MetricThreshRef, ...
                   'NumOctaves',     4, ...
                   'NumScaleLevels', 4 );
    assert(ptsRefAll.Count>0, 'No SURF keypoints on reference; lower MetricThreshold.');
    ptsRefAll = selectStrongest(ptsRefAll, maxStrongPts);

    locsRef = round(ptsRefAll.Location);  % M×2 [x y]
    M = size(locsRef,1);
    keepRef = false(M,1);
    for i = 1:M
        x = locsRef(i,1);
        y = locsRef(i,2);
        if x>=1 && x<=wRef && y>=1 && y<=hRef && maskRef(y,x)
            keepRef(i) = true;
        end
    end
    ptsRefROI = ptsRefAll(keepRef);
    assert(ptsRefROI.Count>0, 'No SURF keypoints inside reference ROI.');

    % Build descriptors for these reference keypoints
    patchSize = patchSizeOrig;  % working at original resolution
    [featRef, ~] = buildHueEdgeDescriptor( ...
        IrefRGB, IrefGray, ptsRefROI, patchSize, edgesH, numEdgeBins, edgeWeight, sandVThresh, SThresh);

    %% 3) RECOGNIZE

    ItrainRGB = imread(imagePath);
    ItrainGray= im2single(rgb2gray(ItrainRGB));

    % Detect SURF on training image
    ptsTrainAll = detectSURFFeatures(ItrainGray, ...
                      'MetricThreshold', MetricThreshTr, ...
                      'NumOctaves',     4, ...
                      'NumScaleLevels', 4 );
    if ptsTrainAll.Count == 0
        result = false;
        return;
    end
    ptsTrainAll = selectStrongest(ptsTrainAll, maxStrongPts);

    % Build descriptors for all training keypoints
    [featTrain, ~] = buildHueEdgeDescriptor( ...
        ItrainRGB, ItrainGray, ptsTrainAll, patchSize, edgesH, numEdgeBins, edgeWeight, sandVThresh, SThresh);
    if isempty(featTrain)
        result = false;
        return;
    end

    % Match via matchFeatures using SSD
    indexPairs = matchFeatures(featRef, featTrain, ...
                      'Metric',        'SSD', ...
                      'MatchThreshold',round(matchThresh*100), ...
                      'MaxRatio',      maxRatio, ...
                      'Unique',        true, ...
                      'Method',        'Approximate');

    if isempty(indexPairs)
        result = false;
        return;
    end

    if size(indexPairs, 1) >= keypointThreshold
        result = true;
    else
        result = false;
    end

end


%% -----------------------------------------------------------------------
function [features, validPts] = buildHueEdgeDescriptor( ...
    Irgb, Igray, ptsAll, patchSize, edgesH, numEdgeBins, edgeWeight, sandVThresh, SThresh)
    [imgH, imgW, ~] = size(Irgb);
    locs   = round(ptsAll.Location);  % P_all × 2
    P_all  = size(locs,1);

    numHueBins = length(edgesH)-1;
    totalBins  = numHueBins + numEdgeBins;

    descriptors = nan(P_all, totalBins);
    keep        = false(P_all,1);

    edgesO = linspace(0,180, numEdgeBins+1);
    sobelX = fspecial('sobel')';
    sobelY = fspecial('sobel');

    for i = 1:P_all
        x = locs(i,1);
        y = locs(i,2);
        xMin = x - patchSize;  xMax = x + patchSize;
        yMin = y - patchSize;  yMax = y + patchSize;
        if xMin<1 || yMin<1 || xMax>imgW || yMax>imgH
            continue;
        end

        patchRGB = Irgb(yMin:yMax, xMin:xMax, :);
        patchHSV = rgb2hsv(patchRGB);
        Hchan = patchHSV(:,:,1);
        Schan = patchHSV(:,:,2);
        Vchan = patchHSV(:,:,3);

        meanH = mean(Hchan(:));
        meanV = mean(Vchan(:));
        if (meanV > sandVThresh) && (meanH >= 0.15 && meanH < 0.21)
            continue;  % skip bright yellow (sand)
        end

        meanS = median(Schan(:));
        if meanS < SThresh
            continue;
        end

        % --- hue histogram (weighted by saturation) ---
        histH = zeros(1, numHueBins);
        for b = 1:numHueBins
            maskB = (Hchan >= edgesH(b) & Hchan < edgesH(b+1));
            histH(b) = sum( Schan(maskB) );
        end
        totalSat = sum(histH);
        if totalSat == 0
            continue;  % fully desaturated patch
        end
        histH = histH / totalSat;  % L₁-normalize hue

        % --- 4-bin Sobel orientation histogram ---
        patchGray = Igray(yMin:yMax, xMin:xMax);
        Gx = imfilter(patchGray, sobelX, 'replicate');
        Gy = imfilter(patchGray, sobelY, 'replicate');
        Ori = atan2d(Gy, Gx);
        Ori(Ori < 0) = Ori(Ori < 0) + 180;  % map to [0,180)
        histO = histcounts(Ori(:), edgesO, 'Normalization','probability');  % 1×4

        % --- Weight edges, concatenate, then L₁-normalize final descriptor ---
        descRaw = [histH , edgeWeight * histO];
        descL1  = descRaw / sum(descRaw);

        descriptors(i,:) = descL1;
        keep(i) = true;
    end

    validPts = ptsAll(keep);
    features = descriptors(keep,:);
end