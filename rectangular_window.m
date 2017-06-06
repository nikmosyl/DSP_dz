function [ wSignal ] = rectangular_window( signal )

  N = length(signal);
iw = 1:1:length(signal);
wRectangular = 1+iw*0;
wRectangular = wRectangular';

for i = 1:1:N   

    wSignal(i,:) = wRectangular(i,:)*signal(i,:);

end

end

