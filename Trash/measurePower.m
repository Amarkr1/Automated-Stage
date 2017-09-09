% % function [data] = measurePower()
pPout = libpointer('doublePtr', zeros(1, 1));
pP1 = libpointer('doublePtr', zeros(1, 1));
pP2 = libpointer('doublePtr', zeros(1, 1));
pP3 = libpointer('doublePtr', zeros(1, 1));
pP4 = libpointer('doublePtr', zeros(1, 1));
pVext = libpointer('doublePtr', zeros(1, 1));

while(1)
calllib('CT400_lib', 'CT400_ReadPowerDetectors', uiHandle, pPout, pP1, pP2, pP3, pP4, pVext);
fprintf('Pout: %2.2f, P1: %2.2f, P2: %2.2f, P3: %2.2f, P4: %2.2f\n', pPout.Value, pP1.Value, pP2.Value, pP3.Value, pP4.Value);
pause(0.1)
end

% end
