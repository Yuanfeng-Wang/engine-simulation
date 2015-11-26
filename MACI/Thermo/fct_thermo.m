function out = fct_thermo(X,T,type,f)

%Fonction qui donne la valeur d'une grandeur thermodynamique d'un m�lange, 
%� partir des tables Janaf, pour une temp�rature donn�e.
%
%out = fct_thermo(X,T,type,f)
%
%type   : grandeur thermodynamique � calculer 
%       'r' : R/M avec R constante universelle des gaz parfaits [J/(kg.K)]
%       'cp': capacit� calorifique massique � pression constante [J/(kg.K)]
%       'cv': capacit� calorifique massique � volume constant [J/(kg.K)]
%       'gamma': cp/cv : coefficient de Laplace [-]
%       'h' : enthalpie massique [J/kg]
%       's' : entropie massique [J/(kg.K)]
%       'u' : �nergie interne massique [J/kg]
%X      : vecteur des fractions molaires [H H2 O O2 OH H2O CO CO2 N N2 NO CxHy]
%T      : temp�rature pour laquelle on veut calculer la grandeur thermo
%f      : fraction massique des gaz br�l�s. f=mb/m (m : masse totale du 
%         m�lange gaz et mb : masse totale des gaz br�l�s)

    global R Mi Alow Ahigh ufu0 ufb0
    TableJanaf

    if (T<=1000 & T>=250)
        A=Alow;
    else (T<=3000 & T>1000);
        A=Ahigh;
    end

    switch type 
        case 'r'
            %Masse Molaire du melange
            M=Mi*X;

            %Constante des gaz parfaits
            out=R/M;

        case 'cp'
            vectT=[1 T T^2 T^3 T^4 T^5]';
            %Masse Molaire du melange
            M=Mi*X;
            %Chaleur sp�cifique � pression constante
            Cp=R*A(:,1:5)*vectT(1:5);
            out=(Cp'*X)/M;

        case 'cv'
            vectT=[1 T T^2 T^3 T^4 T^5]';
            %Masse Molaire du melange
            M=Mi*X;

            %Constante des gaz parfaits!!!
            r=R/M;

            %Chaleur sp�cifique � pression constante
            Cp=R*A(:,1:5)*vectT(1:5);
            cp=(Cp'*X)/M;

            %Chaleur sp�cifique � volume constant
            out=cp-r;

        case 'gamma'        
            vectT=[1 T T^2 T^3 T^4 T^5]';
            %Masse Molaire du melange
            M=Mi*X;
            %Constante des gaz parfaits!!!
            r=R/M; 
            %Chaleur sp�cifique � pression constante
            Cp=R*A(:,1:5)*vectT(1:5);
            cp=(Cp'*X)/M;
            %Chaleur sp�cifique � volume constant
            cv=cp-r;

            %Coefficient de Laplace!!!
            out=cp/cv;

        case 'h'
            vectT=[1 T T^2 T^3 T^4 T^5]';
            vectFraction=[1 1/2 1/3 1/4 1/5]';
            %Masse Molaire du melange
            M=Mi*X;

            %Enthalpie
            Hi=R*(A(:,1:5)*(vectFraction.*vectT(2:6))+A(:,6));
            out=(Hi'*X)/M;


         case 's'       
            vectT=[1 T T^2 T^3 T^4 T^5]';
            vectFraction=[1 1/2 1/3 1/4 1/5]';
            %Masse Molaire du melange
            M=Mi*X;
            %Entropie
            Si=R*(A(:,1)*log(vectT(2))+A(:,2:5)*(vectFraction(1:4).*vectT(1:4))+A(:,7));
            out=(Si'*X)/M;         

        case 'u'
            % Calcul de l'int�gral 
            if (T>=250 && T<=1000) 
                T0 = 273.15;
                int_Cv = fct_prim_Cv(X,Alow,T) - fct_prim_Cv(X,Alow,T0);
            else
                Tlim = 1000; T0 = 273.15;
                int_Cv = fct_prim_Cv(X,Ahigh,T) - fct_prim_Cv(X,Ahigh,Tlim) + ...
                    fct_prim_Cv(X,Alow,Tlim) - fct_prim_Cv(X,Alow,T0);
            end
            out = (1-f)*ufu0 + f*ufb0 + int_Cv ;

    end

end