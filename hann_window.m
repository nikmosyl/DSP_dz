function [ wSignal ] = hann_window( signal )

N = length(signal);
iw = 1:1:length(signal);
wHann = (0.5 * (1 - cos(2*pi*iw/(N-1))));
wHann = wHann';

for i = 1:1:N   

    wSignal(i,:) = wHann(i,:)*signal(i,:);
end

end

