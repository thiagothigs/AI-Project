function [] = visualiza_matrizOF(uxv_LK)
% figure();
%
% u=real(uxv{10});
% v=imag(uxv{10});
%
% [X,Y]=meshgrid(1:1:320,1:1:240);
% %contour(X,Y,uxv{10});
%
% hold on
% quiver(X,Y,u,v);
% colormap hsv
% hold off

figure();
[m, n] = size(uxv_LK{1,1});
%[m1, n1] = size(uxv_HS{1,1});
% %axis equal; 
% %axis tight;
% axis off;
% set(gca,'Visible','off') % desliga eixos do gráfico

for i=1:length(uxv_LK)
    clf
%     subplot(121)
    u_lk = real(uxv_LK{i});
    v_lk = imag(uxv_LK{i});
    [X_lk,Y_lk] = meshgrid(1:1:n,1:1:m);
    hold on
    quiver(X_lk,Y_lk,abs(u_lk),abs(v_lk),'r');
    title('\bfFO Lucas-Kanade - 20 Frames')
    colormap hsv
    axis off equal;
        
%     subplot(122)
%     u_hs=real(uxv_HS{i});
%     v_hs=imag(uxv_HS{i});
%     [X_hs,Y_hs] = meshgrid(1:1:n1,1:1:m1);
%     hold on
%     quiver(X_hs,Y_hs,abs(u_hs),abs(v_hs));
%     title('\bfFO Horn-Schunck - 20 Frames')
%     colormap hsv
%     axis off equal;
%     set(gcf,'Color',[1,1,1]); % cor de fundo da área de plotagem
%     set(gcf,'un','n','pos',[0,0,1,1])
    
    pause(0.2)
end

save 'matU_LK.mat' u_lk
save 'matV_LK.mat' v_lk

% save 'matU_HS.mat' u_hs
% save 'matV_HS.mat' v_hs

%contour(X,Y,uxv{10});

end