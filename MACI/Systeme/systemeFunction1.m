function out = systemeFunction1(theta,y,flag) 

%Fonction exprimant le syst�me My=F. A resoudre avec ODE45. Fait appel �
%MatF1, fonction repr�sentant F (vecteur du second membre) et MatM1, 
%fonction repr�sentatnt M (matrice masse).
%
%theta : angle du vilebrequin repr�sentant le temps
%y     : vecteur des grandeurs physiques inconnues dans la chambre de combustion
%y(1)  : P pression
%y(2)  : T temp�rature
%Y(3)  : m masse totale des gaz
%y(4)  : mu masse totale des gaz frais
%y(5)  : mb masse totale des gaz br�l�s
%y(6)  : f=mb/m fraction de gaz br�l�s
%y(7)  : mcapa masse de gaz br�l�s dans la capacit� remplie par backflow

    switch flag
        % calcul de la matrice excitation F
        case '' 
            out=MatF1(theta,y);

        %calcul de la matrice masse
        case 'mass' 
            out=MatM1(theta,y);
    end
end

