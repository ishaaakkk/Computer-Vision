
kernel=[0,1,0;1,2,1;0,1,0]/6;

im=ones(256);
im(1:128,1:128)=0;
im(129:end,129:end)=0;
figure,imshow(im),title('input image')
figure,mesh(im),title('input image')

im2 = im;
moves = {{-1,-1},{-1,0},{0,-1},{-1,1},{1,-1},{1,0},{0,1},{1,1}};
for i = 1:256
    for j = 1:256
    sum = 0; 
        for k = 1:8
            
        end
    
    im2(i);
    end
end
figure, imshow(im2), title('imatge filtrada')

res=imfilter(im,kernel,'conv');
figure,imshow(res),title('convulocio de 3x3')
kernel2=ones(31)/31/31;
res2=imfilter(im,kernel2,'conv');
figure,imshow(res2),title('convulocio de 31x31')

res3=imfilter(im,kernel2,'conv','replicate');
figure,imshow(res3),title('convolucio 31x31 replicat')

kernel=fspecial("gaussian",7,2);
im=imread('gull.tif');
figure,imshow(im),title('gavina')
soroll=rand(size(im)); 
imgauss=imnoise(im,"gaussian");
figure,imshow(imgauss),title('soroll gaussia')

res=imfilter(imgauss,kernel,'conv');
figure,imshow(res),title('filtratge gaussia')

imsp=imnoise(im,"salt & pepper");
figure,imshow(imsp),title('soroll salt&pepper')
res2=imfilter(imsp,kernel,'conv');
figure,imshow(res2),title('filtratge gaussia amb soroll salt&pepper')

res3=medfilt2(imsp,[5,5]);
figure,imshow(res3),title('filtratge mediana. soroll salt&pepper')








