function [param] = computeTransferMatrix()
            %optimized the privat function opt_fun
            %init paratmers;
            %param0 = [sx sy theta d1 d2];
            load('motor_allX.mat');
            load('motor_allY.mat');
            load('gds_allX.mat');
            load('gds_allY.mat');
            %Try to predict angle 
            %DEBUG: mirroring is not taking into account (only for
            %prediction)
            a=[gds_allX(2);gds_allY(2)]-[gds_allX(1);gds_allY(1)];
            b=[motor_allX(2);motor_allY(2)]-[motor_allX(1);motor_allY(1)];
            e=[-1,0];
            angle1 = sign(a(2))*acos(dot(a,e)/norm(a)/norm(e));
            angle2 = sign(b(2))*acos(dot(b,e)/norm(b)/norm(e));
            angle = angle1 - angle2;
            %define input params : educated guess
            param0 = [1,1, angle,motor_allX(1)/1000,motor_allY(1)/1000,0,0]; %/1000: to on the same order of magnitude 
%             options = optimset('Diagnostics', 'on', 'MaxFunEvals', 10000,...
%                 'TolFun',1e-8,'PlotFcns',@optimplotresnorm);
            %Diagnostics shoudl be 'off', 'on' for debug
            lb = [-2000, -2000, -10, -10000, -10000,-0.1, -0.1];
            ub = [2000, 2000, 10, 10000,10000,0.1,0.1];
%             [param,resnorm, residual]  = lsqnonlin(@opt_fun, param0, [],[],options);
            [param,~]  = lsqnonlin(@opt_fun, param0);
            warning('off')
            
%             disp('transformation matrix:');
%             disp(strcat('angle: ',num2str(param(3))));
%             disp(strcat('offset: ',num2str(param(4)),',',num2str(param(5))));
%             disp(strcat('scaling: ',num2str(param(1)),',',num2str(param(2))));
%             disp(strcat('shearing: ',num2str(param(6)),',',num2str(param(7))));
            
                       
end

