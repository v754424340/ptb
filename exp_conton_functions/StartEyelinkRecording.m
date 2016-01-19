function [t]=StartEyelinkRecording(thetrial,init,fileX,thescenepath,thepart,parti,t_fix,time)%change this if we only record during testing TBD

Eyelink('Message', 'TRIALID: %04d, CONDIT: %04d, FIXX: %04d, FIXY %04d', thetrial, fileX.p2.(thepart{parti})(thetrial,3:4), init.mx, init.my);
% an integration message so that an image can be loaded as
% overlay background when performing Data Viewer analysis.
WaitSecs(0.01);
Eyelink('Message', '!V IMGLOAD CENTER %s %d %d', thescenepath{thetrial}, init.mx, init.my);

% This supplies the title at the bottom of the eyetracker display
Eyelink('Command', 'record_status_message "Stim: %02d"', thetrial);

%Put the tracker offline and draw the stimuli.
Eyelink('Command', 'set_idle_mode');
WaitSecs(0.01);

%clear tracker display and draw box at center
Eyelink('Command', 'clear_screen %d', 0);

%draw the image on the screen
Eyelink('ImageTransfer',thescenepath{thetrial},init.mx, init.my, [], [], init.mx, init.my);    

%start recording following mode transition and a short pause.
Eyelink('Command', 'set_idle_mode');
WaitSecs(0.01);
WaitSecs('UntilTime',t_fix+time.p2.fix-0.1);
Eyelink('StartRecording');
t = GetSecs;