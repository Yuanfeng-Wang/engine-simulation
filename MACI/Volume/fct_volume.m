function [V,dvdta]=fct_volume(theta)
    
%Donne le volume de la chambre et de sa variation � un angle du
%vilebrequin donn�
%
%[V,dvdta]=fct_volume(theta)
%teta : angle du vilebrequin [degr�s]
%V : volume de la chambre [m^3]
%dvdta : variation en fonction de teta [m^3/degr�s]

    global Vm Cu lambda 
    
    theta=toRadians(theta);
    V=Vm+Cu/2*(1+lambda-cos(theta)-sqrt(lambda^2-sin(theta)^2));
    dvdta=pi/180*1/2*Cu*sin(theta)*(1+cos(theta)/sqrt(lambda^2-sin(theta)^2));
end
