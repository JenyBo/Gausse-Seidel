clear all
close all
clc

%Khai bao cac gia tri co ban
x = 1:20;
nx = length(x);
y = 1:20;
ny = length(y);

c = rand(nx,ny);
c(1,1)=1;
c(nx,ny)=0;
c
%Khai bao 2 gia tri dau cua t
c_old = c;

%Khai bao tolerance and epsilon
tolerance = 0.001;
epsilon = 1;
dem = 0;

%Bat dau vong lap de tinh toan 
while epsilon > tolerance
    for i = 1:nx
        for j = 1:ny
            if i == 1 && j == 1
                c(i,j) = 1;
            elseif i == nx && j == ny
                c(i,j) = 0;
            else
            if i == 1              % xac dinh c(i-1,j)(n+1) huong sang trai ( huong tay west )
                west = c(ny,j);
            else
                west = c(i-1,j);
            end
            if i == ny             % xac dinh c(i+1,j)(n) huong sang phai ( huong dong east )
                east = c_old(1,j);
            else
                east = c_old(i+1,j);
            end
            if j == 1              % xac dinh c(i,j-1)(n+1) huong len tren ( huong bac north )
                north = c(i,nx);
            else
                north = c(i,j-1);
            end
            if j == nx             % xac dinh c(i,j+1)(n) huong xuong duoi ( huong nam south )
                south = c_old(i,1);
            else
                south = c_old(i,j+1);
            end
            c(i,j) = 1/4*(west + east + north + south ) ;
            if abs(c_old(i,j) - c(j,j)) > tolerance 
                epsilon = abs(c_old(i,j) - c(i,j));
            end 
            end
        end
    end
    c_old = c;
    dem = dem + 1;
       
end

figure(1)
surf(c)
colorbar % tao thanh ben phai 
colormap default %set loai mau cho map la loai co ban
xlabel('X');
ylabel('Y');
zlabel('Z');
title({'Gauss Seidel method',['So lan lap = ',num2str(dem)]});

figure(2)
[c,h] = contourf(x,y,c);
clabel(c,h);
colorbar % tao thanh ben phai 
colormap default %set loai mau cho map la loai co ban

xlabel('Cot X');
ylabel('Cot Y');
title({'Gauss Seidel method',['So lan lap = ',num2str(dem)]});

c_old
