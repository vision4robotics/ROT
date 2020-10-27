function gf = train_ROT(params, xf, yf, s, t)

Sxx = cellfun(@(xf) sum(bsxfun(@times, xf, conj(xf)), 3), xf, 'UniformOutput', false);
Sxx2 = flip(Sxx);
if numel(xf) == 1
    Sxx_sum = Sxx{1};
    Sxx_dot = Sxx{1};
else
    Sxx_sum = Sxx{1} + Sxx{2};
    Sxx_dot = bsxfun(@times, Sxx{1}, Sxx{2});
end

% feature size
sz = cellfun(@(xf) size(xf), xf, 'UniformOutput', false);
N = cellfun(@(sz) sz(1) * sz(2), sz, 'UniformOutput', false);

% initialize hs
wt_f = cellfun(@(sz) zeros(sz), sz, 'UniformOutput', false);

% initialize lagrangian multiplier
zetaf = cellfun(@(sz) zeros(sz), sz, 'UniformOutput', false);

% penalty
mu = params.mu;
beta = params.beta;
mu_max = params.mu_max;
gamma = params.gamma;

iter = 1;
while iter<= params.admm_iterations
    Sxf = cellfun(@(xf, wt_f, zetaf) sum(conj(xf) .* (wt_f - 1/mu * zetaf), 3), xf, wt_f, zetaf, 'UniformOutput', false);
    Sxf2 = flip(Sxf);
    
    gf = cellfun(@(Sxx2, Sxf, Sxf2, yf, wt_f, zetaf, xf, N) ...
    ((N*mu + 2*gamma*Sxx2) .* (conj(yf)-2*Sxf) + N*mu*(gamma-1)*(Sxf2-Sxf)) ...
    ./ (N^2*mu^2 + N*mu*(1+gamma)*Sxx_sum + 4*gamma*Sxx_dot) ...
    .* xf ...
    + wt_f - 1/mu * zetaf, ...
    Sxx2, Sxf, Sxf2, yf, wt_f, zetaf, xf, N, 'UniformOutput', false);
    
    w = cellfun(@(gf, zetaf, N) t .* ifft2(mu * gf + zetaf) ./ (s.^2/N + mu * (t.^2)), gf, zetaf, N, 'UniformOutput', false);
    wt_f = cellfun(@(w) fft2(t .* w), w, 'UniformOutput', false);
    
    zetaf = cellfun(@(zetaf, gf, wt_f) zetaf + mu * (gf - wt_f), zetaf, gf, wt_f, 'UniformOutput', false);
    
    mu = min(mu_max, beta * mu);
    
    iter = iter + 1;
end