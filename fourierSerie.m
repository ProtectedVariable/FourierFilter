function [out] = fourierSerie( s,n )
%fourierSeries Function that returns the fourier series approximation
%for the function s, with n terms

% We define a0 as the integral of the function divided by 2pi
a0=integral(s,-pi,pi)./(2*pi);

r = @(x) a0;
% for n terms, we compute the coeffs
for k=1:n;
%     we define our two functions
    v = @(t) cos(k.*t).*s(t);
    u = @(t) sin(k.*t).*s(t);
%     we calculate the coeffs by doing the integral divided by pi
    a = integral(v,-pi,pi)./pi;
    b = integral(u,-pi,pi)./pi;
%     we add to the value of our approximate function
    r= @(x) r(x) + (a.*cos(k.*x)+b.*sin(k.*x));
end
out = r;
end

