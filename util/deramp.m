function [data_deramp] = deramp(x,y,data,method)
%=================================================================
% function deramp(x,y,data,method)
%-----------------------------------------------------------------
% Fit a given function to the input data and remove.
%                                                                  
% INPUT:                                                           
%   x, y: coordinates
%   data: array or column vector of data
%   method: function used by "fit" to perform deramp
% OUTPUT:    
%   data_deramp: deramped data
%   
% Andrew Watson     01-04-2022
%                                                                  
%=================================================================

% change to double, otherwise fit throws a warning
data = double(data);
data_deramp = data;

% default to 1st order if method not given
if nargin == 3
    method = 'poly11';
end

% grid coords if needed
if numel(x) ~= numel(data)
    [xx,yy] = meshgrid(x,y);
else
    xx = x; yy = y;
end

% strip nans
xx(isnan(data)) = [];
yy(isnan(data)) = [];
data(isnan(data)) = [];

% fit polynomial surface
fitobject = fit([xx(:),yy(:)],data(:),method);

% evaluate and remove
[xx,yy] = meshgrid(x,y);
data_deramp = data_deramp - fitobject(xx,yy);

end
