%% Make bar graph inc and dec neurons

    tablepath1 = ['Z:\Kori\immobile_code\RiseDown\tables\2025-05to05\Variable\Path4sData\'];
    cd(tablepath1) 

load('All_Recs_RiseDownID_AlignCuethres.mat')
TableCue = RiseDownTable;
load('All_Recs_RiseDownID_AlignRewthres.mat')
TableRew = RiseDownTable;

load('All_Recs_RiseDownID_AlignLastLickthres.mat')
TableLL = RiseDownTable;
load('All_Recs_RiseDownID_AlignLickthres.mat')
TableLick = RiseDownTable;

TableLick = renamevars(TableLick,"isRise","RiseLick");
TableCue = renamevars(TableCue,"isRise","RiseCue");
TableLL = renamevars(TableLL,"isRise","RiseLL");
TableRew = renamevars(TableRew,"isRise","RiseRew");

TableLick = renamevars(TableLick,"isDown","DownLick");
TableCue = renamevars(TableCue,"isDown","DownCue");
TableLL = renamevars(TableLL,"isDown","DownLL");
TableRew = renamevars(TableRew,"isDown","DownRew");


RiseDownTableAllCond = [TableLick(:,1), TableLick(:,2), TableLick(:,4), TableCue(:,4), TableLL(:,4), TableRew(:,4), TableLick(:,5), TableCue(:,5), TableLL(:,5),  TableRew(:,5)];

    RecNo = size(unique(RiseDownTableAllCond.rec_name),1);
    for k =1:RecNo
    Recs = unique(RiseDownTableAllCond.rec_name);
    sess= Recs(k);
    totalNeur = sum(strcmp(RiseDownTableAllCond.rec_name, sess))
     RiseCueInd = (RiseDownTableAllCond.RiseCue == 1);
    RiseCueNeuronID =  RiseDownTableAllCond(RiseCueInd,1:2);
    RiseCue_Sess = sum(strcmp(RiseCueNeuronID.rec_name, sess));
    RiseCue_Sess_Prop(k,:) = RiseCue_Sess/totalNeur;
    
    end
    
    CuePropInc = RiseCue_Sess_Prop;
    
    for k =1:RecNo
    Recs = unique(RiseDownTableAllCond.rec_name);
    sess= Recs(k);
    totalNeur = sum(strcmp(RiseDownTableAllCond.rec_name, sess))
    DownCueInd = (RiseDownTableAllCond.DownCue == 1);
    DownCueNeuronID =  RiseDownTableAllCond(DownCueInd,1:2);
    DownCue_Sess = sum(strcmp(DownCueNeuronID.rec_name, sess));
    DownCue_Sess_Prop(k,:) = DownCue_Sess/totalNeur;
    
    end
    
    CuePropDec = DownCue_Sess_Prop;
%%
    RecNo = size(unique(RiseDownTableAllCond.rec_name),1);
    for k =1:RecNo
    Recs = unique(RiseDownTableAllCond.rec_name);
    sess= Recs(k);
    totalNeur = sum(strcmp(RiseDownTableAllCond.rec_name, sess))
     RiseLLInd = (RiseDownTableAllCond.RiseLL == 1);
    RiseLLNeuronID =  RiseDownTableAllCond(RiseLLInd,1:2);
    RiseLL_Sess = sum(strcmp(RiseLLNeuronID.rec_name, sess));
    RiseLL_Sess_Prop(k,:) = RiseLL_Sess/totalNeur;
    
    end
    
    LLPropInc = RiseLL_Sess_Prop;
    
    for k =1:RecNo
    Recs = unique(RiseDownTableAllCond.rec_name);
    sess= Recs(k);
    totalNeur = sum(strcmp(RiseDownTableAllCond.rec_name, sess))
    DownLLInd = (RiseDownTableAllCond.DownLL == 1);
    DownLLNeuronID =  RiseDownTableAllCond(DownLLInd,1:2);
    DownLL_Sess = sum(strcmp(DownLLNeuronID.rec_name, sess));
    DownLL_Sess_Prop(k,:) = DownLL_Sess/totalNeur;
    
    end
    
    LLPropDec = DownLL_Sess_Prop;

    %%

    RecNo = size(unique(RiseDownTableAllCond.rec_name),1);
    for k =1:RecNo
    Recs = unique(RiseDownTableAllCond.rec_name);
    sess= Recs(k);
    totalNeur = sum(strcmp(RiseDownTableAllCond.rec_name, sess))
     RiseRewInd = (RiseDownTableAllCond.RiseRew == 1);
    RiseRewNeuronID =  RiseDownTableAllCond(RiseRewInd,1:2);
    RiseRew_Sess = sum(strcmp(RiseRewNeuronID.rec_name, sess));
    RiseRew_Sess_Prop(k,:) = RiseRew_Sess/totalNeur;
    
    end
    RewPropInc = RiseRew_Sess_Prop;
    
    for k =1:RecNo
    Recs = unique(RiseDownTableAllCond.rec_name);
    sess= Recs(k);
    totalNeur = sum(strcmp(RiseDownTableAllCond.rec_name, sess))
    DownRewInd = (RiseDownTableAllCond.DownRew == 1);
    DownRewNeuronID =  RiseDownTableAllCond(DownRewInd,1:2);
    DownRew_Sess = sum(strcmp(DownRewNeuronID.rec_name, sess));
    DownRew_Sess_Prop(k,:) = DownRew_Sess/totalNeur;
    
    end
    
   RewPropDec = DownRew_Sess_Prop;

%%need to plot


    std_data = std(CuePropInc, 0,1,'omitnan');
 std_data_1 = std_data/ sqrt(15);
 DataCueInc = [mean(CuePropInc), std_data_1]*100

     std_data = std(LLPropInc, 0,1,'omitnan');
 std_data_1 = std_data/ sqrt(15);
 DataLLInc = [mean(LLPropInc), std_data_1]*100

 std_data = std(RewPropInc, 0,1,'omitnan');
 std_data_1 = std_data/ sqrt(15);
 DataRewInc = [mean(RewPropInc), std_data_1]*100


    std_data = std(CuePropDec, 0,1,'omitnan');
 std_data_1 = std_data/ sqrt(15);
 DataCueDec = [mean(CuePropDec), std_data_1]*100

     std_data = std(LLPropDec, 0,1,'omitnan');
 std_data_1 = std_data/ sqrt(15);
 DataLLDec = [mean(LLPropDec), std_data_1]*100

 std_data = std(RewPropDec, 0,1,'omitnan');
 std_data_1 = std_data/ sqrt(15);
 DataRewDec = [mean(RewPropDec), std_data_1]*100


 
 a = 0.92;
 b = 1.08;
 X1 = (b-a).*rand(size(CuePropInc,1),1) + a;


 a = 2.92;
 b = 3.08;
 X3 = (b-a).*rand(size(LLPropInc,1),1) + a;
 
 a = 1.92;
 b = 2.08;
 X2 = (b-a).*rand(size(RewPropInc,1),1) + a;


for level = 1:2
 if level == 1 
     CueProp = CuePropInc*100;
    RewProp = RewPropInc*100;
    LLProp = LLPropInc*100;
    savestr = 'inc';
 elseif level == 2
      CueProp = CuePropDec*100;
    RewProp = RewPropDec*100;
    LLProp = LLPropDec*100;
    savestr = 'dec';
 end
    f = figure;
    % f.Position = [350 350 380 400];
    hold on 
         
        scatter(X1, CueProp, 120, MarkerFaceColor =  [.7 .7 .7], MarkerEdgeColor='k'); 
        c =  bar(1, mean(CueProp))
        set(c,'FaceColor', [.7 .7 .7] ,'FaceAlpha', 0.3); 
        SEM =   std(CueProp,[],1)/sqrt(size(CueProp,1));  
        errorbar(1,  mean(CueProp),SEM, 'Color', 'k', 'LineWidth', 2)
        datacue = [ mean(CueProp),SEM]

        scatter(X2, RewProp, 120, MarkerFaceColor = [0 0.4470 0.7410] , MarkerEdgeColor='k'); 
        c =  bar(2, mean(RewProp))
        set(c,'FaceColor', [0 0.4470 0.7410] ,'FaceAlpha', 0.3); 
        SEM =   std(RewProp,[],1)/sqrt(size(RewProp,1));  
        errorbar(2,  mean(RewProp),SEM, 'Color', 'k', 'LineWidth', 2)
        dataRew = [ mean(RewProp),SEM]

        scatter(X3, LLProp, 120, MarkerFaceColor = 'm' , MarkerEdgeColor='k'); 
        c =  bar(3, mean(LLProp))
        set(c,'FaceColor', 'm' ,'FaceAlpha', 0.3); 
         SEM =   std(LLProp,[],1)/sqrt(size(LLProp,1));  
        errorbar(3,  mean(LLProp),SEM, 'Color', 'k', 'LineWidth', 2)
       dataLL = [ mean(LLProp),SEM]

        xticks(1:1:3)
        xticklabels({'Cue', 'Rew', 'Last Lick'})
        ylabel('Percent (%)')
        set(gca, 'FontSize', 22)
          ylim([0 60])
        xlim([0 4])
        [p_LL_R,h] = ranksum(LLProp, RewProp)
        [p_Cue_R,h] = ranksum(CueProp, RewProp)
        [p_Cue_LL,h] = ranksum(CueProp, LLProp)

        p = p_Cue_R
         if p < 0.001
           ptext = ['***'];
        elseif p < 0.01
           ptext = ['**'];
        elseif p < 0.05
           ptext = ['*'];
        elseif p > 0.05
           ptext = ['ns'];
        end   
      
        xpts = [1 1.8];
        ypts = [35 35];
        text(mean(xpts)-0.1, mean(ypts)+0.03, ptext, 'FontSize',25) 
        f = line(xpts, ypts, 'LineWidth', 1.2, 'Color', 'k');

           p = p_LL_R
         if p < 0.001
           ptext = ['***'];
        elseif p < 0.01
           ptext = ['**'];
        elseif p < 0.05
           ptext = ['*'];
        elseif p > 0.05
           ptext = ['ns'];
        end   
     
        xpts = [2.2 3];
        ypts = [35 35];
        text(mean(xpts)-0.1, mean(ypts)+0.01, ptext, 'FontSize',25) 
        f = line(xpts, ypts, 'LineWidth', 1.2, 'Color', 'k');


           p =  p_Cue_LL
         if p < 0.001
           ptext = ['***'];
        elseif p < 0.01
           ptext = ['**'];
        elseif p < 0.05
           ptext = ['*'];
        elseif p > 0.05
           ptext = ['ns'];
        end   
      
        xpts = [1 3];
        ypts = [45 45];
        text(mean(xpts)-0.2, mean(ypts)+0.01, ptext, 'FontSize',25) 
        f = line(xpts, ypts, 'LineWidth', 1.2, 'Color', 'k');
       
         
        savename = [savestr 'neurons-thres']
        title(savename)
        print('-painters','-dpng',[savename],'-r600');
        savefig([savename '.fig'])
end
