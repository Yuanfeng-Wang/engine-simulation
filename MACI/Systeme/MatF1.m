function F = MatF1(theta,y)

%Fonction repr�sentant le second membre F du syst�me � r�soudre My=F.
%Elle est appel�e uniquement par la fonction systemeFunction1 et ne peut 
%�tre utilis�e de fa�on ind�pendante.
%
%F=MatF1(theta,y)
%
%theta : angle du vilebrequin repr�sentant le temps
%y     : vecteur des inconnus [p,T,m,mu,mb,f,mcapa]
%F     : vecteur du second membre du syst�me My=F

%-------------------------------------------------------------------------
    
%-------------------------------------------------------------------------
    global Xu Xb Mu Mb Tadm Tech P0struct T0struct
    
    %X : vecteur fractions molaires du m�lange
    X = ((y(4)/Mu)*Xu+(y(5)/Mb)*Xb)./(y(4)/(Mu)+y(5)/(Mb));
    F=zeros(7,1);
    if isempty(P0struct)||isempty(T0struct)
        disp('dq_parois nul');
        dq_parois = 0; %hypoth�se sans transfert de chaleur
    else
        h_c = fct_coef_echange(y, theta);
        dq_parois = fct_echange_chaleur( h_c, y, theta )
    end
    if y(7)<=0
        %Cas mcapa nulle
        h_adm=fct_thermo(Xu,Tadm,'h');
        h_cyl=fct_thermo(X,y(2),'h');
        h_ech=fct_thermo(Xb,Tech,'h'); 
        % hypoth�se : uniquement des gaz br�l�s � l'�chappement ?
        [~,dv]=fct_volume(theta);
        [dm_adm, dm_adm_bf]=fct_debit(theta,y,'adm');
        [dm_ech,dm_ech_bf]=fct_debit(theta,y,'ech');
        F(1)=-y(1)*dv;
        F(2)=-y(1)*dv+dq_parois+dm_adm*h_adm+dm_adm_bf*h_cyl+...
              dm_ech*h_cyl+dm_ech_bf*h_ech; 
        F(3)=0;    
        F(4)=dm_adm+(1-y(6))*dm_adm_bf+(1-y(6))*dm_ech;       
        F(5)=y(6)*dm_ech+y(6)*dm_adm_bf+dm_ech_bf;
        F(6)=0; 
        F(7)=-y(6)*dm_adm_bf;
        
    else
        %Cas mcapa positif
        h_adm=fct_thermo(Xb,Tadm,'h'); % pourquoi T=Tadm ==> hyp brassage 
        % temp�rature imm�diate ? 
        h_cyl=fct_thermo(X,y(2),'h');
        h_ech=fct_thermo(Xb,Tech,'h'); % hypoth�se : uniquement des gaz
        %br�l�s � l'�chappement ? (� �crire dans la fonction d�bit pour les
        %conditions sur la pression d'�chappement)
        [~,dv]=fct_volume(theta);
        [dm_adm, dm_adm_bf]=fct_debit(theta,y,'adm');
        [dm_ech,dm_ech_bf]=fct_debit(theta,y,'ech');
        
        F(1)=-y(1)*dv;
        F(2)=-y(1)*dv+dq_parois+dm_adm*h_adm+dm_adm_bf*h_cyl+dm_ech*h_cyl+dm_ech_bf*h_ech;
        F(3)=0; 
        F(4)=(1-y(6))*dm_adm_bf+(1-y(6))*dm_ech;       
        F(5)=dm_adm+y(6)*dm_ech+y(6)*dm_adm_bf+dm_ech_bf;
        F(6)=0; 
        F(7)=-dm_adm-y(6)*dm_adm_bf;
    end
end

