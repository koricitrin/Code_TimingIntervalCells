

%% find correlation of PAC and lick time


for cond = 1:2

    if cond == 1 
  Filename = '*correlationLickPAC0527.mat'
    elseif cond == 2
  Filename = '*correlationLickLickOn0527.mat'
    end

TablePath = 'Z:\Kori\immobile_code\RiseDown\tables\2025-05to05\Variable\D1\Hundreds\';
cd(TablePath)
FP=fullfile(TablePath,Filename);
d=dir(FP);  

for files = 1:size(d,1)
    
    load(d(files).name)
    Rval1(files) = correlation;
    Fisher1(files) = zCorr;
end

TablePath = 'Z:\Kori\immobile_code\RiseDown\tables\2025-05to05\Variable\D2\Hundreds\';
cd(TablePath)
FP=fullfile(TablePath,Filename);
d=dir(FP);  

for files = 1:size(d,1)
    
    load(d(files).name)
    Rval2(files) = correlation;
    Fisher2(files) = zCorr;
end
TablePath = 'Z:\Kori\immobile_code\RiseDown\tables\2025-05to05\Variable\D3\Hundreds\';
cd(TablePath)
FP=fullfile(TablePath,Filename);
d=dir(FP);  

for files = 1:size(d,1)
    
   load(d(files).name)
    Rval3(files) = correlation;
   Fisher3(files) = zCorr;
end

RCats = [Rval1, Rval2, Rval3];
MeanCorr = mean(RCats)

RZCats = [Fisher1, Fisher2, Fisher3];

[h,p,ci,stats] = ttest(RZCats)

if cond == 1 
    PAC_RCats = RCats;
    PAC_MeanCorr = MeanCorr;
elseif cond == 2
    LickOn_RCats = RCats;
    LickOn_MeanCorr = MeanCorr;
end

clear RCats MeanCorr

end

std_data = std(PAC_RCats', 0,1,'omitnan');
std_data = std_data/ sqrt(size(PAC_RCats,2));
PAC_Stats = [mean(PAC_RCats), std_data]

std_data = std(LickOn_RCats', 0,1,'omitnan');
std_data = std_data/ sqrt(size(LickOn_RCats,2));
LickOn_Stats = [mean(LickOn_RCats), std_data]



     X1 = ones(size(PAC_RCats,2),1)'*1;
     X2 = ones(size(LickOn_RCats,2),1)'*2;
          
        
        Y = [{PAC_RCats}  {LickOn_RCats}];
        X = [{X1} {X2}];
        

  
% fig = figure;
% set(fig, 'Units', 'pixels', 'Position', [100 200 600 700]);
figure
axis square
hold on
C = hot(10)
 for Stages = 1:2
        b = boxchart(X{Stages}, Y{Stages})
        
        if Stages == 1
        b.BoxFaceColor = C(1,:); 
        % elseif  Stages == 2
        % b.BoxFaceColor = C(3,:); 
        elseif  Stages == 2

        b.BoxFaceColor = C(5,:); 
        end
        
         
        xticks(1:1:3)
        xticklabels({'TICs', 'Lick On'})
        ylabel('Correlation with lick time')
        set(gca, ...
            'FontSize', 16)
         ylim([-1 1])
 
          T = ['CorrEarlyLearningLickTimeTicLickOn']
           savefig([T '.fig'])
        print('-painters','-dpng', [T '.png'], '-r600')
        print('-painters','-dpdf', [T '.pdf'], '-r600')
            % 
         
        end