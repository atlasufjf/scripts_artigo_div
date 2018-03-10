function [V, RN, L1, IP, SQ, L2, SH, CO] = DFSelectDx(setup,sg,nest,rn,name,itp,errortype)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FULL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,xgrid,~,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,'full',errortype);        
P = ygrid;
Q = ytruth;
P=P(:,1:end-1)';
Q=Q(:,1:end-1)';
dx = diff(xgrid');


%% Divergencia entre duas fun��es

%% FAMILIA CORRELATION
C = corr(P,Q,'Type','Pearson')'; %X
RN.Pearson = C(1,:);
%% L1 FAMILY
L1.Sorensen = sum(abs(P-Q).*dx)./sum(abs(P+Q).*dx);%X
%% INNER PRODUCT FAMILY
IP.Innerproduct = sum(P.*Q.*dx);%X
IPf1 = ((P.*Q)./(P+Q));
IPf1(isnan(IPf1)|isinf(IPf1))=0;
IP.Harmonic = 2*sum(IPf1.*dx);%X
IP.Cosine = (sum(P.*Q.*dx)./(sqrt(sum((P.^2).*dx)).*sqrt(sum((Q.^2).*dx))));%X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear P Q dx xgrid ygrid ytruth
[~,xgrid,~,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,'fit',errortype);   
clear setup sg
Pfit = ygrid;
Qfit = ytruth;

Pfit=Pfit(:,1:end-1)';
Qfit=Qfit(:,1:end-1)';
dxfit = diff(xgrid');

%% FAMILIA LP MINKOWSKI
LP.LInf = max(abs(Pfit-Qfit));
LP.L2N = sqrt(sum(((Pfit-Qfit).^2).*dxfit));

%% L1 FAMILY
L1.Gower = sum(abs(Pfit-Qfit).*dxfit);

%% Squared-Chord Family
SQ.Hellinger = sqrt(((1/2)*sum(((sqrt(Pfit)-sqrt(Qfit)).^2).*dxfit)));

%% Squared L2 Family
L2.MISE = sum(((Pfit-Qfit).^2).*dxfit);

L2f=(((Pfit-Qfit).^2)./(Pfit+Qfit)).*dxfit;
L2f(isnan(L2f)|isinf(L2f))=0;
L2.Squared = sqrt(sum(L2f));

L2f3 = (((Pfit-Qfit).^2).*((Pfit+Qfit)))./Pfit.*Qfit;
L2f3(isnan(L2f3)|isinf(L2f3))=0;
L2.AddSym = sum(L2f3.*dxfit); %X

%% Shannons entropy Family
SHf=(Qfit.*log((Qfit./Pfit)));
SHf(isnan(SHf)|isinf(SHf))=0;
SH.Kullback = sum(SHf.*dxfit);


%% Combinations Family
Cot = ((Pfit+Qfit)/2).*log((Pfit+Qfit)./(2*sqrt(Pfit.*Qfit)));
Cot(isnan(Cot)|isinf(Cot))=0;
CO.Taneja = sum(Cot.*dxfit); %X


COf=((Pfit.^2-Qfit.^2).^2)./(2*(Pfit.*Qfit).^(3/2));
COf(isnan(COf)|isinf(COf))=0;
CO.Kumar = sum(COf.*dxfit); %X


V = ([(cell2mat(struct2cell(RN))') ...
    abs(cell2mat(struct2cell(LP))') ...
    abs(cell2mat(struct2cell(L1))') ...
    abs(cell2mat(struct2cell(IP))') ...
    abs(cell2mat(struct2cell(SQ))') ...
    abs(cell2mat(struct2cell(L2))') ...
    cell2mat(struct2cell(SH))' ...
    abs(cell2mat(struct2cell(CO))')]);

V=real(V);
end




