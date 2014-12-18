function [matrix,norm] = cluster_matrix_norm(input_matrix, block_size)

cluster_norm = 0;
M = block_size;
N = length(input_matrix)/M;

X0 = reshape(input_matrix,M,N);

M_new = 2*M-2;
D = zeros(M_new, M);
D(1,1) = 1;
D(M_new, M)=1;

if(M_new-2>0)
  for iter = 1: M-2
      D(2*iter, iter+1) = 1;
      D(2*iter+1, iter+1) = 1;
  end
end

X_new = D * X0;
matrix = reshape(X_new,M_new*N,1);
for iter = 1: M_new*N/2
   cluster_norm = cluster_norm + sqrt(matrix(2*iter-1,1).^2 + matrix(2*iter,1).^2);
end
norm = cluster_norm;
