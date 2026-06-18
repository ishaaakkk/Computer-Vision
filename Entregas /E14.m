im=imread("peppers.png");
figure,imshow(im),title('input image')
[files,cols,cans]=size(im);

vect=reshape(double(im),files*cols,cans);
figure,scatter3(vect(:,1),vect(:,2),vect(:,3),1);
xlabel('R');ylabel('G');zlabel('B');
title('feature space');

% cada una de les mostres s'etiqueten 
K=2;
% dos cenres de clusters, mira si les mostres pertanyen a un cluster o a l'altre 
% ctrs representa els centres de cada R G B
% labels representa a quin cluster pertany cada mostra (vector d'etiquetes)
[labels,ctrs]=kmeans(vect,K,"Distance",'sqeuclidean');

eti=reshape(labels,files,cols);
figure,imshow(eti,[]),title('k-means clustering');
% mostra els centres de cada cluster

rgb=ind2rgb(eti,ctsrs/255);
figure,imshow(rgb),title('k-means clustering');
% mostra els centres de cada cluster


figure,scatter3(vect(:,1),vect(:,2),vect(:,3),1,labels);
xlabel('R');ylabel('G');zlabel('B');
title('feature space cluseritzat');
% es pinten els de la clase 1 amb un color y els de la clase 2 amb un altre

hsv=rgb2hsv(im);
hs=hsv(:,:,1:2);
vect2=reshape(double(hs),files*cols,2);

[labels2,ctrs2]=kmeans(vect2,K,"Distance",'sqeuclidean');
eti2=reshape(labels2,files,cols);
figure,imshow(eti2,[]),title('segmentacio per k-means en espai HSV');

figure,scatter3(vect2(:,1),vect2(:,2),1,labels2);
xlabel('H');ylabel('S'); 
title('feature space cluseritzat HSV');

% exercici en grupo obtenir els grans de cafe segmentats correctament 
im=imread("cafe.tif");
figure,imshow(im),title('input image') 
