function PlotLearningSingleDayPAC(Paths, TablePath, quad, PAC)

    for k = 1:size(Paths,1)
        
          cd(Paths(k,:))
         % cd(Paths{k,:})
        load('FirstLick_LL.mat')
   
        sigma = 2; % Standard deviation
        filterSize = 11; % Must be an odd number
        
        % Generate Gaussian window
        gaussWindow = gausswin(filterSize, sigma);
        gaussWindow = gaussWindow ./ sum(gaussWindow); % Normalize to 1
        
        % Smooth data, using 'same' to keep the original length
        M = conv(FirstLick, gaussWindow, 'same'); 

        figure
        hold on

         plot(M, 'LineWidth',3, 'Color',[0.5 0 0.5])
        x = 1:length(M);
        y = M;
        c = polyfit(x,y,1);
        y_est = polyval(c,x);
        plot(x,y_est,'r--','LineWidth',2, 'Color','k')
         yyaxis left
          ylabel('First lick time (s)')
           xlabel('Trials')
           set(gca, 'FontSize', 16)
           xlim([1 length(M)])
      % title([ Paths{k}(1,43:58)])
       title([ Paths(k,43:58)])
      % T = [ 'LearningSingleDay'];
      % savefig([T '.fig'])
      % print('-painters','-dpng', [T '.png'], '-r600')
      % print('-painters','-dpdf', [T '.pdf'], '-r600')

   cd(TablePath)
  PACsQuad = [];

   Trials =    1:size(FirstLick);    
    TrialsQuad = round(length(Trials)/4)
    TrialsHun =  floor(length(Trials)/100)
              
firstlickquad = [];
    if quad == 1 
          x = [];
          for n = 1:4
            TrialsSel = TrialsQuad*n;
            if n ==1
           FL =  FirstLick(1:TrialsQuad);
            elseif n==4
            FL =  FirstLick(TrialsQuad*(n-1):end);
            else
            FL =  FirstLick(TrialsQuad*(n-1):(TrialsQuad*n));
            end
            firstlickquad = [firstlickquad, median(FL)]
           
            load([Paths(k,(43:58)) 'PACQ' num2str(n) '.mat']);
           PACsQuad = [ PACsQuad, PropPAC];
          
           x = [x, TrialsSel-TrialsQuad/2]
          end
        R = corrcoef(firstlickquad,PACsQuad);
       correlation =  R(2)
       savename = [ Paths(k,43:58) 'correlationLickPAC.mat']
       save(savename, "correlation")
        text(50,max(M)-0.3,num2str(correlation), 'FontSize', 15)
        yyaxis right
        plot(x, PACsQuad, 'LineWidth', 2)
        scatter(x, PACsQuad, "filled")
        T = [Paths(k,(43:58)) 'LearningSingleDay' 'PACquad'];
        savefig([T '.fig'])
        print('-painters','-dpng', [T '.png'], '-r600')
        print('-painters','-dpdf', [T '.pdf'], '-r600')
    elseif quad == 0 
         x = [];
          for n = 1:TrialsHun
            TrialsSel = 100*n;
            Hundred = 100;
            if PAC == 1
             load([ Paths(k,43:58) 'PACH' num2str(n) '.mat']);
            % load([ Paths{k}(1, 43:58) 'PACH' num2str(n) '.mat']);
           PACsQuad = [ PACsQuad, PropPAC];
               savestr = 'PAC';
             else PAC == 0
            load([Paths(k,(43:58)) 'LickOnH' num2str(n) '.mat']);
           PACsQuad = [ PACsQuad, PropLickOn];
            savestr = 'LickOn';
            end
           x = [x, TrialsSel]
            
           if n == 1 
             FL = FirstLick(1:TrialsSel);
           elseif n == TrialsHun
               FL =  FirstLick(Hundred*(n-1):end);
           else
              FL =  FirstLick(Hundred*(n-1):Hundred*n);;
           end
            firstlickquad = [firstlickquad, median(FL)] 
          end


if size(PACsQuad,2) < 3
    continue 
end
      [R,P] = corrcoef(firstlickquad,PACsQuad);
         pvalue =  P(2)
       correlation =  R(2)
        if correlation == 1 
            correlation = 0.99
        end
       zCorr = atanh(correlation);

        savename = [ Paths(k,43:58) 'correlationLick' savestr '0527.mat']
       % savename = [ Paths{k}(1,43:58) 'correlationLick' savestr '.mat']
       save(savename, "correlation", "zCorr")
        text(50,max(M)-0.3,num2str(correlation), 'FontSize', 15)
        xticks(0:100:1000)
        yyaxis right
        ylim([0 15])
        if PAC == 1 
        ylabel('% of PACs')
        else
            ylabel('% of Lick On')
        end
        plot(x, PACsQuad*100, 'LineWidth', 3)
        scatter(x, PACsQuad*100, 100, "filled")
        % T = [ Paths{k}(1,43:58) 'LearningSingleDay' savestr];
        T = [ Paths(k,43:58) 'LearningSingleDay' savestr];
        savefig([T '.fig'])
        print('-painters','-dpng', [T '.png'], '-r600')
        print('-painters','-dpdf', [T '.pdf'], '-r600')


    end
    

end
end