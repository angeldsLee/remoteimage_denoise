function glb(f)
%%%%%%% global thresholding of experiment 1
f = double(f);
g = imnoise2('gaussian',size(f,1),size(f,2),0,25);
f1 = f + g;
[c,s] = wavedec2(f1,3,'coif4');  
[cH3,cV3,cD3] = detcoef2('all',c,s,3);
c3 = [cH3,cV3,cD3];
[cH2,cV2,cD2] = detcoef2('all',c,s,2);
c2 = [cH2,cV2,cD2];
[cH1,cV1,cD1] = detcoef2('all',c,s,1);
c1 = [cH1,cV1,cD1];
% 通用阈值，Donoho和Johnstone   thr=delta*sqrt(2*log(n));
delta=median(abs(cD1(:)))/0.6745; 
thr1c=delta*thselect(c,'minimaxi');     
% thr1c3=delta*thselect(c3,'sqtwolog');    
% thr1c2=delta*thselect(c2,'sqtwolog');
% thr1c1=delta*thselect(c1,'sqtwolog');
% n=[1 2 3];p=[thr1c1 thr1c2 thr1c3];
%thr1c=27.9297;
 n = [1 2 3 ];
 p = [thr1c thr1c thr1c ];

dnc0 = wthcoef2('h',c,s,n,p,'s');  
dnc0 = wthcoef2('v',dnc0,s,n,p,'s');    
dnc0 = wthcoef2('d',dnc0,s,n,p,'s');     
dnf0 = waverec2(dnc0,s,'coif4');


origif = cacupsnr(f1,f)
figure;
imshow(uint8(f));  % title('original image');axis square;
figure;
imshow(uint8(f1)); % title('nosied image');axis square;

dnc1 = wthresfunc(c,s,'hard',thr1c); 
dnf1 = waverec2(dnc1,s,'coif4');
figure;
imshow(dnf1,[]); % title(' denoised image with global');axis square;
VSf1 = cacupsnr(dnf1,f)


dnc2 = wthresfunc(c,s,'soft',thr1c);
dnf2 = waverec2(dnc2,s,'coif4');
figure;
imshow(dnf2,[]); % title('soft denoised');axis square;
VSf2 = cacupsnr(dnf2,f)


