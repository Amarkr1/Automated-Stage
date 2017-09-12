function [pos_mtr] = mapMotorCoordinates(pos_gds_ref,pos_mtr_ref,pos_gds)
% Initialize
pos_mtr = [pos_gds_ref;pos_gds]; % include markers in the matrix to be transformed, so that they can be compared with the motor markers
figure; col = 'rgb';
for i=1:3
    scatter(pos_mtr_ref(i,1),pos_mtr_ref(i,2),['*',col(i)]); hold on;
    scatter(pos_mtr(i,1),pos_mtr(i,2),['x',col(i)]); 
end
scatter(pos_mtr(:,1),pos_mtr(:,2),'ok'); 
hold off; axis tight; title('conversion map');

% Mirror: because gds & motor coordinates appear to be mirrored in Y
pos_gds_ref_inv = [pos_gds_ref(:,1),-pos_gds_ref(:,2)];
pos_mtr = [pos_mtr(:,1),-pos_mtr(:,2)];
for i=1:3
    scatter(pos_mtr_ref(i,1),pos_mtr_ref(i,2),['*',col(i)]); hold on;
    scatter(pos_mtr(i,1),pos_mtr(i,2),['x',col(i)]); 
end
scatter(pos_mtr(:,1),pos_mtr(:,2),'ok'); 
hold off; axis tight; title('conversion map');

% Translation
dXY = mean(pos_gds_ref_inv-pos_mtr_ref); % translation matrix
pos_mtr = pos_mtr - meshgrid(dXY,ones(length(pos_mtr),1));
for i=1:3
    scatter(pos_mtr_ref(i,1),pos_mtr_ref(i,2),['*',col(i)]); hold on;
    scatter(pos_mtr(i,1),pos_mtr(i,2),['x',col(i)]); 
end
scatter(pos_mtr(:,1),pos_mtr(:,2),'ok'); 
hold off; axis tight; title('conversion map');

% % Rotation
% [pos_mtr_ref_t,pos_mtr_ref_r] = cart2pol(pos_mtr_ref(:,1),pos_mtr_ref(:,2));
% [pos_mtr_now_t,pos_mtr_now_r] = cart2pol(pos_mtr(1:length(pos_gds_ref),1),pos_mtr(1:length(pos_gds_ref),2));
% dTheta = mean(pos_mtr_ref_t-pos_mtr_now_t);
% 
% [pos_mtr_t,pos_mtr_r] = cart2pol(pos_mtr(:,1),pos_mtr(:,2));
% [pos_mtr_x,pos_mtr_y] = pol2cart(pos_mtr_t+dTheta,pos_mtr_r);
% pos_mtr = [pos_mtr_x,pos_mtr_y];
% figure; subplot(211); scatter(pos_gds_ref(:,1),pos_gds_ref(:,2),'*k'); hold on; scatter(pos_gds(:,1),pos_gds(:,2),'ob'); hold off; axis tight; title('gds');
% subplot(212); scatter(pos_mtr_ref(:,1),pos_mtr_ref(:,2),'*k'); hold on; scatter(pos_mtr(:,1),pos_mtr(:,2),'ob'); hold off; axis tight; title('motor');

pos_mtr = pos_mtr(length(pos_gds_ref)+1:end,:);
end