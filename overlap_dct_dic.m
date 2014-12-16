function y = overlap_dct_dic(w, mode) 
  winSize = 1024;
  hop = 512;
  sig_length = length(w);
  %======================================
  % Choose the window function 
  %======================================
  
%   wn = ones(winSize,1) / sqrt(2); % no window, or the rectangular window
  wn = sqrt(hann(winSize,'periodic')); % hanning window
  
  %======================================
  if(mode ==1)
    num_of_frames = sig_length / winSize;
    length_y = winSize + (num_of_frames-1) * hop;
    y = zeros(length_y,1);
    for frame = 0:num_of_frames-1
        offset_w = frame * winSize;
        offset_y = frame * hop;
        y(offset_y + 1:offset_y + winSize,1) = y(offset_y+1:offset_y+winSize,1) + idct(w(offset_w+1:offset_w+winSize,1)) .* wn;
    end
  else    
    num_of_frames = floor((sig_length - winSize)/hop) + 1;
    length_y = winSize * num_of_frames;
    y = zeros(length_y,1);
    % Dt Calculation
    for frame = 0:num_of_frames-1
        offset_w = frame * hop;
        offset_y = frame * winSize;
        y(offset_y+1:offset_y+winSize,1) = dct(w(offset_w+1:offset_w+winSize,1) .* wn);
    end
  end
end