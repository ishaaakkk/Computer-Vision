im=imread("airplane.tif");
figure,imshow(im),title('input image')

im2=im>75;
figure,imshow(im2),title('binaritzat')
figure,imhist(im)


% Otsu 
th=graythresh(im);
imbw=im2bw(im,th);
imshow(imbw),title ("binaritzacio per Otsu");

tros=imcrop(im);
figure,imshow(tros),title('crop')

% llindars locals. moving space
im=imread("textsheet.jpg");
figure,imshow(im),title('input image')

kernel=ones(21)/21/21;
%'replicate' en la función imfilter de MATLAB se refiere al método utilizado 
% para tratar los bordes de la imagen durante la operación de convolución. Específicamente, 
% 'replicate' significa que los píxeles en el borde de la imagen se "replican", es decir, 
% los valores de los píxeles más cercanos al borde se usan para rellenar las áreas fuera 
% de la imagen (en los bordes).
avg=imfilter(im,kernel,'replicate');
figure,imshow(avg),title('imatge promig')
res=im>(avg-25);
figure,imshow(res),title('moving average')

% Labeling 

% codi per obtenir grans de arros complets, de la semana pasada
im=imread('arros.tif');
figure,imshow(im),title('input image')
ee=strel('disk',20);
th=imtophat(im,ee);
figure,imshow(th),title('top hat')

imbw=im2bw(th,graythresh(th));
figure,imshow(imbw),title('binaritzacio per Otsu')

mark=imbw;
mark(2:end-1,2:end-1)=0;
rec=imreconstruct(mark,imbw);
figure,imshow(rec),title('grans imcomplets')

res=imsubtract(imbw,rec);
figure,imshow(res),title('grans complets')

% aqui comença el labeling
% etiquetar les components connexes per connectivitat 4
eti=bwlabel(res,4);
figure,imshow(eti,[]),title('imatge etiquetada')

% aqui se obtienen todos los datos de las regiones etiquetadas 
dades=regionprops(eti,'all');
arees=[dades.Area];
figure,hist(arees,20),title('arees')


% Exercici 
im = imread('r4x2_256.tif');
figure, imshow(im), title('input image');

ee = strel('line', 40, 90);
cl = imclose(im, ee);
figure, imshow(cl), title('resultat image');

diff = imsubtract(cl, im);
figure, imshow(diff), title('defectes');

differenceBin = diff > 40;

ee = strel('disk', 2);
opening = imopen(differenceBin, ee);
figure, imshow(differenceBin), impixelinfo, title('Result')




