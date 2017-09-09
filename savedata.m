%   David Patel [david.patel@mail.mcgill.ca]
% get current date and time, and make OS compatible filename
%function savedata(diename, filename, data)
    datetime = datestr(now, 'mmm_dd_yyyy_HH_MM_SS');
    savefile1 = ['.\' diename '\pdf\' filename '_' datetime '.pdf'];
    savefile2 = ['.\' diename '\fig\' filename '_' datetime '.fig'];
    savefile3 = ['.\' diename '\txt\' filename '_' datetime '.txt'];
    savefile4 = ['.\' diename '\eps\' filename '_' datetime '.eps'];
    savefile5 = ['.\' diename '\txt\' filename '_' datetime '.mat'];
    savefile6 = ['.\' diename '\emf\' filename '_' datetime '.emf'];
    savefile7 = ['.\' diename '\png\' filename '_' datetime '.png'];

    %set(gcf,'PaperPositionMode','auto')
    %set(gcf,'PaperOrientation','landscape');
    %print(gcf,'-dpdf',savefile1);
    saveas(gcf, savefile1, 'pdf');
    saveas(gcf,savefile2);
    save(savefile3,'data','-ASCII');
    saveas(gcf, savefile4, 'eps');
    %print(gcf,'-depsc',savefile4);
    save(savefile5,'data','-mat');
    saveas(gcf, savefile6, 'emf');
    saveas(gcf, savefile7, 'png');
%end