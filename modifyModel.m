function model = modifyModel(model,varargin)
%       Azzopardi G, Petkov N (2012) A CORF Computational Model of a Simple Cell that relies on LGN Input 
%           Outperforms the Gabor Function Model. Biological Cybernetics 1?13. doi: 10.1007/s00422-012-0486-6


vargs = varargin;
nargs = numel(vargs);
names = varargin(1:2:nargs);
values = varargin(2:2:nargs);

for i = 1:numel(names)
    if strcmp(names(i),'invertpolarity')
        % invert polarity
        if values{i} == 1    
            model(1,:) = 1-model(1,:);
        end
    elseif strcmp(names(i),'thetaoffset')
        % add angular offset
        model(4,:) = mod(model(4,:) + values{i},2*pi);
    elseif strcmp(names(i),'overlappixels')
        % overlap index
        rho = model(3,:);
        phi = model(4,:);
        [x, y] = pol2cart(phi,rho);
        negx = x < 0;        
        x(negx) = x(negx) - values{i};
        x(~negx) = x(~negx) + values{i};
        [phi, model(3,:)] = cart2pol(x,y);
        model(4,:) = mod(phi+2*pi,2*pi);
    end
end