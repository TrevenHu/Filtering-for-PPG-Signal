function [lst,stat] = listfiles(path,flt)
% --2009.06.10 Created--
% --2009.12.04 Modified--
% --Windows XP--
% --Matlab 7.7--
% --xialulee.spaces.live.com--
    if (nargin == 1)
        flt='*.*';
    end
    if (path(end) ~= '\')
        path=[path '\'];
    end
    command = sprintf('for /r "%s" %%v in (%s) do @echo %%v', path, flt);
    [stat,lst] = system(command);
    lst = strsplit(lst,'\n');
end