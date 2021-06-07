%Defining Values from DH-Table
alpha1 = 0;
alpha2 = 0;
alpha3 = pi/4;
alpha4 = pi/2;


a1 = 0;
a2 = 45;
a3 = 0;
a4 = 0;

%Only the Link 4 is prismatic, to its size can change
syms d4;
d1 = 40;
d2 = 0;
d3 = 35;

theta1 = pi/2;

T10 = [cos(theta1) -sin(theta1)*cos(alpha1) sin(theta1)*sin(alpha1) a1*cos(theta1);
    sin(theta1) cos(theta1)*cos(alpha1) -cos(theta1)*sin(alpha1) a1*sin(theta1);
    0 sin(alpha1) cos(alpha1) d1;
    0 0 0 1]

syms theta2;
T21 = [cos(theta2) -sin(theta2)*cos(alpha2) sin(theta2)*sin(alpha2) a2*cos(theta2);
    sin(theta2) cos(theta2)*cos(alpha2) -cos(theta2)*sin(alpha2) a2*sin(theta2);
    0 sin(alpha2) cos(alpha2) d2;
    0 0 0 1]


theta3 = pi/6;
T32 = [cos(theta3) -sin(theta3)*cos(alpha3) sin(theta3)*sin(alpha3) a3*cos(theta3);
    sin(theta3) cos(theta3)*cos(alpha3) -cos(theta3)*sin(alpha3) a3*sin(theta3);
    0 sin(alpha3) cos(alpha3) d3;
    0 0 0 1]

%The Matrix for a prismatic joint has a different 4th column comparing to a
%revolutionary joint
theta4 = 0;
T43 = [cos(theta4) -sin(theta4)*cos(alpha4) sin(theta4)*sin(alpha4) 0;
    sin(theta4) cos(theta4)*cos(alpha4) -cos(theta4)*sin(alpha4) 0;
    0 sin(alpha4) cos(alpha4) d4;
    0 0 0 1]


%By mutiplying the matrices and extracting the last column we obtain the
%position of the end effector.
T40 = T10 * T21 * T32 * T43;

reference = [0; 0 ;0; 1];

position = T40 * reference;

x = position(1);
y = position(2);
z = position(3);


% Angle restrictions for rotational joint
% q2 from -90deg to +90deg and divide into 90 units
theta2=linspace(-pi/2,pi/2,90);
% Length restriction for prismatic joint
d4 = linspace(40,60,90);
%implementing the output from DH convention
[D4,Q2]=ndgrid(d4,theta2);

%IMPORTANT: From this point a work around was necessary in order to plot the workspace, to define the
%values for X, Y and Z, the values of x, y and z previously calculated in lines 56-58 were used: X was obtained
%by replacing all the occurences of d4 by D4 and theta2 by Q2 in "x" with the help
%of a text editor (Replace and Find tool). The same was made for Y/y and
%Z/z.

X = (223549092000967995*cos(Q2))/81129638414606681695789005144064 - 45*sin(Q2) + D4*((2^(1/2)*((4967757600021511*cos(Q2))/81129638414606681695789005144064 - sin(Q2)))/4 + (2^(1/2)*3^(1/2)*(cos(Q2) + (4967757600021511*sin(Q2))/81129638414606681695789005144064))/4) ;
Y = 45*cos(Q2) + (223549092000967995*sin(Q2))/81129638414606681695789005144064 + D4*((2^(1/2)*(cos(Q2) + (4967757600021511*sin(Q2))/81129638414606681695789005144064))/4 - (2^(1/2)*3^(1/2)*((4967757600021511*cos(Q2))/81129638414606681695789005144064 - sin(Q2)))/4) 
Z=(2^(1/2)*D4)/2 + 75;

plot3(Z(:),X(:),Y(:),[],[],[]);
set(gca, 'ZTick', []);
