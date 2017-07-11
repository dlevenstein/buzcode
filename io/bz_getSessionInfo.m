function [sessionInfo] = bz_getSessionInfo(basePath)
%
%INPUT
%   (optional) basePath  -or- baseName.xml -or- baseName.sessionInfo.mat
%
%
%%

if ~exist('basePath','var')
    basePath = pwd;
end

% If Filename to .xml or .sessionInfo.mat file was given
if strcmp(basePath(end-3:end),'.xml')
    sessionInfo = LoadParameters(basePath);
    return
elseif strcmp(basePath(end-15:end),'.sessionInfo.mat')
    load(basePath); 
    return
end

%If basePath directory was given
d = dir('*sessionInfo*');
if ~isempty(d) & length(d) == 1
   load(d.name); 
else
   warning('could not find sessionInfo file, running LoadParameters instead..') 
   sessionInfo = LoadParameters(basePath);
end