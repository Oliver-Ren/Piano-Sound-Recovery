
function y = cluster_dic_inv(input_matrix, block_size)

 M = block_size;
 M_current = M*2-2; 
 N = length(input_matrix)/M_current;
 X0 = reshape(input_matrix, M_current, N);
 y = zeros(M, N);
 for iter = 1: N
     current_col = X0(:,iter);
     X_med = reshape(current_col,2,M-1);

     y(:,iter) = [X_med(1,:)' ;X0(M_current,iter)];
 end 
 y = reshape(y, M*N, 1);   
end