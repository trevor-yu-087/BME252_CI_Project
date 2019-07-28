function Frequencies = LogScale(N, Start, End, Coverage, Wing)
    A = zeros(N, 5);
    ScalingFactor = End/Start;
    for i = 0:(N-1)
       left = Start * ScalingFactor^(i/N);
       right = Start * ScalingFactor^((i+1)/N);
       start = (Coverage * (left - right) + ((Coverage * (left-right))^2 + 4 * right * left)^0.5)/2;
       stop = right * left / start;
       A(i + 1, 2) = start;
       A(i + 1, 3) = stop;
       A(i + 1, 1) = start * (start/stop)^Wing;
       A(i + 1, 4) = stop * (stop/start)^Wing;
    end
    A(:, 5) = (A(:, 2) .* A(:, 3)).^0.5;
Frequencies = A;
