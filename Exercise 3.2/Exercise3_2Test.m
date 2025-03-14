clear; clc; close all;

% Input [m s ρ]
% m = [0.0, 0.7] NB! Any value = (0.7, 1.0] will return mean range value
% 0.5!!
% s = [0.0, 1.0]
% ρ = [0.0, 1.0]


Input = [0.1 0.1 0.9];

fis = readfis("Exercise3.2.fis");
evalfis(fis, Input)