function lev=fLevee(teta,type)

%Fonction qui donne la hauteur de la lev�e de la soupape.
%
%lev=fLevee(teta,type)
%
%teta   : angle du vilebrequin repr�sentant le temps
%type   : 'adm' pour admission ou 'ech' pour echappement
%lev    : hauteur de la lev�e [m]

    %Nous n'allons pas utiliser les valeurs de OCA FCA et LmaxCA  
    global AOA RFA AOE RFE OCA FCA LmaxAdm LmaxEch LmaxCA cycle
    
    %global levEch levAdm
    % A revoir probl�me pour des RFE <720
    
    teta=mod(teta,cycle);
    tetac=teta;casCA=0;
    switch type
        case 'ech'
            % ordre de d�finition des angles de distribution
            AO=AOE;RF=RFE;
            if RFE < AOE
                RF=RFE+720;
                if tetac < RFE
                    tetac=teta+720;
                end
            end
            Lmax=LmaxEch;
        case 'adm'
            % ordre de d�finition des angles de distribution
            AO=AOA;  RF=RFA;
            if AOA > RFA
                AO=AOA-720;
                if tetac > RFA
                    tetac=teta-720;
                end
            end
            Lmax=LmaxAdm;
        case 'CA'
            % Chambre auxiliaire
            casCA=1;
            AO=OCA;
            RF=FCA;
            Lmax=LmaxCA;
    end
    AngLmax=(RF-AO)/2+AO;

    if (tetac>AO && tetac<RF)
        if casCA==1
            lev=Lmax;
        else
            lev=(-cos( (tetac- (AngLmax+(RF-AO)/2))*2*pi/(RF-AO) )  +1)/2*Lmax;
        end
    else
        lev=0;
    end
end



