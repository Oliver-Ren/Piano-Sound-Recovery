function [MSE_dB,PSNR_dB] = MSE_PSNR_calc(original, ref, overlap)
if size(original,1) < size(original,2)
    original = original';
end
if size(ref,1) < size(ref,2)
    ref = ref';
end
if size(ref,1) < size(original,1)
    original = original(1:size(ref,1),1);
end

ref = ref(overlap+1:end-overlap-1);
original = original(overlap+1:end-overlap-1);
N = size(ref,1);
    
    

MSE = (norm(ref - original).^2)/N;
PSNR_dB = 10*log10(max(original).^2/MSE);
MSE_dB = 20*log10(MSE);