function image = rescaleImage(image, mn, mx)
%       Azzopardi G, Petkov N (2012) A CORF Computational Model of a Simple Cell that relies on LGN Input 
%           Outperforms the Gabor Function Model. Biological Cybernetics 1?13. doi: 10.1007/s00422-012-0486-6


if ~isempty(image)
    maximum = max(image(:));
    minimum = min(image(:));
    if maximum - minimum == 0
        image = ones(size(image)) * mx;
    else
        image   = (((image-minimum)/(maximum-minimum) * (mx - mn)) + mn);
    end
end