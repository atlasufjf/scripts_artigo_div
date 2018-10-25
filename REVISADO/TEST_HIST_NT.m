% TEST DISTRIBUI�ES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUI��ES QUE SER�O UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'nearest';
errortype = 'none';
mod = 'abs';
j=0;
cl = ['yrbgkmc'];
% for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
name = {'Rayleigh'};
nEST = 10;
nROI = 1;
nGRID = 10^5;
binmax = 100;
ntmax = 25;
out = [];
vEVT = [100 500 1000 2000 5000];

wb=waitbar(0,'Aguarde...');
for j = 1:length(vEVT)
    nEVT = round(vEVT(j));
    for i = 1:ntmax
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Par�metros Iniciais
        [DATA] = datasetGenSingle(setup);
        [bin,C]=calcnbins([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out],'all');
        [bin.truth,~,~]=bintruth(DATA,100,inter);
        
        BFD(i,j) = bin.fd;
        BSC(i,j) = bin.scott;
        BST(i,j) = bin.sturges;
        BDO(i,j) = bin.doane;
        BSS(i,j) = bin.shimazaki;
        BRU(i,j) = bin.rudemo;
        BLH(i,j) = bin.LHM;
        BTR(i,j) = bin.truth;
        
        ABFD(i,j) = areaHIST(DATA,inter,bin.fd);
        ABSC(i,j) = areaHIST(DATA,inter,bin.scott);
        ABST(i,j) = areaHIST(DATA,inter,bin.sturges);
        ABDO(i,j) = areaHIST(DATA,inter,bin.doane);
        ABSS(i,j) = areaHIST(DATA,inter,bin.shimazaki);
        ABRU(i,j) = areaHIST(DATA,inter,bin.rudemo);
        ABLH(i,j) = areaHIST(DATA,inter,bin.LHM);
        ABTR(i,j) = areaHIST(DATA,inter,bin.truth);
        
    end
    waitbar(j/length(vEVT))
end
close(wb)

figure(1)
DADOS = {BFD-BTR;BSC-BTR;BST-BTR;BDO-BTR;BSS-BTR;BRU-BTR;BLH-BTR};
figure(1)
PLOTBOX(DADOS,vEVT,'Eventos','Bins'); hold on
plot([0 5000],[0 0],':k')
grid minor
set(gca,'Gridlinestyle',':')

DADOS_AREA = {ABFD;ABSC;ABST;ABDO;ABSS;ABRU;ABLH;ABTR};
figure(2)
PLOTBOX(DADOS_AREA,vEVT,'Eventos','Erro (�rea)'); hold on
plot([0 5000],[0 0],':k')
grid minor
set(gca,'Gridlinestyle',':')