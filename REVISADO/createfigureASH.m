function createfigureASH(XMatrix1, YMatrix1, EMatrix1)
%CREATEFIGURE(XMATRIX1, YMATRIX1, EMATRIX1)
%  XMATRIX1:  errorbar x matrix
%  YMATRIX1:  errorbar y matrix
%  EMATRIX1:  errorbar e matrix

%  Auto-generated by MATLAB on 11-Oct-2018 14:40:07

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple error bars using matrix input to errorbar
for i = 1:size(YMatrix1,2)   
errorbar1(i) = errorbar(XMatrix1,YMatrix1(:,i),EMatrix1(:,i),'MarkerSize',4,...
    'Marker','square',...
    'LineStyle',':'); hold on
end
set(errorbar1(8),'DisplayName','Truth',...
    'MarkerFaceColor',[0 1 0],...
    'Color',[0 1 0]);
set(errorbar1(7),'DisplayName','LHM',...
    'MarkerFaceColor',[0.501960813999176 0.501960813999176 0.501960813999176],...
    'Color',[0.501960813999176 0.501960813999176 0.501960813999176]);
set(errorbar1(6),'DisplayName','Rudemo','Color',[1 0 0]);
set(errorbar1(5),'DisplayName','Shimazaki','MarkerFaceColor',[1 0 0],...
    'Color',[1 0 0]);
set(errorbar1(4),'DisplayName','Doane','Color',[0 0 1]);
set(errorbar1(3),'DisplayName','Sturges','MarkerFaceColor',[0 0 1],...
    'Color',[0 0 1]);
set(errorbar1(2),'DisplayName','Scott','Color',[0 0 0]);
set(errorbar1(1),'DisplayName','FD','MarkerFaceColor',[0 0 0],...
    'Color',[0 0 0]);

% Create xlabel
xlabel('M');

% Create ylabel
ylabel('�rea do Erro');

box(axes1,'on');
grid(axes1,'on');
axis(axes1,'tight');
% Set the remaining axes properties
set(axes1,'FontSize',12,'GridLineStyle',':','YScale','log');
% Create legend
legend(axes1,'show');

