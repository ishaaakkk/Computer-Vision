im=imread('rabbit.jpg');

ee1=strel('disk',1);
grad=imsubtract(imdilate(im,ee1),imerode(im,ee1));
figure,imshow(grad,[]),title('gradient')

segm=watershed(grad);
figure,imshow(segm,[]),title("segmentació")
figure,imshow(segm==0),title("watershed")

% busquem els minims regionals, per millor establir un llindar dels minims
% regionals ja que aixi obtenim minims correctes 
rm=imregionalmin(grad);
figure,imshow(rm),title("minims regionals")
%minims regionals que tenen profunditat més gran que 5
rm5=imextendedmin(grad,6);
figure,imshow(rm5),title("minims regionals profunditat més gran que 5")

% per poder imposar minims, els pous de profunditat inferior a 5 no
% apareixen 
% se cogen los minimos de la imagen de rm5 y se aplican a la imagen
% original
grad2=imimposemin(grad,rm5);
segm=watershed(grad2);
figure,imshow(segm==0),title("watershed amb markers de profunditat")

% es fan servir markers de forma 
ee2=strel('disk',15);
grad3=imclose(grad,ee2);
segm3=watershed(grad3);
figure,imshow(segm3==0),title("watershed amb markers de forma")

% eliminació de pous profund i que no tenen certa amplada
grad3=imimposemin(grad,rm5);
ee2=strel('disk',15);
grad3=imclose(grad3,ee2);
segm3=watershed(grad3);
figure,imshow(segm3==0),title("watershed amb markers de forma")


%separacio de touching-blobs
im=imread("touchcell.tif");
figure,imshow(im),title('touching blobs')
td=bwdist(~im);
figure,imshow(td,[]),title("transformada de la distancia")
figure,mesh(td)
figure,mesh(-td)

segm=watershed(-td);
figure,imshow(segm==0),title('watershed')
res=im;
res(segm==0)=0;
figure,imshow(res),title('blobs separats')


% cornea, obtenció de les regions de cada celula 
im=imread('cornea.tif');
figure,imshow(im),title('input image')

grad=imsubtract(imdilate(im,ee1),imerode(im,ee1));
figure,imshow(grad,[]),title("gradient image")

segm=watershed(grad);
figure,imshow(segm==0),title("watershed")

% obtenim els maxims regionals, pero apliquem filtre
rm=regionalmax(im);
figure,imshow(rm),title('maxims regionals')

ee2=strel('disk',2);
filt=imopen(imclose(im,ee2),ee2);
rm2=imregionalmax(filt);
figure,imshow(rm2),title('maxims regionals filtrats')

% aqui tenim les celules amb les regions seves, per tambe tenen un part del
% fondo, llavors tenim tant celula com fondo en una regio 
grad2=imimposemin(grad,rm2);
segm2=watershed(grad2);
figure,imshow(segm2==0),title('watershed amb markers')
figure,imshow(imfuse(im,segm2==0)),title("watershed amb markers")

%obtenim la regio del fons 
fons=bwskel(~rm2);
figure,imshow(fons),title('skiz')

% aqui ja obtenim les celules amb les seves regions corresponents 
markers=fons|rm2;
figure,imshow(markers),title('markers')

grad3=imimposemin(grad,markers);
segm3=watershed(grad3);
figure,imshow(imfuse(im,segm3==0)),title('segmentació final')



