im=false(128);
im(64,:)=1;
im(:,64)=1;
figure,imshow(im),title('input image')

EE = [1,1,1];

for i = 128
    for j = 128
        if (im(i,j) == 1)
            if ((j-1) >= 0)
                im(i,j-1) = 1;
            end
            if((j+1) <= 128)
                im(i,j+1) = 1;
            end
        end
    end
end 
figure,imshow(im),title('dilatacio manual ')


ee=strel([1,1,1]);
dil=imdilate(im,ee);
figure,imshow(dil),title('dilatacio automatica')

im=imread('blob.tif');
figure,imshow(im),title('input image')
ee=strel('square', 3);
dil=imdilate(im,ee);
figure,imshow(dil),title('dilatacio automatica')


ero=imerode(im,ee);
figure,imshow(ero),title('erosio')

close all 
clear all


im=imread('blob3.tif');
figure,imshow(im),title('input image')
ee=strel('disk',1);
dil=imdilate(im,ee);
figure,imshow(dil),title('dilatacio')
%contorno externo
c_ext=imsubtract(double(dil),double(im));
figure,imshow(c_ext,[]),title('contorn extern')

%contorno intterno
ero=imerode(im,ee);
c_int=imsubtract(double(im),double(ero));
figure,imshow(c_int,[]),title('contorn intern')

%% fusio de contorn
figure,imshow(imfuse(c_ext,c_int)),title('overlay de contorns')


lap=imsubtract(c_ext,c_int);
figure,imshow(lap,[]),title('laplacia morfologic')

im=imread('touchcell.tif');
figure,imshow(im),title('input image')

tdist=double(im);
ero=imerode(im,ee);
tdist=tdist+ero;


ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;

ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;
ero=imerode(ero,ee);tdist=tdist+ero;

ero=imerode(ero,ee);tdist=tdist+ero;

figure,imshow(ero), title('N erosions')
figure,imshow(tdist,[]), title('T distancia parcial')
figure,mesh(tdist)

Td=bwdist(im);
figure,imshow(Td,[]), title('T distancia')

Td=bwdist(~im);
figure,imshow(Td,[]),title('T de distancia')
figure,mesh(Td)