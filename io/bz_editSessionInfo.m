function [ sessionInfo_new ] = bz_editSessionInfo(basePath)
%Creates and edits a sessionInfo.mat file.
%
%INPUT
%   (optional) basePath or sessionInfo.mat or basePath.xml filename 
%
%This template was constructed using StructDlg.m - see Structdlg_examples.m
%for examples of how to add/edit sessionInfo fields
%
%DLevenstein 2017
%% This is the template sessionInfo file, with defaults etc. for StructDlg

sessionInfo_template.session.path = {''};
sessionInfo_template.session.name = {''};

%Filename of the sessionInfofile, with option to load previous
sessionInfo_template.xmlfilename = { {'uigetfile(''/basePath/*.xml'')'} };
sessionInfo_template.fromfile   = { {'{0}','1'} 'Load From xml? Check this box and hit OK' };   

%THESE ARE THE MODULES YOU HAVE TO CHOOSE FROM (add using the template)
sessionInfo_template.ExtracellEphys = { {'{0}','1'} 'Extracellular Ephys?' };
sessionInfo_template.Imaging = { {'{0}','1'} 'Imaging?' };
sessionInfo_template.Behavior = { {'{0}','1'} 'Behavior?' };
%sessionInfo_template.NEWMODULENAME = { {'{0}','1'} 'NEWMODULENAME?' };


%% Now Run the sessionInfo editor with StructDlg
if ~exist('basePath','var')
    %For starting anew (no filename given)
    sessionInfo_new = StructDlg(sessionInfo_template,'sessionInfo');
else
    sessionInfo_new.fromfile=1;
    sessionInfo_new.xmlfilename = basePath;
end
%% 

%This loops through a series of conditions (load previous, add modules)
%Each time allowing the user to edit structure contents
while sessionInfo_new.fromfile ...
        || isfield(sessionInfo_template,'ExtracellEphys') ...
        || isfield(sessionInfo_template,'Imaging') ...
        || isfield(sessionInfo_template,'Behavior')
      %%|| isfield(sessionInfo_template,'NEWMODULENAME')
    
%%THIS IS WHERE YOU CAN ADD NEW MODULES%%
    %%THIS IS AN EXAMPLE NEW MODULE. 
    %%Make sure to add a condition to the while loop above
    %if sessionInfo_new.NEWMODULENAME
    %    sessionInfo_template.METADATAFIELDNAME = { default, 'Prompt:', [min max]}
    %
    %    sessionInfo_template = rmfield(sessionInfo_template,'NEWMODULENAME');
    %end
    
       
    %MODULE: EPHYS
    if sessionInfo_new.ExtracellEphys
        
        sessionInfo_template.session.system = {{'intan','ampliplex','add new... (not yet functional)'}};
        
        sessionInfo_template.spikeGroups.nGroups = { 0 '# SpikeGroups' [0 Inf] };
        sessionInfo_template.spikeGroups.nSamples = { 0 '# Samples' [0 Inf] } ;
        %sessionInfo_template.spikeGroups.groups = {'cell array of [spikegroupchannels]'};

        sessionInfo_template.nChannels = { 128 '# Channels' [0 Inf] };
        sessionInfo_template.nBits = { 16,'# Bits',[0 Inf]};

        sessionInfo_template.rates.lfp = { 1250 '.lfp SampleRate' [0 Inf] };
        sessionInfo_template.rates.wideband = { 20000 '.dat SampleRate' [0 Inf] };
        sessionInfo_template.rates.video ={ 0 'Video SampleRate' [0 Inf] };

        sessionInfo_template.FileName = {''};

        sessionInfo_template.SampleTime ={ 50 'Sample Time' [0 Inf] } ;

        sessionInfo_template.nElectricGrps = { 1 '# Electric Groups' [0 Inf] } ;
        % 
        sessionInfo_template.HiPassFreq = { 500 'High Pass Frequency' [0 Inf] } ;
        sessionInfo_template.Date = { '' 'Date' };
        sessionInfo_template.VoltageRange ={ 20 'Voltage Range' [0 Inf] } ;
        sessionInfo_template.Amplification ={ 1000 'Amplification' [0 Inf] } ; 
        sessionInfo_template.Offset = { 0 'Offset' [0 Inf] } ;
        sessionInfo_template.lfpSampleRate = { 1250 'lfpSampleRate' [0 Inf] } ;

        % sessionInfo_template.AnatGrps = [1x7 struct]
        % sessionInfo_template.SpkGrps = [1x7 struct]
        % sessionInfo_template.channels = [1x128 double]
        % sessionInfo_template.lfpChans = [23 2 53 63 42 61 118 69]
        % sessionInfo_template.thetaChans = [2 118]
        % sessionInfo_template.region = {1x128 cell}

        sessionInfo_template.badchannels = { [] 'Bad LFP Channels' [0 Inf] };
        sessionInfo_template.badshanks = { [] 'Bad Shanks' [0 Inf] };
        sessionInfo_template.badcells = { [] 'Bad Cells' [0 Inf] };
        
        %rmfield(sessionInfo_new,'ExtracellEphys');
        sessionInfo_template = rmfield(sessionInfo_template,'ExtracellEphys');
    end

    
 
    
%%This is loading previous stuff%%
 
    %If Loading from xml, need to put xml data into sessionInfo fields
    if strcmp(sessionInfo_new.xmlfilename(end-3:end),'.xml') && exist(sessionInfo_new.xmlfilename,'file')
        display('loading from xml...')
        xmlparms = LoadParameters(sessionInfo_new.xmlfilename);
        
        %Here is where xml parms will be put into sessionInfo structure
        
        
    %If loading from old sessionInfo.mat file    
    elseif strcmp(sessionInfo_new.xmlfilename(end-3:end),'.mat')
        display('loading from old sessionInfo.mat...')
        [sessionInfo_loaded] = bz_getSessionInfo(sessionInfo_new.xmlfilename);
        %Need something here to check if there are any fields in
        %sessionInfo_loaded that aren't in sessionInfo_template
        sessionInfo_new = sessionInfo_loaded;
        sessionInfo_new.fromxml = 0;
        %Rerun the sessionInfo editor with the old file's stuff
        %Question: What happens if the sessionInfo file is a preious
        %version with different fields?
        sessionInfo_new = StructDlg(sessionInfo_template,'sessionInfo',sessionInfo_new);
        
        
    %If only a basename was given
    elseif exist('basePath','var')
        baseName = bz_BasenameFromBasepath(basePath);
        sessionInfo_new.xmlfilename = fullfile(sessionInfo_new.xmlfilename,[baseName,'.xml']);
        sessionInfo_new.session.baseName = baseName;
        sessionInfo_new = StructDlg(sessionInfo_template,'sessionInfo',sessionInfo_new);
    
    %If nothing was given
    else
        sessionInfo_new = StructDlg(sessionInfo_template,'sessionInfo');
    end
    
    

end


%% Convert regiongroups to labels for each channel


%% Save the sessionInfo.mat file in its right place, eh?



end