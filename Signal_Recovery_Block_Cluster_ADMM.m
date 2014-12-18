%-------------------------------------------------------------------------
% Piano Sound Recovery using Block Sparsity, optimized with Cluster Norm
% Version 1.0
%
% In this version, we tried to implement the function handle as professor
% Studer talked
%
% 
%
% This code uses the enframe and overlapadd function of the VOICEBOX, SPGL,
% and Toolbox_Optim
%-------------------------------------------------------------------------

addpath('./spgl1-1.8');
addpath('./toolbox_optim');
addpath('./toolbox_optim/toolbox/');

%%
% Load Vactor.



%%
% Display it.

clf;
plot(X);

%%
% We aim at minimising:

%%
% |min_x 1/2*norm(y-x)^2 + lambda* cluster_norm (K(x),1)|


%%
% Regularization parameter.

lambda = 1;

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

Normalize = @(u)u./ max(Amplitude(u),1e-10);
ProxF = @(u,tau) perform_soft_thresholding(Amplitude(u),lambda*tau) .* Normalize(u);
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

clf;
plot(xAdmm);


 