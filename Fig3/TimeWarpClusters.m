FRProf = ['Z:\Kori\immobile_code\RiseDown\tables\2025-05to05\Variable\Path4sData\PAC_kmeans_folders\PAC_Kmeans_noPCA_start_2\'] 
cd(FRProf)

trtype = 2
if trtype == 1 
    load('DataEarlyLick.mat')
elseif trtype == 2  
    load('DataLateLick.mat')
end
 
fs = 500; 

% ca_aligned : [T x N x Trials]
% time_aligned : [T x 1], e.g. -1:0.1:2
% lickLatency(tr) : time from cue to first lick for this trial
LTtarget =1;  % warp cue→lick to 1 second

 
% Choose how many samples you want in the warped trace
nWarp = 3000; %%change from 2500 3/12
warpTime = linspace(0, LTtarget, nWarp);  % warped timeline starting at cue

    cueT = 0;
 for Cluster = 1:2
    if trtype == 1 
        
            if Cluster == 1 
            Avg3545s = SortedCluster1;
            elseif Cluster == 2 
            Avg3545s = SortedCluster2;
            end
            lickT =  4.0331*fs;
        
            ca_seg = Avg3545s(:,1501:end); %%remove the bef time
            seg_pre = Avg3545s(:,501:1500);
            seg_post = Avg3545s(:,lickT+1500:end);

    elseif trtype == 2
        
            if Cluster == 1 
            Avg56s = SortedCluster1;
            elseif Cluster == 2 
            Avg56s = SortedCluster2;
            end
            lickT = 5.4189*fs;
        
            ca_seg = Avg56s(:,1501:end);
            seg_pre = Avg56s(:,501:1500);
            seg_post = Avg56s(:,lickT+1500:end);
           
    end
     t_orig =  1:length(ca_seg)

    LTtrial = lickT;   % cue→lick latency

    if LTtrial <= 0 || isnan(LTtrial)
        continue
    end

    % % -------- FEED ONLY POST-CUE TIMES --------
    % idx_post = find(time_aligned >= 0);
    % 
    % t_orig = time_aligned(idx_post);              % post-cue times
    % ca_seg = squeeze(ca_aligned(idx_post,:,tr));  % [postSamples x neurons]

    % -------- Compute warped time axis --------
    t_warp = t_orig * (LTtarget / LTtrial);

    % -------- Warp calcium by interpolation --------
    for neur = 1:size(ca_seg) 
    warpedCa(neur,:) = interp1(t_warp, ca_seg(neur,:), warpTime, 'linear', 'extrap');
    end

    if Cluster == 1 
     warpedCluster1 =  warpedCa;
     PrePostCluster1 = [(seg_pre), (warpedCluster1), (seg_post)];
    elseif Cluster == 2
     warpedCluster2 =  warpedCa;
     PrePostCluster2 = [(seg_pre), (warpedCluster2), (seg_post)];
    end
   clear warpedCa seg_pre seg_post

 end

 if trtype == 1 
save('TimewarpMatrixEarly.mat', 'warpedCluster2', 'warpedCluster1', 'PrePostCluster1', 'PrePostCluster2')
T = ['Time warped']
TT = ['TimeWarped' 'EarlyLickClusters']
 elseif trtype == 2
save('TimewarpMatrixLate.mat', 'warpedCluster2', 'warpedCluster1', 'PrePostCluster1', 'PrePostCluster2')
TT = ['TimeWarped' 'LateLickClusters']
 end


 c = winter(10);
figure
hold on
 

Mean1 = mean(warpedCluster1);
Mean1Norm =  (Mean1 - min(Mean1))/(max(Mean1) - min(Mean1));
Mean2 = mean(warpedCluster2);
Mean2Norm =  (Mean2 - min(Mean2))/(max(Mean2) - min(Mean2));

 avg_data = (Mean1);
  x = 1:size(avg_data,2);
 std_data = std(warpedCluster1, 0,1,'omitnan')
 std_data = std_data/ sqrt(15);
fill([x, flip(x)], [avg_data+std_data, flip(avg_data-std_data)],  'g', 'FaceAlpha',0.3)
plot(x, avg_data, 'g', 'LineWidth', 4)


 avg_data = (Mean2);
  x = 1:size(avg_data,2);
 std_data = std(warpedCluster2, 0,1,'omitnan')
 std_data = std_data/ sqrt(15);
fill([x, flip(x)], [avg_data+std_data, flip(avg_data-std_data)], 'b', 'FaceAlpha',0.3)
plot(x, avg_data, 'Color', 'b', 'LineWidth', 4)

 legend({'','Cluster 1', '','Cluster 2'}, 'Location', 'best')
xticks([1  3000])
xticklabels({'Last Lick' 'First Lick'})
xlabel('Norm. time')
ylabel('dF/F')
ylim([0 1])
T = ['Time warped']
title(T)

axis square
set(gca, 'FontSize', 16)
  savefig([ TT '.fig'])
  print('-painters','-dpng',[ TT],'-r600');
  print('-painters','-dpdf',[ TT],'-r600');

