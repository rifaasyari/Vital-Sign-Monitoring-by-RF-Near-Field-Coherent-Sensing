% Plotting figures
dataPath = ['D:\Research\SummerFall17\CnC\NCS\MotionDetection\',...
    'MyExperiment\DataCollected\Nov20'];
codePostProcessPath = 'D:\Research\SummerFall17\CnC\NCS\MotionDetection\MyExperiment';
addpath(codePostProcessPath);

[ncsAmp,ncsPh,~,~,t] = postProcess2(0.8,10,11,dataPath,'b1_1.mat',-1,35,65);

fs = 500;
nSample = length(ncsAmp);
idx = 1:nSample;
tshifted = ((idx-1)/fs)';

% figure
figure('Units', 'pixels', ...
    'Position', [100 100 250 250]);
hold on;
yyaxis left
h1 = plot(tshifted,ncsAmp);
xlabel('Time (sec)','FontName','Helvetica','FontSize',10);
ylabel('Amplitude (V)','FontName','Helvetica','FontSize',10);

yyaxis right
h2 = plot(tshifted,unwrap(ncsPh));
hYLabelRight = ylabel('Phase (Degree)','FontName','Helvetica','FontSize',10);

set(h1                         ,...
    'Color'         , [0.5 0 0]  ,...
    'LineStyle'     , '-'        ,...
    'LineWidth'     , 1          );

set(h2                         ,...
    'Color'         , [0.3 0.75 0.93]  ,...
    'LineStyle'     , ':'        ,...
    'LineWidth'     , 2          );

set( gca                       , ...
    'FontName'   , 'Helvetica' );

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );

%%
figure('Units', 'pixels', ...
    'Position', [100 100 250 250]);
hold on;

hBreath = line(tshifted,unwrap(ncsPh));

set(hBreath                            ,...
    'Color',     [0.3 0.3 0.3]          ,...
    'LineStyle', '-'                ,...
    'LineWidth', 1                  );

hXLabel = xlabel('Time (sec)');
hYLabel = ylabel('Respiration (a.u.)');
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 10          );

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );

%%
figure('Units', 'pixels', ...
    'Position', [100 100 350 200]);
hold on;

hHR = line(tshifted,ncsAmp);

set(hHR                             ,...
    'Color',     [0.3 0.3 0.3]      ,...
    'LineStyle', '-'                ,...
    'LineWidth', 1                  );

hXLabel = xlabel('Time (sec)');
hYLabel = ylabel('Heartbeat (a.u.)');
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 10          );

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );

%%
codePath = 'D:\Research\SummerFall17\CnC\NCS\MotionDetection\MDCodes';
addpath(codePath);

wName = 'db10';
[recNcsd8,~,~] = wavedecrec1(ncsAmp,tshifted,wName,8,1);
rmpath(codePath);

minPeakInterval = round(fs*60/120); % Apriori Condition: max heart rate 120 beats/min
[~,locs] = findpeaks(recNcsd8,'MinPeakDistance',minPeakInterval);

figure('Units', 'pixels', ...
    'Position', [100 100 350 200]);
hold on;

hNCSd8 = line(tshifted,recNcsd8);

set(hNCSd8                            ,...
    'Color',     [0.3 0.3 0.3]          ,...
    'LineStyle', '-'                ,...
    'LineWidth', 1                  );

hPk = line(tSample(locs),recNcsd8(locs));

set(hPk                         , ...
  'LineStyle'       ,'none'     ,...
  'Marker'          , 'o'         , ...
  'MarkerSize'      , 5           , ...
  'MarkerEdgeColor' , 'none'      , ...
  'MarkerFaceColor' , [.75 .75 1] );

hXLabel = xlabel('Time (sec)');
hYLabel = ylabel('Heartbeat (a.u.)');
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 10          );

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'XTick'       , 0:10:30   , ...
  'LineWidth'   , 1         );

%%
load('hr_hr2.mat')
load('hr_hrMotionCorrect2.mat')
load('hr_tBeat2.mat')

nBeatTrain = 166; %146, 166
windowSize = 30;

figure('Units', 'pixels', ...
    'Position', [100 100 500 250]);
hold on;

tRelative = tBeat(nBeatTrain+1+windowSize:end);
% tRelative = tBeat(nBeatTrain+1+windowSize:end) - tBeat(nBeatTrain+1+windowSize);
h_HR = line(tRelative,hr(nBeatTrain+1+windowSize:end));
h_HRmotionCorrect = line(tRelative,hrMotionCorrect(nBeatTrain+1+windowSize:end)); 

set(h_HR                            ,...
    'Color',     [0 0 0.2]          ,...
    'LineStyle', '-'                ,...
    'LineWidth', 1                  );
set(h_HRmotionCorrect               ,...
    'Color',     [0.3 0.75 0.93]    ,...
    'LineStyle', ':'                ,...
    'LineWidth', 2.0                );

hTitle = title('Heart Rate Motion Correction');
hXLabel = xlabel('Time (sec)');
hYLabel = ylabel('Heart Rate (bpm)');
hLegend = legend([h_HR, h_HRmotionCorrect],...
    'HR: No motion Correction',...
    'HR: Motion Correction');

set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle, hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
set([hLegend, gca]             , ...
    'FontSize'   , 8           );
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 10          );
set( hTitle                    , ...
    'FontSize'   , 12          , ...
    'FontWeight' , 'bold'      );

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 60:5:110, ...
  'LineWidth'   , 1         );

set(gcf, 'PaperPositionMode', 'auto');
% saveas(gcf,'finalPlot1.png')
% close;

%%
figure('Units', 'pixels', ...
    'Position', [100 100 500 250]);
hold on;

tRelative = tBeat(nBeatTrain+1+windowSize:end);
% tRelative = tBeat(nBeatTrain+1+windowSize:end) - tBeat(nBeatTrain+1+windowSize);
h_HR = line(tRelative,hr(nBeatTrain+1+windowSize:end));
h_HRmotionCorrect = line(tRelative,hrMotionCorrect(nBeatTrain+1+windowSize:end)); 

set(h_HR                            ,...
    'Color',     [0 0 0.2]          ,...
    'LineStyle', '-'                ,...
    'LineWidth', 1                  );
set(h_HRmotionCorrect               ,...
    'Color',     [0.3 0.75 0.93]    ,...
    'LineStyle', ':'                ,...
    'LineWidth', 2.0                );

hTitle = title('Heart Rate Motion Correction');
hXLabel = xlabel('Time (sec)');
hYLabel = ylabel('Heart Rate (bpm)');
hLegend = legend([h_HR, h_HRmotionCorrect],...
    'HR: No motion Correction',...
    'HR: Motion Correction');

set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle, hXLabel, hYLabel], ...
    'FontName'   , 'Helvetica');
set([hLegend, gca]             , ...
    'FontSize'   , 8           );
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 10          );
set( hTitle                    , ...
    'FontSize'   , 12          , ...
    'FontWeight' , 'bold'      );

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 60:5:110, ...
  'LineWidth'   , 1         );

set(gcf, 'PaperPositionMode', 'auto');
% saveas(gcf,'finalPlot1.png')
% close;

%%
figure('Units', 'pixels', ...
    'Position', [100 100 400 100]);
hold on;
hHR = plot(ncs);
set(gca, ...
  'Box'         , 'off'  , ... 
  'XColor'      , [1,1,1], ...
  'YColor'      , [1,1,1], ...
  'XTick'       , []     , ...
  'YTick'       , []     );

%