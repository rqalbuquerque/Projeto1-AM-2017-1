function density = calc_mvnpdf(x, MU, SIGMA)

	d = length(MU);

	density = ( (2*pi)^(-d/2) ) * ( prod(SIGMA)^(-0.5) ) * exp ( - sum( ((x-MU).^2)/SIGMA)/2);
	%R = chol (SIGMA);
	%density = (2*pi)^(-P/2) * exp (-sumsq ((X-MU)/R, 2)/2) / prod (diag (R));

end