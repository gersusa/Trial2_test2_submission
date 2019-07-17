function MyMatlab2(InFile1, InFile2, InFile3, InFile4, ...
                        TimeLimitInSeconds, ScoringMethod, NetworkModel)
%MYMATLAB2 Version1 Script. This script generates solution2.txt
%
% Input Arguments:
% TimeLimitInSeconds and ScoringMethod are not used yet, the algorithm acts
% as it would for ScoringMethod = 0.
% InFile1: CON file
% InFile2: INL file
% InFile3: RAW file
% InFile4: ROP file


[mpc,contingencies] = convert2mpc(InFile3,InFile4,...
                                                   InFile2,InFile1);
load('mpc.mat');
[result,pfs] = runAllCONS(mpcOPF, contingencies,mpcOPF_or, 'AC');
if ~isempty(pfs)
    for i=1:length(pfs)
        pfs(i) = fixGen2Normal(gen2shunts(int2ext(pfs(i))));
    end
end
create_solution2(pfs,contingencies,mpcOPF);
end