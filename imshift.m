function A = imshift(im, shiftRows, shiftCols)
%       Azzopardi G, Petkov N (2012) A CORF Computational Model of a Simple Cell that relies on LGN Input 
%           Outperforms the Gabor Function Model. Biological Cybernetics 1?13. doi: 10.1007/s00422-012-0486-6


A = zeros(size(im));

if shiftRows >= 0 && shiftCols >= 0
    A(1+shiftRows:end,1+shiftCols:end) = im(1:end-shiftRows,1:end-shiftCols);
elseif shiftRows >= 0 && shiftCols < 0
    A(1+shiftRows:end,1:end+shiftCols) = im(1:end-shiftRows,1-shiftCols:end);
elseif shiftRows < 0 && shiftCols >= 0
    A(1:end+shiftRows,1+shiftCols:end) = im(1-shiftRows:end,1:end-shiftCols);
else
    A(1:end+shiftRows,1:end+shiftCols) = im(1-shiftRows:end,1-shiftCols:end);
end