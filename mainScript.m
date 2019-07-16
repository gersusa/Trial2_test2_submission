disp(datestr(now))
%% Get all scenario dirs

allList = dir();
dirFlags = [allList.isdir];
scDirs = allList(dirFlags);

%% Define files and run SCOPF

InFile2 = 'case.inl';
InFile4 = 'case.rop';

for scen=3:3%length(scDirs)
    dirName = scDirs(scen).name;
    % Skip . and ..
    if strcmpi(dirName,'.') || strcmpi(dirName,'..')
        continue
    end
    
    InFile1 = fullfile(dirName,'case.con');
    InFile3 = fullfile(dirName,'case.raw');
    
    [mpc,contingencies] = convert2mpc(InFile3,InFile4,...
        InFile2,InFile1);
    mpc = extend_opf(mpc);
    
    fprintf('------------------------------')
	fprintf([dirName '\n'])

	[mpcOPF, pfs, mpcOPF_or, result] = solveSCOPF_d2(mpc,contingencies,true);
    
% % % % % %     cd(dirName)
% % % % % %     create_solution1(mpcOPF,1)
% % % % % %     create_solution2(pfs,contingencies,1)
% % % % % %     cd ..

end
disp(datestr(now))