rand('twister',0); randn('state',5);  % Initialize random number generator
m = 50; n = 128;                      % Measurement matrix is m x n
k = 14;                               % Set sparsity level x0
A = randn(m,n);                       % Random encoding matrix
nGroups = 30;
groups  = sort(ceil(rand(n,1) * nGroups)); % Sort for display purpose
p       = randperm(nGroups); p = p(1:3);
idx     = ismember(groups,p);