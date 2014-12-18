clear all;
close all;
clc;

%x_test = linspace(1,500,1000)';
x_test = [1;1;1;1];

[y] = cluster_dic_func(x_test,4);
%[a,b] = cluster_matrix_norm(x_test,4);
norm = cluster_norm(y);
result = cluster_dic_inv(y,4);