%% Cluseter Norm Denoising
% Test for Cluster Norm Based Denoising using the ADMM method

addpath('../');
addpath('../toolbox_optim');
addpath('./toolbox_optim/toolbox/');

%%
% Load Vactor.
load('test_x_block.mat','-mat')
y = X_block_recovered;
block_size = 19;




%%
% We aim at minimising:

%%
% |min_x 1/2*norm(y-x)^2 + lambda* cluster_norm (K(x),1)|


%%
% Regularization parameter.

lambda = 0.5;

% block_size = 

%%
% where |K| is a permutation matrx of choosing clusters.

K = @(x) cluster_dic_func(x, block_size);
KS = @(x) cluster_dic_inv(x, block_size);

%%
% It can be put as the minimization of |F(K*x) + G(x)|

% Amplitude = @(u)sqrt(sum(u.^2));
F = @(u)lambda*cluster_norm(u);
G = @(x)1/2*norm(y-x)^2;

%%
% The proximity operator of |F| is the soft thresholding.

% Normalize = @(u) u./ max(Amplitude(u),1e-10);
% ProxF = @(u,tau) perform_soft_thresholding(abs(u),lambda*tau) .* Normalize(u);
ProxF = @(u,tau) perform_soft_thresholding(u,lambda*tau);
ProxFS = compute_dual_prox(ProxF);

%%
% The proximity operator of G.

ProxG = @(x,tau)(x+tau*y)/(1+tau);

%%
% Function to record progression of the functional.

options.report = @(x)G(x) + F(K(x));

%%
% Run the ADMM algorihtm.

options.niter = 300;
[xAdmm,EAdmm] = perform_admm(y, K,  KS, ProxFS, ProxG, options);

%%
% Display image.


plot(xAdmm);


 