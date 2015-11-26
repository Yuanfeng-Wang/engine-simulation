function CD=fct_CD(lv)
%Fonction qui calcule le coefficient de d�bit en fonction de la lev�e de la
%soupape.
%
%CD=fct_CD(lv)
%
%CD : coefficient de d�bit [-]
%lv : lev�e de la soupape [m]

    CD = 0.05*10^3*lv+0.65;

end
