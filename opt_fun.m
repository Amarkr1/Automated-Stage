function F = opt_fun(param0)
            F=[];
            %disp(strcat('self.CoordNum: ',num2str(self.CoordNum)));
%             param0
            sx=param0(1);
            sy=param0(2);
            %s=param0(1);
%             disp(strcat('scaling factor x: ',num2str(sx)));
%             disp(strcat('scaling factor y: ',num2str(sy)));
            %sx=sy;
            theta=param0(3);
%             disp(strcat('angle: ',num2str(theta)));
            d1 = param0(4);
            d2 = param0(5);
%             disp(strcat('offset 1: ',num2str(d1)));
%             disp(strcat('offset 2: ',num2str(d2)));
            l1 = param0(6);
            l2 = param0(7);
            
            %Transform matrix 
            T1 = [sx*cos(theta), -sy*sin(theta);
                sx*sin(theta), sy*cos(theta)];
            T2 = [1, l1; l2, 1];
            D = [d1;d2];  %offset
%             for (ii=1:1:self.CoordNum)
            load('motor_allX.mat');
            load('motor_allY.mat');
            load('gds_allX.mat');
            load('gds_allY.mat');
            for (ii=1:1:3)
%                 F(end+1:end+2)=T2*T1*self.GDSCoordPairs.coord(ii,:)'/1000 + D - self.MotorPosPairs.coord(ii,:)'/1000;
                F(end+1:end+2)=T2*T1*[gds_allX(ii),gds_allY(ii)]'/1000 + D - [motor_allX(ii),motor_allY(ii)]'/1000;
            end
            %division by 1000 is for numerical reasons, paramters should be
            %same order of magnitud
            
            %                 F(1) = sx*cos(theta)*GDS_coord(1,1)-sx*sin(theta)*GDS_coord(1,2)-mot_pos(1,1)+d1;
            %                 F(2) = sy*sin(theta)*GDS_coord(1,1)+sy*cos(theta)*GDS_coord(1,2)-mot_pos(1,2)+d2;
            %                 F(3) = sx*cos(theta)*GDS_coord(2,1)-sx*sin(theta)*GDS_coord(2,2)-mot_pos(2,1)+d1;
            %                 F(4) = sy*sin(theta)*GDS_coord(2,1)+sy*cos(theta)*GDS_coord(2,2)-mot_pos(2,2)+d2;
            %                 F(5) = sx*cos(theta)*GDS_coord(3,1)-sx*sin(theta)*GDS_coord(3,2)-mot_pos(3,1)+d1;
            %                 F(6) = sy*sin(theta)*GDS_coord(3,1)+sy*cos(theta)*GDS_coord(3,2)-mot_pos(3,2)+d2;
            %
            %A=[sx*cos(theta), -sx*sin(theta), -1 0; sy*sin(theta), sy*cos(theta), 0, -1];
            %d=[d1; d2];
            
        end