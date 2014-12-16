function y = overlap_dct_dic(w, mode) 
  winSize = 1024;
  hop = 512;
  if(mode ==1)
    sig_length = length(w);
    num_of_frames = floor((sig_length - winSize)/hop) + 1;
    length_y = winSize + (num_of_frames-1) * hop;
    y = zeros(length_y,1);
    for frame = 0:num_of_frames-1
        offset = frame * hop;
        y(offset+1:offset+winSize,1) = y(offset+1:offset+winSize,1) + dct(w(frame+1:frame+winSize,1));
    end
  else  
     y = idct(w);
  end
end