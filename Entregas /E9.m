im=imread('blob3.tif');
figure,imshow(im),title('input image')

%esquelet
sq=bwskel(im);
figure,imshow(sq),title('esquelet')


%skiz 
sk=bwskel(~im);
figure,imshow(sk),title('SKIZ')
figure,imshow(imfuse(im,sk)),title('overlay SKIZ')



im=imread("n2538.tif");
figure,imshow(im),title('input image')

ee=strel('disk',3);

dil=imdilate(im,ee);
figure,imshow(dil),title('dilatatació')
ero=imerode(im,ee);
figure,imshow(ero),title('erosio')

op=imopen(im,ee);
figure,imshow(op),title('open')
cl=imclose(im,ee);
figure,imshow(cl),title('close')


%Exercicis 
%1. Que nomes aparaguin els forats, una imatge de parts cuadrats, rodons,
%rectangulars, de pistes gruixudes, de pistes primes 
im=imread('pcb1bin.tif');
figure,imshow(im),title('input image')
inverse = ~im;
figure, imshow(inverse), title('Inverse')

mark = false(size(im));
mark(1, 1:end) = 1;
mark(end, 1:end) = 1;
mark(1:end, 1) = 1;
mark(1:end, end) = 1;
figure, imshow(mark), title('Marker')
reconstruction = imreconstruct(mark, inverse);
figure, imshow(reconstruction), title('Reconstruction')
result1 = imsubtract(inverse, reconstruction);
figure, imshow(result1), title('Forats del centre')






inresult1 = ~result1; 
im2 = ~imsubtract((1-im), result1);
figure, imshow(im2), title('Imagen sin círculos');


% Exercici 2
im2=imread('letters.tif');
figure,imshow(im2),title('Segmenteu les Psi')
ee=strel("rectangle",[2,7]);
mark=imerode(im2,ee);
figure,imshow(mark),title('marker')
rec=imreconstruct(mark,im2);
figure,imshow(rec),title('Signe PSI')




