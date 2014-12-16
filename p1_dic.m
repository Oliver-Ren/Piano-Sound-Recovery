function y = p1_dic(w, mode) 
  if(mode ==1)
     y = dct(w);
  else  
     y = idct(w);
  end
end