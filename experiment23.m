%  不同阈值法去噪
function experiment23(f)
f=double(f);
f=f+15;
g=imnoise2('gaussian',size(f,1),size(f,2),0,15);
f1=f+g;
[c,s]=wavedec2(f1,4,'coif4');  
[cH1,cV1,cD1]=detcoef2('all',c,s,1);c1=[cH1,cV1,cD1];
delta=median(abs(cD1(:)))/0.6745; 
thr1c=delta*thselect(c,'minimaxi');     

%  global
figure,subplot(121),imshow(uint8(f));  title('original image');axis square;
subplot(122),imshow(uint8(f1));  title('nosied image');axis square;

figure,subplot(221),imshow(uint8(f1));  title('noised image');axis square;

dnc1=wthresfunc1(c,s,'hard',thr1c); 
dnf1=waverec2(dnc1,s,'coif4');
subplot(222),imshow(dnf1,[]);  title(' denoised image with global');axis square;
VSf1=cacupsnr1(dnf1,f)

%     adapintrascal(f)
 n=[1 2 3 4];p=[thr1c 0.9102*thr1c 0.7213*thr1c 0.6213*thr1c];

dnc0=wthcoef2('h',c,s,n,p,'h');  
dnc0=wthcoef2('v',dnc0,s,n,p,'h');    
dnc0=wthcoef2('d',dnc0,s,n,p,'h');     
dnf0=waverec2(dnc0,s,'coif4');  
subplot(223),imshow(dnf0,[]);  title('intrascale adaptive');axis square;
VSf2=cacupsnr1(dnf0,f)

%   feature adaptive                                                                                                                                              
[c1, s1]  = wavedec2(f1, 4, 'sym12');  
f2 = feat(f1, 'sym12', 4);     
VSf3 = cacupsnr1(f2, f)                                                
subplot(224),imshow(f2,[]);     title('improved adaptive threshold');
axis square;




