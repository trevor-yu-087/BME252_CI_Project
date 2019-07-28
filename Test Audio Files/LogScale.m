function Frequencies = LogScale(N, Start, End, Coverage, Wing)
    A = zeros(5, N);
    ScalingFactor = End/Start;
    for i = 0:(N-1)
       left = Start * ScalingFactor^(i/N);
       right = Start * ScalingFactor^((i+1)/N);
       start = (Coverage * (left - right) + ((Coverage * (left-right))^2 + 4 * right * left)^0.5)/2;
       stop = right * left / start;
       A(2, i + 1) = start;
       A(3, i + 1) = stop;
       A(1, i + 1) = start * (start/stop)^Wing;
       A(4, i + 1) = stop * (stop/start)^Wing;
    end
    A(5, :) = (A(2, :) .* A(3, :)).^0.5;
Frequencies = A;