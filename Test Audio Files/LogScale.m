function Frequencies = LogScale(N, Start, End, Coverage)
    A = zeros(5, N);
    ScalingFactor = End/Start;
    for i = 1:(N-1)
       left = Start * ScalingFactor^(i/N);
       right = Start * ScalingFactor^((i+1)/N);
       start = (Coverage * (left - right) + ((Coverage * (left-right))^2 + 4 * Right * Left)^0.5)/2;
       stop = Right * Left / start;
       
    end
Frequencies = 5;