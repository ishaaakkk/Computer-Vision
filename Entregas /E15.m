
%descriptors basics
im=imread("head.png");
im=imresize(im,1/2);
figure,imshow(im),title('input image')

ero=imerode(im,strel('disk',1));
cont=xor(im,ero);
figure,imshow(cont),title('contorn')

area=sum(im(:));
per=sum(cont(:));
dades=regionprops(im,"all");


[fila,col]=find(cont,1);
%codi freman, si es mou ja no te sentit
B=bwtraceboundary(cont,[fila,col],'E');
%codi freeman absolut, incremental
freem=B(2:end,:)-B(1:end-1,:);
%obtener el codigo de freeman pero con solo un valor, no derecha horizontal
% recto vertical 
freem2=3*freem(:,1)+freem(:,2);
freem3=freem(:,1)+i*freem(:,2);

aux=zeros(size(im));
aux(sub2ind(size(aux),B(:,1),B(:,2)))=1;
figure,imshow(aux),title('from coords to pixels')



%descriptors de fourier 
mig=mean(B);
Bc=B-mig;
s=Bc(:,1)+1i*Bc(:,2);
z=fft(s);
figure,plot(abs(z)),title('espectre')
figure,plot(log(abs(z))),title('espectre en escala logaritmica')
%inversa
ss=ifft(z);
files=round(real(ss)+mig(1));
cols=round(imag(ss)+mig(2));
aux=zeros(size(im));
aux(sub2ind(size(aux),files,cols))=1;
figure,imshow(aux),title('transformada inversa')

% fem servir unicament 30 descriptors 
N=20;
zz=z;
zz(N+1:end-N)=0;
figure,plot(log(abs(zz))),title('espectre N=30')

ss2=ifft(zz);
mida=500;
aux=zeros(mida);
files=round(real(ss2)+mida/2);
cols=round(imag(ss2)+mida/2);
aux(sub2ind(size(aux),files,cols))=1;
figure,imshow(aux),title("transformada inversa amb nomes 30 descriptors")



