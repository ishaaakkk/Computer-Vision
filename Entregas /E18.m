%% E18 ishak felfoul, ferran mesas

load df_fulles.mat 
% fulla numero 1 
tmp=df_norm(1,:);
% transformada inversa de fourier dels seus components
ss2=ifft(tmp);

mida=600;
files=round(real(ss2)+mida/2);
cols=round(imag(ss2)+mida/2);
aux=zeros(mida);
aux(sub2ind(size(aux),files,cols))=1;
imshow(aux),title('fulla classe 2')



[files,cols]=size(df_norm);
% como que es una imatge simetrica nomes cal carregar la meitat
feats=zeros(files,cols/2+1); % mes 1 perque volem posar l'etiqueta 
feats(:,1:end-1)=abs(df_norm(:,1:cols/2));
feats(:,end)=label_tree(:); % ultima columna son les etiquetes 

