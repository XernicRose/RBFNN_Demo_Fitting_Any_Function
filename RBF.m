clear;
clc;
T = 0.01; stoptime = 10; k = 1; k_up=1;

alfa = 0.5; nta = 2.15;

max_p = 8; min_p = -8; num_p = 42; ini_b = 67; ini_w = 0.35;

c = [min_p:(max_p - min_p)/(num_p-1):max_p]; c1 = [min_p:(max_p - min_p)/(num_p-1):max_p]; c2 = [min_p:(max_p - min_p)/(num_p-1):max_p];
b = ini_b * ones(1,num_p); b1 = ini_b * ones(1,num_p); b2 = ini_b * ones(1,num_p);
w = ini_w * rand(1,num_p); w1 = w; w2 = w;

yd = zeros(1,stoptime/T+1);
y = zeros(1,stoptime/T+1);
e = zeros(1,stoptime/T+1);
sample = [0:T:stoptime];

axis equal;

for t=0:T:stoptime
    %yd(k) = cos(pi*t)+0.1*t-2*cos(t);
    %yd(k) = sin(pi*t)-2*cos(t)+1.6*sin(t*2*pi)+log(t+1);
    yd(k) = 4*sin(pi*t)-2*cos(t)+1.6*sin(t*2*pi)+log(t+1);
    if k==1
        y(k)=1.5;
        h=1.2;
    else
        h = exp(-((norm(y(k-1) - c)^2)./(2*(b.^2))));
        y(k)= w * h';
    end
    e(k) = yd(k)-y(k);
 
    w2 = b1; w1 = w;
    dw = T * nta * e(k) * h;
    w = w1 + dw;

%         db = nta * e(k) * w .* h .* norm(t - c)^2 .* (b.^(-3));
%         b = b1 + db + alfa*(b1 - b2);
%         dc = nta * e(k) * w .* h .* ((t - c) .* (b.^-2));
%         c = c1 + dc + alfa*(c1 - c2);
%     if mod(t,0.002) == 0
%         dw = T * nta * e(k) * h;
%         w = w1 + dw;
%     end
    
    k=k+1;

end

subplot(2,1,1);
plot(sample, y);hold on;grid on;plot(sample, yd);hold on;grid on;

subplot(2,1,2);
plot(sample, e);hold on;grid on;