%% Practica 1. Ishak Felfoul 
im=imread('Floppy.bmp');
[files,cols]=size(im);
im(100,130)
im(100:105,130:135)
imshow(im)
impixelinfo
colormap jet 
colorbar 
%% display de multiples imatges 
figure
subplot(1,2,1); imshow(im)
subplot(1,2,2); imshow(255-im)
figure;mesh(im)
im2=rand(256);
figure,imshow(im2),title('imatge random')
min(im2(:))
max(im2(:))
%% problemes amb el rang 
im3=1000*im2;
figure
subplot(1,2,1); imshow(im2)
subplot(1,2,2); imshow(im3)
figure,imshow(im3,[0,1000]),title('rang modificat')
figure,imshow(im3,[]),title('rang automatic')
imwrite(im2,'random.png');%escric a disc la imatge 
