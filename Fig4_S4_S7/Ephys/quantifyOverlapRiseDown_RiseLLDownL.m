% quantify overlap in rise down 

cd('Z:\Kori\immobile_code\Ephys\0403\')


 load('All_Recs_RiseDownID_AlignLick.mat')
  % load('A084-20221209-03_RiseDownID_LickWholePop.mat')
TableLick = RiseDownTable;
 load('All_Recs_RiseDownID_AlignLastLick.mat')
TableLastLick = RiseDownTable;
%  load('All_Recs_RiseDownID_AlignCue.mat')
% TableCue = RiseDownTable;


TableLick = renamevars(TableLick,"isRise","RiseLick");
TableLastLick = renamevars(TableLastLick,"isRise","RiseLastLick");
% TableCue = renamevars(TableCue,"isRise","RiseCue");

TableLick = renamevars(TableLick,"isDown","DownLick");
TableLastLick = renamevars(TableLastLick,"isDown","DownLastLick");
% TableCue = renamevars(TableCue,"isDown","DownCue");

TableLick = renamevars(TableLick,"ratio0to1BefRun","RatioLick");
TableLastLick = renamevars(TableLastLick,"ratio0to1BefRun","RatioLastLick");
% TableCue= renamevars(TableCue,"ratio0to1BefRun","RatioCue");

RiseDownTableAllCond = [TableLick(:,1), TableLick(:,2), TableLick(:,4), TableLastLick(:,4), TableLick(:,5), TableLastLick(:,5), TableLick(:,3), TableLastLick(:,3)];

RiseLLDownLickInd = (RiseDownTableAllCond.RiseLastLick == 1 & RiseDownTableAllCond.DownLick == 1);
RiseLLDownLickNeuronID =  RiseDownTableAllCond(RiseLLDownLickInd,1:2);
RiseLLDownLickRatio =  RiseDownTableAllCond(RiseLLDownLickInd,7:8);
PropRiseLLDownL = size(RiseLLDownLickNeuronID,1)/size(TableLastLick,1);
save("RiseLastLickDownLickNeurons.mat", 'RiseLLDownLickNeuronID', 'RiseLLDownLickRatio', 'PropRiseLLDownL')

% RiseCueDownLickInd = (RiseDownTableAllCond.RiseCue == 1 & RiseDownTableAllCond.DownLick == 1);
% RiseCueDownLickNeuronID =  RiseDownTableAllCond(RiseCueDownLickInd,1:2);
% RiseCueDownLickRatio =  RiseDownTableAllCond(RiseCueDownLickInd,9);
% PropRiseCueDownL = size(RiseCueDownLickNeuronID,1)/size(TableLastLick,1);
% save("RiseCueDownLickNeurons.mat", 'RiseCueDownLickNeuronID', 'RiseCueDownLickRatio', 'PropRiseCueDownL')

 RiseLickDownLLInd = (RiseDownTableAllCond.RiseLick == 1 & RiseDownTableAllCond.DownLastLick == 1);
RiseLickDownLLNeuronID =  RiseDownTableAllCond(RiseLickDownLLInd,1:2);
RiseLickDownLLRatio =  RiseDownTableAllCond(RiseLickDownLLInd,7:8);
PropRiseLickDownLL = size(RiseLickDownLLNeuronID,1)/size(TableLastLick,1);
%cd('Z:\Kori\immobile_code\ConstantBOPlots\New100\')
save("RiseLickDownLLNeurons.mat", 'RiseLickDownLLNeuronID', 'RiseLickDownLLRatio')

clear