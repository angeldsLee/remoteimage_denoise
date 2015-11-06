function  selfdenoise(f)
f = double(f);
g = imnoise2('gaussian',size(f,1),size(f,2),0,20);
f1 = f + g;
[c,s] = wavedec2(f1,3,'db8'); 
[cH1,cV1,cD1] = detcoef2('all',c,s,1);
delta = median(abs(cD1(:))) / 0.6745;
thr1c = delta * thselect(c,'minimaxi');
n = [1 2 3];
p = [thr1c thr1c thr1c];
dnc0 = wthcoef2('h',c,s,n,p,'s');
dnc0 = wthcoef2('v',dnc0,s,n,p,'s');
dnc0 = wthcoef2('d',dnc0,s,n,p,'s');
dnf0 = waverec2(dnc0,s,'db8');
VSf1 = cacupsnr(dnf0,f)
figure;
subplot(121);
imshow(f,[]);
subplot(122);
imshow(dnf0,[]);


