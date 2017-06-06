function [ wSignal ] = hemming_window( signal )

    N = length(signal);
iw = 1:1:length(signal);
wHemming = 0.5383-0.4616*(cos(2*pi*iw/(N-1)));
wHemming = wHemming';

for i = 1:1:N   

    wSignal(i,:) = wHemming(i,:)*signal(i,:);

end

end

