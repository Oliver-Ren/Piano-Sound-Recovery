function MSE_dB = MSE_calc(original, ref, overlap)
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
MSE_dB = 20*log10(MSE);