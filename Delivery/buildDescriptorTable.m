function buildDescriptorTable(rootDir)
    %% Enumerar clases
    d = dir(rootDir);
    isSub = [d.isdir] & ~ismember({d.name},{'.','..'});
    subfolders = d(isSub);

    %% Inicializar listas
    fileNames = {};
    classes   = {};
    isTest    = [];

    %% Recorrer carpetas
    for i = 1:numel(subfolders)
        clsName = subfolders(i).name;
        imageFiles = dir(fullfile(rootDir,clsName,'*.jpg'));
        for j = 1:numel(imageFiles)
            fileNames{end+1,1} = imageFiles(j).name;
            classes{end+1,1}   = clsName;
            isTest(end+1,1)    = (rand()<0.3);
        end
    end

    %% Crear tabla base
    inputTable = table(fileNames, classes, isTest, ...
                       'VariableNames', {'FileName','Class','IsTest'});

    %% Prealloc histogramas
    numImages = height(inputTable);
    % Parámetros
    M            = 16;
    Vbins        = 16;
    numSWbins    = 10;
    maxStroke    = 20;
    bhatSErad    = 5;
    lbpBins      = 256;
    totalDims    = M^2 + Vbins + numSWbins + lbpBins;
    histograms   = zeros(numImages, totalDims);

    %% Procesar cada imagen
    for i = 1:numImages
        try
            imgPath = fullfile(rootDir, inputTable.Class{i}, inputTable.FileName{i});
            img = imread(imgPath);

            % Recorte manual por algunas clases
            if ~inputTable.IsTest(i)
                switch inputTable.Class{i}
                    case {'Bob esponja','gat i gos','pokemon'}
                        img = img(:,80:end-80,:);
                    case 'Tom y Jerry'
                        img = img(:,230:end-230,:);
                end
            end

            img = imresize(img,[128 128]);

            % --- Descriptor (u,v) + V ---
            hsvImg = rgb2hsv(img);
            H = hsvImg(:,:,1); S = hsvImg(:,:,2); V = hsvImg(:,:,3);
            Hrad = H * 2*pi;
            u = S.*cos(Hrad);  v = S.*sin(Hrad);
            edgesUV = linspace(-1,1,M+1);
            jointUV = histcounts2(u(:),v(:),edgesUV,edgesUV);
            jointUV = jointUV / sum(jointUV(:));
            histV = histcounts(V, linspace(0,1,Vbins+1));
            histV = histV / sum(histV);

            % --- Grosor de trazo vía black-hat ---
            grayImg = im2gray(img);
            se = strel('disk',bhatSErad);
            blackh = imbothat(grayImg,se);
            bwStroke = imbinarize(blackh,'adaptive',...
                                  'ForegroundPolarity','dark',...
                                  'Sensitivity',0.4);
            bwStroke = imopen(bwStroke, strel('line',3,0));
            bwStroke = imclose(bwStroke, strel('line',5,90));
            skel = bwskel(bwStroke);
            dt   = bwdist(~bwStroke);
            widths = 2*dt(skel);
            widths(widths>maxStroke) = maxStroke;
            edgesSW = linspace(0,maxStroke,numSWbins+1);
            histSW = histcounts(widths,edgesSW);
            if ~isempty(widths)
                histSW = histSW / sum(histSW);
            end

            % --- LBP 3x3 manual ---
            gray8 = im2uint8(grayImg);
            [hgt,wid] = size(gray8);
            lbpImage = zeros(hgt,wid,'uint8');
            for y = 2:hgt-1
                for x = 2:wid-1
                    c = gray8(y,x);
                    n = [gray8(y-1,x-1), gray8(y-1,x),   gray8(y-1,x+1), ...
                         gray8(y,  x+1), gray8(y+1,x+1), gray8(y+1,x),   ...
                         gray8(y+1,x-1), gray8(y,  x-1)];
                    code = uint8((n>=c) * (2.^(0:7))');
                    lbpImage(y,x) = code;
                end
            end
            lbpHist = histcounts(lbpImage(:), 0:lbpBins);
            if sum(lbpHist)>0
                lbpHist = lbpHist / sum(lbpHist);
            end

            % --- Concatenar en fila ---
            histograms(i,:) = [jointUV(:)' , histV , histSW , lbpHist];

        catch ME
            warning('Error en %s: %s', inputTable.FileName{i}, ME.message);
        end
    end

    %% Construir tabla de descriptores con nombres

    inputTable.Class = categorical(inputTable.Class);
    
    numBins        = size(histograms,2);

    predictorNames = arrayfun(@(k) sprintf('histograms%d',k), 1:numBins, ...
                              'UniformOutput', false);

    descriptorTable = array2table(histograms, ...
                                  'VariableNames', predictorNames);
    
    descriptorTable.FileName = inputTable.FileName;
    descriptorTable.Class    = inputTable.Class;
    descriptorTable.IsTest   = inputTable.IsTest;
    descriptorTable = movevars(descriptorTable, ...
                                {'FileName','Class','IsTest'}, ...
                                'Before',1);
    
    save("descriptorTable.mat", "descriptorTable")

end

