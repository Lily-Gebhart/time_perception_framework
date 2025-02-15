% FUNCTION: Function to resize image to be displayed based on screen size. 
function resized_image = resize_image(image, screen_size_y)
    [image_y, ~, ~] = size(image);
    y_image_screen_ratio = (6/10)*(screen_size_y/image_y);
    resized_image = imresize(image, y_image_screen_ratio);
end