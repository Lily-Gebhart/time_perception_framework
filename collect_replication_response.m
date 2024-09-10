% Function to collect response for different experiment types. 

function time = collect_replication_response(replication_type)
    keylist=zeros(1, 256);
    keylist([41,44])=1; % FIXME: need to find a universal way to indicate space key
    KbQueueCreate(-3, keylist);
    KbQueueStart(-3);
    [~, ~, ~, ~, ~] = KbQueueCheck(-3); 
    
    if replication_type == "hold"
        while first_press == 0
            [~, first_press, ~, ~, last_release] = KbQueueCheck(-3); 
        end
        start_time = first_press(first_press > 0); % Gets the first keypress                                                                                           
        if KbName(first_press) == "ESCAPE"  % Escapes if the participant wants to finish the experiment.
            time = -1;                                                                                                   
            return
        end
        while last_release == 0 % Gets release of key
            [~, ~, ~, ~, last_release] = KbQueueCheck(-3); 
        end     
        stop_time = last_release(last_release > 0);
    
    elseif replication_type == "start_stop"
        while first_press == 0
            [~, first_press, ~, ~, ~] = KbQueueCheck(-3);
        end
        if KbName(first_press) == "ESCAPE"  % Escapes if the participant wants to finish the experiment.
            time = -1;                                                                                                   
            return
        end
        start_time = first_press(first_press > 0);
        KbQueueCreate(-3, keylist);
        KbQueueStart(-3);
        [~, ~, ~, last_press, ~] = KbQueueCheck(-3);
        while last_press == 0
            [~, ~, ~, last_press, ~] = KbQueueCheck(-3);
        end
        stop_time = last_press(last_press > 0);
    
    elseif replication_type == "stop"
        [start_time, ~, ~, ~] = GetSecs();
        while first_press == 0
            [~, first_press, ~, ~, ~] = KbQueueCheck(-3);
        end
        if KbName(first_press) == "ESCAPE"  % Escapes if the participant wants to finish the experiment.
            time = -1;                                                                                                   
            return
        end
        stop_time = first_press(first_press > 0);
    end 

    time = stop_time - start_time; % Response time is end of hold minus beginning of hold. 
end