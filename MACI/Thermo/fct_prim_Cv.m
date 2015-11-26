function prim_Cv = fct_prim_Cv(X,A,T)

%Calcule la primitive de cv � une temp�rature T
%
%prim_Cv = fct_prim_Cv(X,A,T)
%
%A : coefficients l'approximation polynomiale des tables Janaf
%T : temp�rature de calcul
%X : vecteur des fractions molaires du m�lange
%prim_Cv : vecteur de la primitive sur chaque composant du m�lange
%
%Fonction appel� dans fct_thermo pour le calcul de l'�nergie interne

    vectT=[1 T T^2 T^3 T^4 T^5]';
    vectFraction=[1 1/2 1/3 1/4 1/5]';
    r = fct_thermo(X,T,'r');
    prim_Cv = (r * ((A(:,1)-1)*T + A(:,2:5)* (vectFraction(2:5).*vectT(3:6))))'*X;

end