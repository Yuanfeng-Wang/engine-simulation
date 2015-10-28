function [V,dvdta]=fct_volume(teta)
    
    %Donne le volume de la chambre et de sa variation � un angle du
    %vilebrequin donn�
    %Inputs
    %teta : angle du vilebrequin [degr�s]
    %Outputs
    %V : volume de la chambre [m^3]
    %dvdta : variation en fonction de teta [m^3/degr�s]
    global Vm; 
    global Cu; 
    global lambda
    teta=toRadians(teta);
    V=Vm+Cu/2*(1+lambda-cos(teta)-sqrt(lambda^2-sin(teta)^2));
    dvdta=pi/180*1/2*Cu*sin(teta)*(1+cos(teta)/sqrt(lambda^2-sin(teta)^2));
end