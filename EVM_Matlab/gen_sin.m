   %% Time specifications:
   Fs = 25;                   % samples per second
   dt = 1/Fs;                   % seconds per sample
   StopTime = 1000;             % seconds
   t = (0:dt:StopTime-dt)';     % seconds
   sigma=1              %noise
 
   %% Sine wave:
   Fc = 90/60;                     % hertz
   %x = sin(2*pi*Fc*t);
   random_d= rand(size(t))-0.5;
   x = sin(2*pi*Fc*t);% +  sigma*random_d(t)  %add noise
   for iterator = 1:size(x)
       x(iterator)=x(iterator)+sigma*random_d(iterator);
   end
   % Plot the signal versus time:
   figure;
   plot(t,x);
   xlabel('time (in seconds)');
   title('Signal versus Time');
  % Stack=[(1:iterator)' t];