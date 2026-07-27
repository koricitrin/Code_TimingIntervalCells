function IdentifyLickOn100tr(path, savepath)

    


    save_path = savepath;
      time = 4000;
   for i = 1:size(path,1)
       % % save_path = path(i,:);
       % filename = [path{i}(1,43:58) '_DataStructure_mazeSection1_TrialType1']
       %  path_i = [path{i,:} filename];
       %  cd(path{i,:})
       filename = [path(i,43:58) '_DataStructure_mazeSection1_TrialType1']
        path_i = [path(i,:) filename];
        cd(path(i,:))

     
       
        for cond = 3:4;
            
        if cond == 1
         CondStr = 'Cue';
        elseif cond == 3
            CondStr = 'LastLick';
        elseif cond == 2
          CondStr = 'Rew';
          elseif cond == 4
          CondStr = 'Lick';
        end  
   

            % 
            fsa_path = [path_i '_convSpikesAlignedBefLastLick_msess1.mat'];
  
            load(fsa_path,'dFFArray','paramC');
             FSA_LL = dFFArray;

               fsa_path = [path_i '_convSpikesAlignedBefLick_msess1.mat'];
  
            load(fsa_path,'dFFArray','paramC');
             FSA_Lick = dFFArray;

            timeStepRun = paramC.timeSteps(1:time);
    
    info_path = ([path_i '_Info.mat']);
    load(info_path, 'beh');

 
    p = 95; % overwrite GlobalConstFq to just use p value of 95
    rec_name = [];
    neu_id = [];
    ratio0to1BefRun = [];
    isRise = [];
    isDown = [];

    % 
    %   %%% changed on 2/20/2025  
    indFR0to1 = timeStepRun >= 0 & timeStepRun < 0.5;
    indFRBefRun = timeStepRun >= -0.5 & timeStepRun < 0; % different from cue!!

   
    indTime = time;
    Neurons = 1:length(FSA_LL);
    Trials =    1:size(FSA_LL{1},1);    
    TrialsHun = round(length(Trials)/100)
    Hundred = 100;
    
    for hun = 1:TrialsHun 
        isLickOn = [];
                  
                    if hun == 1 
                    TrialsSel = 1:Hundred;

                    elseif hun == TrialsHun
                       TrialsSel = Hundred*hun-1:length(Trials)
                    else
                       
                   TrialsSel = Hundred*(hun-1):Hundred*hun;
           
                    end

                    SaveStr = ['H' num2str(hun)];
              
            for j = 1:length(Neurons)
                k = Neurons(j);
                fsa_j = FSA_LL{k}(TrialsSel,:);
                mean_fsa_temp = mean(fsa_j,1);
                
                %normalize to get rid of neg dFF values
                mean_fsa_j =  (mean_fsa_temp - min(mean_fsa_temp))/(max(mean_fsa_temp) - min(mean_fsa_temp));     
                ratio0to1BefRun_LL = mean(mean_fsa_j(indFR0to1))/mean(mean_fsa_j(indFRBefRun));      
                rec_name = [rec_name ; string(filename(1,1:16))];
                neu_id = [neu_id ; k];
              
                 RiseThres = 3/2;
                DownThres = 2/3; 
               if ratio0to1BefRun_LL > DownThres; %%if it is not down to LL continue
                  continue

               else ratio0to1BefRun_LL < DownThres; %%if it is down to LL check if up first lick
                   
                fsa_j = FSA_Lick{k}(TrialsSel,:);
                mean_fsa_temp = mean(fsa_j,1);
                %normalize to get rid of neg dFF values
                mean_fsa_j =  (mean_fsa_temp - min(mean_fsa_temp))/(max(mean_fsa_temp) - min(mean_fsa_temp));     
                ratio0to1BefRun_Lick = mean(mean_fsa_j(indFR0to1))/mean(mean_fsa_j(indFRBefRun));    
                
                if ratio0to1BefRun_Lick  > RiseThres;
               
                 isLickOn = [isLickOn, k];
                else 
                    continue
                end

               end

           
               
            end
            
            NumLickOn = length(isLickOn);
            PropLickOn =  NumLickOn/length(Neurons);
          
            cd(save_path)
            save_path1 = [filename(1,1:16) 'LickOn'  SaveStr '.mat'];
            save(save_path1, 'isLickOn', 'NumLickOn', 'PropLickOn');
    end

clear  Neurons dFFArray FSA_LL FSA_Lick
        end
   end    
end