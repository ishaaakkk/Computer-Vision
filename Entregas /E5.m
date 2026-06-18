im=imread('rabbit.jpg');
figure,imshow(im),title('input image')

kernel=ones(3)/9;
im2=imfilter(im, kernel, 'conv');
figure,imshow(im2),title('suavitzat')
im3=imabsdiff(im,im2);
figure,imshow(im3,[]),title('residu')

h=[-1,0,1];
im2=abs(imfilter(double(im), h, 'conv'));
figure,imshow(im2,[]),title('realçat')


Sy=[-1,-2,-1;0,0,0;1,2,1]/4;
Gy=imfilter(double(im),Sy,'conv');
figure,imshow(Gy,[]),title('gradient vertical')

Gx=imfilter(double(im),Sy','conv');
figure,imshow(Gx,[]),title('gradient horitzontal')

mod=sqrt(Gx.^2+Gy.^2);
figure,imshow(mod,[]),title('modul')
dir=atan2(Gy,Gx);
figure,imshow(dir,[]),title('direccio')

mask=mod>8;
figure,imshow(mask),title('gradients importants')
figure,mesh(mod)

mask=mod>15;
figure,imshow(mask),title('gradients importants')
figure,mesh(mod)

kernel=fspecial('laplacian');
lap=imfilter(double(im),kernel,'conv');
figure,imshow(lap,[]),title('laplacia')








