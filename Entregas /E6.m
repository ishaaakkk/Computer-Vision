%% Entrega 6  Ishak Felfoul 

im=imread('rabbit.jpg');
gauss=fspecial('gaussian',5,1);

dog=gauss(1:3,:)-gauss(3:5,:);
Gy=imfilter(double(im),dog,'conv');
figure,imshow(Gy,[]),title('DoG vertical')

log=fspecial('Log');
lap=imfilter(double(im),log,'conv'); 
figure,imshow(lap,[]),title('LoG')

%% Exercici individual 

% Apartat 1
gauss2=fspecial('gaussian',257,65);
gauss2 = gauss2 / max(gauss2(:));

figure,imshow(gauss2,[]),title('Imatge sintetica')
figure,mesh(gauss2),title('Representació 3D imatge')

% Apartat 2 
sobelX = [-1, 0, 1; -2, 0, 2; -1, 0, 1]/4;
gradientX = imfilter(double(gauss2), sobelX, 'conv');
%figure, imshow(gradientX, []), title('Gradient X')

sobelY = [-1, -2, -1; 0, 0, 0; 1, 2, 1]/4;
gradientY = imfilter(double(gauss2), sobelY, 'conv');
%figure, imshow(gradientY, []), title('Gradient Y')

module = sqrt(gradientX.^2 + gradientY.^2);
direction = atan2(double(gradientY), double(gradientX));


% Apartat 3
figure, imshow(module, []),impixelinfo, colormap jet, title('Module')
%Trobem un gradient més elevat entre el punt més alt de la gaussiana i 
% els punts mes baixos, es a dir on hi ha un major pendent tindrem valors 
% mes alts de gradient

%Apartat 4 

% Convertir de radians a graus i utilitzar el rang [0,360]
direction = rad2deg(direction);
direction(direction < 0) = direction(direction < 0) + 360;
figure, imshow(direction, []), colormap hsv, title('Direcció del gradient')

% Histograma orientacions amb 360 bins 
num_bins = 360;
[counts, edges] = histcounts(direction, num_bins, 'BinLimits', [0, 360]);
% Normalitzacio
counts = counts / sum(counts);

figure, bar(edges(1:end-1), counts, 'histc'), title('Histograma orientacions gradient');

% Es degut principalment a les estructures de la imatge, en la gaussiana
% els gradients son mes pronunciats a les voreres que es on hi ha 
% transicions rapides d'intensitat, aquests transicions solen anar
% del centre cap a for el que provoca que els gradients s'agrupin
% en certes direccions i no es distribueixi de manera uniforme



