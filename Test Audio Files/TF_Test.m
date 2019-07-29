%A = LogScale(15, 400, 7000, 1, 0.05);
%Filters = FIR(A(:, 1:4), 6);
%Filters = IIR_Filter_Bank(A, 6, 'butter', 20);
%writeFilteredSignal('Rhythm/Classical - Fur Elise.wav', Filters, A(:, 5));

%rhythm = ['Classical - Canon.wav', 'Classical - Fur Elise.wav', 'Country - Beer.wav', 'Country - Our Song.wav', 'EDM - Avicii.wav', 'EDM - Sky.wav', 'Rap - Empire.wav', 'Rap - Lose Yourself.wav', 'Rock - Queen.wav', 'Rock - Tiger.wav'];

songNames = ["Intensity/Ambulance.wav","Intensity/Danger.wav","Intensity/Fire Bell.wav","Intensity/Smoke Alarm.wav","Pitch Accuracy/High.wav","Pitch Accuracy/Medium.wav","Pitch Accuracy/Low.wav","Rhythm/Classical - Canon.wav","Rhythm/Classical - Fur Elise.wav","Rhythm/Country - Beer.wav","Rhythm/Country - Our Song.wav","Rhythm/EDM - Avicii.wav","Rhythm/EDM - Sky.wav","Rhythm/Rap - Empire.wav","Rhythm/Rap - Lose Yourself.wav","Rhythm/Rock - Tiger.wav","Rhythm/Rock - Queen.wav"];

%% File Number, Num Filters, Order, OL, UL, Gain
Linear = [2,8,6,0,7000,20;
          4,15,6,0,4000,60;
          6,8,20,0,4000,60;
          8,15,20,0,7000,20;
          10,8,6,0.2,7000,60;
          12,15,6,0.2,4000,20;
          14,8,20,0.2,4000,20;
          16,15,20,0.2,7000,60;];
      
Log = [1,8,6,1,4000,20;
       3,15,6,1,7000,60;
       5,8,20,1,7000,60;
       7,15,20,1,4000,20;
       9,8,6,1.2,4000,60;
       11,15,6,1.2,7000,20;
       13,8,20,1.2,7000,20;
       15,15,20,1.2,4000,60;];
 %% 
for i = 1:max(size(songNames))
    for j = 1:8     %Linear Filtering
        A = linearFilterBands(Linear(j,2),400,Linear(j,5),Linear(j,4),0.05);
        Filters = IIR_Filter_Bank(A,Linear(j,3),'ellip',Linear(j,6));
        songNames(i);
        writeFilteredSignal(songNames(i), Filters, A(:, 5), Linear(j,1));
    end
    for j = 1:8     %Log Filtering
        A = LogScale(Log(j,2),400,Log(j,5),Log(j,4),0.05);
        Filters = IIR_Filter_Bank(A,Log(j,3),'ellip',Log(j,6));
        writeFilteredSignal(songNames(i), Filters, A(:, 5), Log(j,1));
    end
 end
