global AOA RFA AOE RFE   LmaxAdm LmaxEch 
global cycle
% A mettre en global dans votre programme d'appel
Dadm=0.0368;                % diam�tre de soupape d'admission (m)
Dechap=0.029;             % diam�tre de soupape d'�chappement (m)
NbSoupAdm=1;                % Nb de soupape d'admission
NbSoupEch=1;                % Nb de soupape d'�chappement
LmaxEch=9.196e-3;                  % Lev�e soupape d'�chappement
LmaxAdm=9.196e-3;                  % Lev�e soupape d'admission
RFA=262;                    % retard � la fermeture de la soupape d'admission d�fini � partir de 0 (�)
AOA=683; %700                   % avance � l'ouverture de la soupape d'�chappement d�finie � partir de 0 (�)
RFE=38;%40                    % retard � la fermeture de la soupape d'admission d�fini � partir de 0 (�)
AOE=459;                    % retard � l'ouverture de la soupape d'admission d�fini � partir de 0 (�)
cycle=720;


% figure
% for teta=1:720
%     levadm(teta)=fLevee(teta,'adm');
%        levech(teta)=fLevee(teta,'ech');
% end
% teta=1:720;
% plot(teta,levadm,teta,levech)