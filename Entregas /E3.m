%% Ishak Felfoul i Ferran Mesas 
%% Entrega 3 

% Exmples 
im=imread('Que_es.png');
imshow(im),title('input image')
im2=im+200;
figure,imshow(im2),title('sumem iluminacio')
im3=im*10;
figure,imshow(im3),title('contrast')
im4=255-im3;
figure,imshow(im4),title('negatiu')
im5=imcomplement(im3);
figure,imshow(im4),title('imcomplement')

h=imhist(im);


% Exercici 1
h=zeros(256,1);
[filas, columnas] = size(im);

for i = 1:filas
    for j = 1:columnas
        valor = im(i, j);  
        h(valor + 1) = h(valor+1) + 1;  
    end
end

figure, plot(h), title('histograma dels nivells de gris');

% Exemples 
im6=histeq(im);
figure,imshow(im6),title('imatge equalitzada')
figure,imhist(im6),title('histograma equalitzat')


im=imread('lenna.tif');
figure,imshow(im)
im2=imresize(im,0.25);
figure,imshow(im2),title('zoom x1/4')
im3=imresize(im,4,"nearest");
figure,imshow(im3),title('zoom x4')
im4=imrotate(im,45);
figure,imshow(im4),title('rotacio')
T=affine2d([1,0,0;0.5,1,0;0,0,1]);
im5=imwarp(im,T);
figure,imshow(im5),title('transformacio afi')

im1=imread('Blispac1.tif');
im2=imread('Blispac2.tif');
figure,imshow(im1),title('imatge patro')
figure,imshow(im2),title('imatge amb error')

res=im1-im2;
figure,imshow(res), title('resta')
res2=imabsdiff(im1,im2);
figure,imshow(res2), title('resta absoluta')

figure,imshowpair(im1,im2,'blend'),title('superposicio')











