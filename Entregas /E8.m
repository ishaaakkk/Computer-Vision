im=imread('blob3.tif');
figure,imshow(im),title('input image')
ee=strel('disk',1);

mark=im;
mark(2:end-1,2:end-1)=0;
figure,imshow(mark),title('markers')

dilc=imdilate(mark,ee)&im;
figure,imshow(dilc),title('dilatatacio condicional')

dilc=imdilate(dilc,ee)&im;
dilc=imdilate(dilc,ee)&im;
dilc=imdilate(dilc,ee)&im;
dilc=imdilate(dilc,ee)&im;
dilc=imdilate(dilc,ee)&im;
dilc=imdilate(dilc,ee)&im;
dilc=imdilate(dilc,ee)&im;
dilc=imdilate(dilc,ee)&im;
figure,imshow(dilc),title('N x dilatatacio condicional')

rec=imreconstruct(mark,im);
figure,imshow(rec),title('reconstruccio')
res=imsubtract(im,rec);
figure,imshow(res),title('celules senceres')

im=imread('pcbholes.tif');
figure,imshow(im),title('input image')
mark=im;
mark(2:end-1,2:end-1)=0;
rec=imreconstruct(mark,im);
figure,imshow(rec),title('reconstruccio')
res=imsubtract(im,rec);
figure,imshow(res),title('celules senceres')


im=imread("tools.tif");
figure,imshow(im),title('input image')

ee=strel('disk',9);
mark=imerode(im,ee);
figure,imshow(mark),title('marker')
rec=imreconstruct(mark,im);
figure,imshow(rec),title('disc reconstruit')

ee=strel("line",60,0);
mark=imerode(im,ee);
figure,imshow(mark),title('marker')
rec=imreconstruct(mark,im);
figure,imshow(rec),title('boli i clau anglesa')

im=imread('gear.tif');
figure,imshow(im),title('input image')
% NO vull que hem fasi optimitzacio, afegint el 0 final, aixi s'obte un
% cercle 
ee=strel('disk',20,0);
op=imopen(im,ee);
figure,imshow(op),title('open')

res = imsubtract(im, op);
figure,imshow(res),title('residu, dents');

%Labeling, donarli a cada pixel un nom de la regio a la que pertany, tots
%els pixels de la mateixa regio conexa tindran un mateix valor 

%para verlo con difrentes colores ver las regiones cambiar el colormap 
eti=bwlabel(res,8);
figure,imshow(eti,[]),title('imatge etiquetada')
n_dents=max(eti(:));

%Para saber el numero de pixels que pertenecen a una región, por cada
%región el histograma nos dice cuantos pixeles hay
h=imhist(uint8(eti));
figure,bar(h(2:25)),title('Arees')
gran=max(h(2:25));
petita=min(h(2:25));





