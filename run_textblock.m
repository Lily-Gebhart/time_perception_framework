function success = run_textblock(statements)
% Runs the experiment intro, identical but customizable for each
% experiment! 

for i = statements
    success = display_screen_text(statements(i), ...
            window, ...
            background_color, ... % Uses universal variable
            black, ...
            screenXpixels);
    if success == false
        return
    end
end
end 