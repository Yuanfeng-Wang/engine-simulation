function [ufu0, ufb0] = fct_uformation ()

%Fonction qui calcule l'�nergie interne massique de formation � une 
%temp�rature de r�f�rence Tref=273.15K pour un m�lange de gaz frais ou un 
%m�lange de gaz br�l�s

	global R Mi Xu Xb 

	Tref = 273.15;

	Mu = Mi*Xu;
	Mb = Mi*Xb;

	hfu0= fct_thermo(Xu,Tref,'h');
	hfb0= fct_thermo(Xb,Tref,'h');

	ufu0 = hfu0 - R*Tref/Mu;
	ufb0 = hfb0 - R*Tref/Mb;

end

