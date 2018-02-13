function [pos_mtr] = mapMotorCoordinates(pos_gds_ref,pos_mtr_ref,pos_gds)
% Initialize
pos_mtr = [pos_gds_ref;pos_gds]; % include markers in the matrix to be transformed, so that they can be compared with the motor markers
col = 'rgb';

% for i=1:3
%     scatter(pos_mtr_ref(i,1),pos_mtr_ref(i,2),['s',col(i)]); hold on;
%     text(pos_mtr_ref(i,1)+5,pos_mtr_ref(i,2)+5,num2str(i));
%     scatter(pos_mtr(i,1),pos_mtr(i,2),['*',col(i)]); 
%     text(pos_mtr(i,1)+1,pos_mtr(i,2)+1,num2str(i));
% end
% scatter(pos_mtr(length(pos_gds_ref)+1:end,1),pos_mtr(length(pos_gds_ref)+1:end,2),'o')
% hold on; axis tight; title('Original conversion map');
% legend({'Motor positions','GDS positions'},'Location','northwest');


a=pos_gds_ref(2,:)-pos_gds_ref(1,:);
b=pos_mtr_ref(2,:)-pos_mtr_ref(1,:);
e=[-1,0];
angle1 = sign(a(2))*acos(dot(a,e)/norm(a)/norm(e));
angle2 = sign(b(2))*acos(dot(b,e)/norm(b)/norm(e));
angle = angle1 - angle2;
%define input params : educated guess
param0 = [1,1, angle,pos_mtr_ref(1,1)/1000,pos_gds_ref(1,2)/1000,0,0]; %/1000: to on the same order of magnitude 
options = optimset('Diagnostics', 'off', 'MaxFunEvals', 10000,...
    'TolFun',1e-9,'PlotFcns',@optimplotresnorm);
%Diagnostics shoudl be 'off', 'on' for debug
[param,resnorm, residual]  = lsqnonlin(@opt_fun, param0, [],[],options);
disp('transformation matrix:');
disp(strcat('angle: ',num2str(param(3))));
disp(strcat('offset: ',num2str(param(4)),',',num2str(param(5))));
disp(strcat('scaling: ',num2str(param(1)),',',num2str(param(2))));
disp(strcat('shearing: ',num2str(param(6)),',',num2str(param(7))));

G1 = pos_gds_ref(3,:)';
m = getMotorPosn(param,G1);
[row column] = size(pos_gds);
pos_mtr = zeros(row,2);
for i=1:row
    pos_mtr(i,:) = getMotorPosn(param,pos_gds(i,:)')';
end

%generating the plots
figure;
scatter(pos_gds(:,1),pos_gds(:,2),'o');hold on
[row_ref column_ref]=size(pos_gds_ref);
for i=1:row_ref
    scatter(pos_gds_ref(i,1),pos_gds_ref(i,2),['*',col(i)]);
    text(pos_gds_ref(i,1)+5,pos_gds_ref(i,2)+5,num2str(i));
end
axis tight; title('gds coordinates map');
legend({'to be measured','references'},'Location','northwest');

figure;
scatter(pos_mtr(:,1),pos_mtr(:,2),'+');hold on;
for i=1:row_ref
    ref = getMotorPosn(param,[pos_gds_ref(i,1);pos_gds_ref(i,2)]);
    ref_x = ref(1);
    ref_y = ref(2);
    scatter(ref_x,ref_y,['s',col(i)]);
    text(ref_x+5,ref_y+5,num2str(i));
end
scatter(pos_mtr_ref(:,1),pos_mtr_ref(:,2),'p');
axis tight; title('motor coordinates');
legend({'to be measured','references'},'Location','northwest');

%Yannick's code{This method might not work because the transformatiuon matrix is not general}
% Mirror: because gds & motor coordinates appear to be mirrored in Y
% subplot(132)
% pos_gds_ref_inv = [pos_gds_ref(:,1),-pos_gds_ref(:,2)];
% scatter(pos_mtr(length(pos_gds_ref)+1:end,1),pos_mtr(length(pos_gds_ref)+1:end,2),'*');hold on;
% pos_mtr = [pos_mtr(:,1),-pos_mtr(:,2)];
% for i=1:3
%     scatter(pos_mtr_ref(i,1),pos_mtr_ref(i,2),['s',col(i)]); hold on;
%     text(pos_mtr_ref(i,1)+5,pos_mtr_ref(i,2)+5,num2str(i));
%     scatter(pos_mtr(i,1),pos_mtr(i,2),['*',col(i)]); 
%     text(pos_mtr(i,1)+5,pos_mtr(i,2)+5,num2str(i));
% end
%  
% hold on; axis tight; title('After rotation Conversion map');
% legend({'Motor positions','GDS positions'},'Location','northwest');
% scatter(pos_mtr(length(pos_gds_ref)+1:end,1),pos_mtr(length(pos_gds_ref)+1:end,2),'*')
% 
% % Translation
% dXY = mean(pos_gds_ref_inv-pos_mtr_ref); % translation matrix
% pos_mtr = pos_mtr - meshgrid(dXY,ones(length(pos_mtr),1));
% subplot(133)
% scatter(pos_gds(:,1),pos_gds(:,2),'*');hold on;
% for i=1:3
%     scatter(pos_mtr_ref(i,1),pos_mtr_ref(i,2),['s',col(i)]); hold on;
%     text(pos_mtr_ref(i,1)+5,pos_mtr_ref(i,2)+5,num2str(i));
%     scatter(pos_mtr(i,1),pos_mtr(i,2),['*',col(i)]); 
%     text(pos_mtr(i,1)+1,pos_mtr(i,2)+1,num2str(i));
% end
% scatter(pos_mtr(:,1),pos_mtr(:,2),'o'); 
% hold on; axis tight; title('Final conversion map');
% legend({'Motor positions','GDS positions'},'Location','northwest');
% 
% % % Rotation
% % [pos_mtr_ref_t,pos_mtr_ref_r] = cart2pol(pos_mtr_ref(:,1),pos_mtr_ref(:,2));
% % [pos_mtr_now_t,pos_mtr_now_r] = cart2pol(pos_mtr(1:length(pos_gds_ref),1),pos_mtr(1:length(pos_gds_ref),2));
% % dTheta = mean(pos_mtr_ref_t-pos_mtr_now_t);
% % 
% % [pos_mtr_t,pos_mtr_r] = cart2pol(pos_mtr(:,1),pos_mtr(:,2));
% % [pos_mtr_x,pos_mtr_y] = pol2cart(pos_mtr_t+dTheta,pos_mtr_r);
% % pos_mtr = [pos_mtr_x,pos_mtr_y];
% % figure; subplot(211); scatter(pos_gds_ref(:,1),pos_gds_ref(:,2),'*k'); hold on; scatter(pos_gds(:,1),pos_gds(:,2),'ob'); hold off; axis tight; title('gds');
% % subplot(212); scatter(pos_mtr_ref(:,1),pos_mtr_ref(:,2),'*k'); hold on; scatter(pos_mtr(:,1),pos_mtr(:,2),'ob'); hold off; axis tight; title('motor');
% 
% pos_mtr = pos_mtr(length(pos_gds_ref)+1:end,:)
% scatter(pos_mtr(:,1),pos_mtr(:,2),'*')
%Yannick's code
end

function motor_pos =  getMotorPosn(param,GDS_coords)
rot_angle=param(3);
offset = param(4:5)*1000; %convert back to microns
scaling = param(1:2); %since in software everthing is in [um] shoudl be 1 or -1
lambda = param(6:7); %if no shearing they should be 0; 

T1 = [scaling(1)*cos(rot_angle), -scaling(2)*sin(rot_angle);
            scaling(1)*sin(rot_angle), scaling(2)*cos(rot_angle)];
%                 T2 = [1, lambda(1);...
%                     lambda(2), 1];
T2=[1,lambda(1);0,1]*[1,0;lambda(2),1];
D = [offset(1);offset(2)];  %offset

motor_pos = T2*T1*GDS_coords + D;
end