%%
% Regularization parameter.


y = x_hat;
lambda = .01;


%%
% where |K| is a permutation matrx of choosing clusters.

K = @(x) cluster_dic_func(x, block_size);
KS = @(x) cluster_dic_inv(x, block_size);

%%
% It can be put as the minimization of |F(K*x) + G(x)|


F = @(u)lambda*cluster_norm(u);
G = @(x)1/2*norm(y-x)^2;

%%
% The proximity operator of |F| is the soft thresholding.


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
% Tranform into time domain
X_cluster_denoised = fD(xAdmm,1);



%%
% Plot the spectrogram


subplot(2,2,4);
spectrogram(X_cluster_denoised,wn,overlap,winSize,fs,'yaxis');
title(['Spectrogram of denoised piano sound A5, \epsilon=' num2str(epsilon)]);
ylim([0 6000]);
colorbar;

% figure();
% plot(epsilon,MSE_dB);
% title()
% figure();
% plot(epsilon,PSNR_dB);