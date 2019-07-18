function MyMatlab1(InFile1, InFile2, InFile3, InFile4, ...
                          TimeLimitInSeconds, ScoringMethod, NetworkModel)
%MYMATLAB1 Version1 Script. This script generates solution1.txt
%
% Input Arguments:
% TimeLimitInSeconds and ScoringMethod are not used yet, the algorithm acts
% as it would for ScoringMethod = 0.
% InFile1: CON file
% InFile2: INL file
% InFile3: RAW file
% InFile4: ROP file


fprintf('Started\n')
%parpool('local',2);
parpool('GOC_SlurmProfile1',20);
[mpc,contingencies] = convert2mpc(InFile3,InFile4,...
                                                   InFile2,InFile1);
[mpcOPF, pfs, mpcOPF_or] = solveSCOPF(mpc,contingencies,true,...
TimeLimitInSeconds, ScoringMethod, tic);
save('mpc.mat','mpcOPF','mpcOPF_or');
create_solution1(fixGen2Normal(gen2shunts(mpcOPF)));
end
