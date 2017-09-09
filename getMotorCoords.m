function [motor_pos] = getMotorCoords(GDS_coords)
                param = computeTransferMatrix;
                
                T1 = [param(1)*cos(param(3)), -param(2)*sin(param(3));
                    param(1)*sin(param(3)), param(2)*cos(param(3))];
                T2 = [1, param(6);...
                    param(7), 1];
                D = [param(4)*1000;param(5)*1000];  %offset
                
                motor_pos = T2*T1*GDS_coords + D;
                        
        end
        