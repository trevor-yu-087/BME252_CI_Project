function output = linearFilterBands(n, FL, FH, olPct, stopPct)
BW = FH - FL;           % Bandwidth of entire filter
CBW = BW/n;             % Channel Bandwidth
output = zeros(n,5);    % Output matrix of parameters

% col 1 | col2 | col3 | col4 | col5
%  FS 1 | FP 1 | FP 2 | FS 2 |  FC
output(:,2) = (FL:CBW:FH-CBW)' - olPct*CBW;     % Set linearly spaced passband frequencies, overlapping by olPct % of channel bandwidth
output(:,3) = output(:,2) + CBW*(1 + 2*olPct);    % Set linearly spaced upper pass frequency
output(:,1) = output(:,2) - stopPct*CBW;
output(:,4) = output(:,3) + stopPct*CBW;
output(:,5) = sqrt(output(:,2) .* output(:,3));

end
