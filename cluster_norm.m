function [norm] = cluster_norm(input_matrix)

cluster_norm = 0;

for iter = 1: length(input_matrix)/2
   cluster_norm = cluster_norm + sqrt(input_matrix(2*iter-1).^2 + input_matrix(2*iter).^2);
end
norm = cluster_norm;
