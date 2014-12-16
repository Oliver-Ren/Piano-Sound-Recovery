function y = somefunction(w, mode) 
  if(mode ==1)
     y = dct(w(1:512,1))+w(512+1:1024,1);
  else  
     y = [dct(w);w];
  end
end