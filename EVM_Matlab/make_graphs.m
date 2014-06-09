% figure
% hold
%for iterator = (size(DCT_Y,2)/2-1):(size(DCT_Y,2)/2-1)
%errorbar(OMP_X,DCT_5Hz_Y(:,2*iterator+1),DCT_5Hz_Y(:,2*iterator+2), 'r');
%end





figure
axes1 = axes('Parent',figure,'YColor',[1 0 0],'XColor',[1 0 0]);
line(OMP_5Hz_noise0501(:,1),abs(OMP_5Hz_noise0501(:,2)-18),'Parent',axes1,'Marker','x','LineStyle',':',...
    'Color',[1 0 0],...
    'DisplayName','OMP 5Hz');

haxes1 = gca; % handle to axes
set(haxes1,'XColor','r','YColor','r')
line(OMP_noise0501(:,1),abs(OMP_noise0501(:,2)-18),'Parent',axes1,'Marker','.','Color',[1 0 0],...
    'DisplayName','OMP');
haxes1 = gca; % handle to axes
set(haxes1,'XColor','r','YColor','r')
haxes1_pos = get(haxes1,'Position'); % store position of first axes
haxes2 = axes('Position',haxes1_pos,...
              'XAxisLocation','top',...
              'YAxisLocation','right',...
              'Color','none');

line(DCT_5Hz_noise0501(:,1), abs(DCT_5Hz_noise0501(:,2)-18),'Parent',haxes2,'Marker','square','LineStyle','--',...
    'DisplayName','DCT 5Hz');
line(DCT_noise0501(:,1), abs(DCT_noise0501(:,2)-18),'Parent',haxes2,'Marker','o','Color',[0 1 0],...
    'DisplayName','DCT');

legend1 = legend(axes1,'show');
legend(haxes2,'show');