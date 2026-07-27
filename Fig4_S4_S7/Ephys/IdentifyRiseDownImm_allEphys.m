function IdentifyRiseDownImm_allEphys(tablepath, path)
%IdentifyRiseDownImm_allWholePop('Z:\Kori\immobile_code\RiseDown\tables\Path4sUnR\',
%path4sUnR100,  path4sUnRList, 1)


    for cond = 4;
        if cond == 1
         CondStr = 'Cue';
        elseif cond == 2
            CondStr = 'LastLick';
        elseif cond == 3
          CondStr = 'Rew';
          elseif cond == 4
          CondStr = 'Lick';
        end  
  
        old_table_path{1} = tablepath;
      old_table_path{2}  = ['RiseDownID_' CondStr 'thres2.mat'];
         % old_table_path{2}  = ['RiseDownID_' CondStr '2.mat'];

    RiseDownTable = [];
  RiseDownTableEven = [];
  RiseDownTableGood = [];

 RiseDownTableBad = [];
 
    
    for i = 1:size(path,1)
       file_path_i = path(i,:);
       sess = path(i,52:67) 
       table_path_i = [old_table_path{1} sess '_' old_table_path{2}];
       
 
     
%            if exist(table_path_i, 'file')              
%                 t = load(table_path_i, 'RiseDownTableGood', 'RiseDownTableBad');
%                 RiseDownTableGood_i = t.RiseDownTableGood;
%              RiseDownTableBad_i = t.RiseDownTableBad;
% %                RiseDownTableUnRew_i = t.RiseDownTableUnRew;
%            end

            if exist(table_path_i, 'file')              
                t = load(table_path_i, 'RiseDownTable');
                RiseDownTable_i = t.RiseDownTable;
                % RiseDownTableEven_i = t.RiseDownTableEven;

           end

        % RiseDownTableGood = [RiseDownTableGood ; RiseDownTableGood_i(:,1:5)];
        % RiseDownTableBad = [RiseDownTableBad ; RiseDownTableBad_i(:,1:5)];
        % 
        RiseDownTable = [RiseDownTable ; RiseDownTable_i(:,1:5)];
         % RiseDownTableEven = [RiseDownTableEven ; RiseDownTableEven_i(:,1:5)];
%       RiseDownTableUnRew = [RiseDownTableUnRew  ; RiseDownTableUnRew_i(:,1:6)];
       clear RiseDownTable_i RiseDownTableEven_i RiseDownTableGood_i RiseDownTableBad_i
    end
    
   
        save_path = tablepath
        save_path = [save_path 'All_Recs_RiseDownID_Align' CondStr '.mat'];

   save(save_path, 'RiseDownTable', 'RiseDownTableEven');
  % save(save_path, 'RiseDownTableGood', 'RiseDownTableBad');
%    save(save_path, 'RiseDownTable');

end
end
