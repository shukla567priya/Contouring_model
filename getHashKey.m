function hashkey = getHashKey(vector)
% %      Azzopardi G, Petkov N (2012) A CORF Computational Model of a Simple Cell that relies on LGN Input 
%           Outperforms the Gabor Function Model. Biological Cybernetics 1?13. doi: 10.1007/s00422-012-0486-6



primelist = [2 3 5 7 11 13];
n = numel(vector);

% based on prime factorization
hashkey = prod(primelist(1:n).^vector);
