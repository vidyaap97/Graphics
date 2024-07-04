clc;
clear all;
close all;
global base_point;
global pose_counter;
global i;
base_point = [1; 0];
i=1;
pose_counter = 1;
figure;
lizard(base_point);
set(gcf, 'KeyPressFcn', @key_callback);


function key_callback(src, event)
    global pose_counter;
    global base_point;

    key = event.Key;
    if strcmp(key, 'q')
        close(gcf);
        return;
    end

    if strcmp(key, 'uparrow')
        base_point = base_point + [0; 0.3];
    elseif strcmp(key, 'downarrow')
        base_point = base_point - [0; 0.3];
    elseif strcmp(key, 'leftarrow')
        base_point = base_point - [0.3; 0];
    elseif strcmp(key, 'rightarrow')
        base_point = base_point + [0.3; 0];
    end
    lizard(base_point);
end

function lizard(base_point)
    global pose_counter;
    global i;
    sequence = [2; 3; 4; 5; 4; 3; 2;1];
    
        
    poses = [pi/4, -pi/4, pi/6, 15*pi/180, -16*pi/18, 12*pi/18, -pi/3;
    pi/6, -pi/6, 15*pi/180, 45*pi/180, -13*pi/18, 11*pi/18, -7*pi/18;
    0, 0, 0, pi/2, -pi/2, pi/2, -pi/2;
    -20*pi/180, 20*pi/180, -15*pi/180, 13*pi/18, -5*pi/18, 6*pi/18, -12*pi/18;
    -pi/6, 30*pi/180, -pi/6, 15*pi/18, -3*pi/18, pi/3, -12*pi/18];

    th1 = poses(pose_counter, 1);
    th2 = poses(pose_counter, 2);
    th3 = poses(pose_counter, 3);
    th4 = poses(pose_counter, 4);
    th5 = poses(pose_counter, 5);
    th6 = poses(pose_counter, 6);
    th7 = poses(pose_counter, 7);

    Pose(th1, th2, th3, th4, th5, th6, th7, base_point);
    pose_counter = sequence(i);
    i=i+1;
    if i > length(sequence)
        i = 1;
    end
    
end

function Pose(th1, th2, th3, th4, th5, th6, th7, base_point)
    pt1 = base_point;
    p42 = rotation1(th3)*[1;0] + [1;0];
    p41 = rotation1(th2)*p42 + [1;0];
    p40 = rotation1(th1)*p41 + pt1;

    p31 = rotation1(th2)*[1;0] + [1;0];
    p30 = rotation1(th1)*p31 + pt1;

    p20 = rotation1(th1)*[1;0] + pt1;

    p50 = rotation1(th1)*rotation1(th4)*[0.5;0] + p20;

    p60 = rotation1(th1)*rotation1(th5)*[0.5;0] + p20;

    p70 = rotation1(th1)*rotation1(th2)*rotation1(th6)*[0.5; 0] + p30;

    p80 = rotation1(th1)*rotation1(th2)*rotation1(th7)*[0.5; 0] + p30;

    p_plot1 = [pt1 p20 p50 p20 p60 p20 p30 p80 p30 p70 p30 p40];
    plot(p_plot1(1,:), p_plot1(2,:), 'LineWidth', 2); axis([-6 6 -6 6]);
    axis square;
end

function R1 = rotation1(theta)
    R1 = [cos(theta) -sin(theta); sin(theta) cos(theta)];
end


