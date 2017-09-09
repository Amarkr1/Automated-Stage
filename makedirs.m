%   David Patel [david.patel@mail.mcgill.ca]
%--------------------------------------------------------------------------
% make directories to store various file formats
if ~exist([diename '\txt'], 'dir') % To be able to import data
    mkdir([diename '\txt']);
end
if ~exist([diename '\fig'], 'dir') % For future editing in MATLAB
    mkdir([diename '\fig']);
end
if ~exist([diename '\pdf'], 'dir') % For easy sharing
    mkdir([diename '\pdf']);
end
if ~exist([diename '\eps'], 'dir') % For LaTeX
    mkdir([diename '\eps']);
end
if ~exist([diename '\emf'], 'dir') % For MS word
    mkdir([diename '\emf']);
end
if ~exist([diename '\png'], 'dir') % For easy viewing
    mkdir([diename '\png']);
end
if ~exist([diename '\snp'], 'dir') % For easy viewing
    mkdir([diename '\snp']);
end
%--------------------------------------------------------------------------

