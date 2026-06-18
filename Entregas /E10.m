im = imread("Birds.tif");
figure,imshow(im),title("input image")

ee=strel('disk',1);
% Eliminar ralles blanques 
op=imopen(im,ee);
figure,imshow(op),title('open')
% Eliminar ralles negres 
cl=imclose(im,ee);
figure,imshow(cl),title('close')

% Primer fem close desperes open, per elimnar ratlles blanques i negres 
clop=imopen(cl,ee);
figure,imshow(clop),title('ASF close-open')

% Fem servir un element e. més gran 
ee=strel('disk',2);
clop=imopen(cl,ee);
figure,imshow(clop),title('ASF close-open. EE radi 2')

% Residus 
im=imread("danaus.tif");
figure,imshow(im),title('input image')

%contron extern
ee=strel('disk',1);
dil=imdilate(im,ee);
ero=imerode(im,ee);
ce=imsubtract(dil,im);
figure,imshow(ce),title('contron extern')
%contron intern
ci = imsubtract(im,ero);
figure,imshow(ce),title('contorn intern')
%contron doble
cd = imsubtract(dil,ero);
figure,imshow(cd),title('contorn doble')
% laplacia 
lap=imsubtract(double(ce),double(ci));
figure,imshow(lap,[]),title('laplacia morfologic')


% top hat y bottom hat, residus multinivell 
% volem detectar petites estructures blanques, y les grans estructures
% blanques com el fons no el volem detectar, per tant farem un open 
im=imread("nshadow.tif");
figure,imshow(im),title('input image')
ee=strel('disk',5);
op=imopen(im,ee);
figure,imshow(op),title('fons')
th=imsubtract(im, op);
figure,imshow(th),title('top hat: les lletres ')

% es fa una especie de binarització per llindars 
imbw=th>30;
figure,imshow(imbw),title('imatge binaria')

% funcio que implementa directament el top hat 
th2=imtophat(im,ee);
figure,imshow(th2),title('top hat')


% Exercici: classificació de grans segons caracteristica de forma.
% Segmentar grans d'arros, binaritzar, etiquetarlos, caracteristiques de
% cadascun 
im=imread('arros.tif');
figure,imshow(im),title('input image')

% Aplicar un llindar directament 
imbw=im>110;
figure,imshow(imbw),title('binaritzacio')

% aplicant top hat per extreure els grans d'arros correctament 
ee=strel('disk',5);
op=imopen(im,ee);
figure,imshow(op),title('fons')
figure,mesh(op)

th=imsubtract(im, op);
figure,imshow(th),title('top hat: els grans')
figure,mesh(op)

imbw=th>30;
figure,imshow(imbw),title('imatge binaria')



%reconstruccio multinivell
im=imread("bloodcells.tif");
figure,imshow(im),title('input')
mark=im;
mark(2:end-1,2:end-1)=0;
figure,imshow(mark),title('markers')
rec=imreconstruct(mark,im);
figure,imshow(rec),title('reconstrucció')

im=imread('arros.tif');
figure,imshow(im),title('input image')
rec=imreconstruct(mark,im);
figure,imshow(rec),title('reconstrucció')


% maxims i minims regionals 
im=imread("astablet.tif");
figure,imshow(im),title('input image')
% s'agafa els maxims regionals de la imatge 
rm=imregionalmax(im);
figure,imshow(rm),title('maxim regionals')

% filterm la imatge per a que detecti correctamente les aspirines, passem
% el ee, per l'aspirina per a que es detecti correctament els maxims
% regionals 
ee=strel('disk',20,0);
op=imopen(im,ee);
figure,imshow(op),title('open de les pastilles')
figure,mesh(op)
rm2=imregionalmax(op);
figure,imshow(rm2),title('maxim regionals')

% Busquem maxim regionals pero ara amb contrast, es a dir tenint en compte
% les altures, que els veins siguin menors x vegades que el pixel 
rm3=imextendedmax(im,25);
figure,imshow(rm3),title('maxim regionals imatge filtrada per H')
































