function [x,Supp] = OMP(D, y, tol, max_iter)
N = size(D, 2);
col = size(y, 2);
x = zeros(N,col);
for i = 1:col
    iter = 0;
    res = y(:,i);
    Supp = [];
    err = norm(res);
    while (err >= tol) && (iter <= max_iter)
        iter = iter + 1;
        proxy = D'*res;
        [val, idx] = max(abs(proxy));
        Supp = [ Supp idx ];
        x(:,i) = zeros(N, 1);
        x(Supp,i) = D(:, Supp) \ y(:,i); % There are better ways for solving this.
        res = y(:,i) - D*x(:,i);
        err = norm(res);
    end
end
end