function experiment(f)
% f=rgb2gray(f);           different decomposition level
% f1=imnoise(f, 'gaussian');
f=double(f);
g=imnoise2('gaussian',size(f,1),size(f,2),0,20);
f1=f+g;
[c1,s1]=wavedec2(f1,2,'db8'); 
[c2,s2]=wavedec2(f1,3,'db8'); 
[c3,s3]=wavedec2(f1,4,'db8'); 
[c4,s4]=wavedec2(f1,5,'db8'); 

% [cH3,cV3,cD3]=detcoef2('all',c,s,3);c3=[cH3,cV3,cD3];
% [cH2,cV2,cD2]=detcoef2('all',c,s,2);c2=[cH2,cV2,cD2];
 [cH1,cV1,cD1]=detcoef2('all',c1,s1,1);

delta=median(abs(cD1(:)))/0.6745; 

thr1=delta*thselect(c1,'minimaxi');
thr2=delta*thselect(c2,'minimaxi');
thr3=delta*thselect(c3,'minimaxi');
thr4=delta*thselect(c4,'minimaxi');
     
% thr1c3=delta*thselect(c3,'minimaxi');    
% thr1c2=delta*thselect(c2,'minimaxi');
% thr1c1=delta*thselect(c1,'minimaxi');
n1=[1 2 ];p1=[thr1 0.5*thr1 ];
n2=[1 2 3];p2=[thr2 thr2 0.5*thr2];
n3=[1 2 3 4];p3=[thr3 thr3 0.5*thr3 0.4*thr3];
n4=[1 2 3 4 5];p4=[thr4 thr4 0.5*thr4 0.4*thr4 0.35*thr4];
% origif1=cacupsnr(f1,f)

% dnc0=wthcoef2('h',c,s,n,p,'s');   
% dnc0=wthcoef2('v',dnc0,s,n,p,'s');  
% dnc0=wthcoef2('d',dnc0,s,n,p,'s');     
% dnf0=waverec2(dnc0,s,'db8');    
% origif2=cacupsnr(dnf0,f)

b=wthcoef2('h',c1,s1,n1,p1,'h');   
b=wthcoef2('v',b,s1,n1,p1,'h');  
b=wthcoef2('d',b,s1,n1,p1,'h');     
dnf=waverec2(b,s1,'db8');    
origif1=cacupsnr(dnf,f)

b=wthcoef2('h',c2,s2,n2,p2,'h');   
b=wthcoef2('v',b,s2,n2,p2,'h');  
b=wthcoef2('d',b,s2,n2,p2,'h');     
dnf1=waverec2(b,s2,'db8');    
origif2=cacupsnr(dnf1,f)

b=wthcoef2('h',c3,s3,n3,p3,'h');   
b=wthcoef2('v',b,s3,n3,p3,'h');  
b=wthcoef2('d',b,s3,n3,p3,'h');     
dnf2=waverec2(b,s3,'db8');    
origif3=cacupsnr(dnf2,f)

b=wthcoef2('h',c4,s4,n4,p4,'h');   
b=wthcoef2('v',b,s4,n4,p4,'h');  
b=wthcoef2('d',b,s4,n4,p4,'h');     
dnf3=waverec2(b,s4,'db8');    
origif4=cacupsnr(dnf3,f)

% figure,subplot(121),imshow(uint8(f)),title('original image');axis square;
%  subplot(122),imshow(uint8(f1)),title('nosied image');axis square;
%  figure;subplot(121),imshow(dnf,[]),title('denoised with n=2');axis square;
%  subplot(122),imshow(dnf1,[]),title('denoised with n=3');axis square;
% figure; subplot(121),imshow(dnf2,[]),title('denoised with n=4');axis square;
%  subplot(122),imshow(dnf3,[]),title('denoised with n=5');axis square;
 
 
figure,imshow(uint8(f));axis square;
figure,imshow(uint8(f1));axis square;
figure,imshow(dnf,[]);axis square;
figure,imshow(dnf1,[]);axis square;
figure,imshow(dnf2,[]);axis square;
figure,imshow(dnf3,[]);axis square;
 
 

 
 
 
 
 

% subplot(223),imshow(dnf,[]),title('hard denoised');axis square;
% subplot(224),imshow(dnf0,[]),title('soft denoised');axis square;




