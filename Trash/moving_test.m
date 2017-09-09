com=serial(['COM', num2str(7)])
set(com,'BaudRate',57600);
fopen(com);
for axis_num = 1:3
    fprintf(['1 ', num2str(axis_num), ' setaxis']);
    %self.send_command([num2str(axis_num), ' getaxis']);
    %response = self.read_response();
end

        