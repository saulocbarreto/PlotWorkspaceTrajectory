%Definition of each joint lenght
L1 = 40;
L2 = 45;
L3 = 35;
L4 = 40;

%Create robot model using Peter Corke Toolbox
%First Joint is fixed, therefore theta != 0
L(1) = Link ([pi/2 L1 0 0]); 

%Joint 2 is rotational, therefore, theta=0
L(2) = Link ([0 0 L2 0]);

%Joint 3 is fixed
L(3) = Link ([pi/6 L3 0 pi/4]);

%Joint 4 is prismatic
L(4) = Link ([0 L4 0 pi/2 1]);%The "1" parameter indicates that this is a prismatic joint

% The prismatic Joint can have from 40 to 60mm
L(4).qlim = [40 60];

%Build the robot
Rob = SerialLink(L);
Rob.name = 'Finger Robot';


%This is the initial state for the robot, note that for the prismatic
%joint, the value is equal to the lenght
q0 = ([pi/10 pi/6 pi/6 40]);

%This is the final state, so the trajectory can be plotted. 
qf = ([pi/8 pi/2 pi/4 60]);

%Simulate a time variable, generating a time vector
t = ([0:0.05:5]);
%Get the trajectory from q0 to qf 
q = jtraj(q0,qf,t);
%Then the homogeneous transform for each set of joint coordinates is given by
T = Rob.fkine(q);
%where T is a vector of SE3 objects.For example, the first point is T(1)
%the translational part of this can be extracted using the transl method
p = T.transl;
subplot(2,1,1);
%extract and plot X coordinate
plot(t,p(:,1));
xlabel('Time (s)');
ylabel('X (mm)');
subplot(2,1,2);
%extract and plot Z coordinate
plot(t, p(:,3));
xlabel('Time (s)');
ylabel('Z (mm)');

% The Y part is commented out for future work
%subplot(1,1,1)
%plot(p(:,1), p(:,3));

%Next lines of code will draw the robot at theta=0, this line can be used
%to verify how the theta will vary with a mechanical model of the robot

%The W is the limit for each axis
W = [-100, 150 -100 100 -10 200];

%Rob.plot([pi/10 pi/6 pi/6 40], 'workspace',W,'jointdiam', 0.1,'nobase','noname','wrist');


