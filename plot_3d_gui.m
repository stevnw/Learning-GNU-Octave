% A script that hopefully plots the values from the gui using Octave - lol

% Input handle shit lol

args = argv();

x_start = str2double(args{1});
x_end = str2double(args{2});
x_step = str2double(args{3});
y_start = str2double(args{4});
y_end = str2double(args{5});
y_step = str2double(args{6});
z_expr = args{7};

% Generate grid
x = x_start:x_step:x_end;
y = y_start:y_step:y_end;
[X, Y] = meshgrid(x, y);

% Evaluate the Z expression!!!
try
    Z = eval(z_expr);
catch
    error('Invalid expression! Use X/Y (e.g., "sin(X) + cos(Y)")');
end

% Plot shit
figure;
surf(X, Y, Z);
title('This is a title!');
xlabel('X'); ylabel('Y'); zlabel('Z');
colorbar;
grid on;
pause;  % Keep plot open, I hope ?
