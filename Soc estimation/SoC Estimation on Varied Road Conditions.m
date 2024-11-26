SoC = SoC - (energyUsed / batteryCapacity) * 100; % Update SoC
    SoC = max(SoC, 0); % Ensure SoC doesn't go below 0
    socHistory(end+1) = SoC; % Append to history
end

%% Visualize Results
figure;
bar(categorical(['Start', roadTypes]), socHistory, 'FaceColor', [0.2, 0.7, 0.8]); % Bar chart
xlabel('Road Types');
ylabel('State of Charge (SoC) %');
title('Battery SoC on Different Road Conditions');
grid on;

% Annotate SoC values on the chart
for i = 1:length(socHistory)
    text(i, socHistory(i) + 1, sprintf('%.2f%%', socHistory(i)), 'HorizontalAlignment', 'center');
end

%% Display Completion Message
disp('Simulation Complete. Check the plot for SoC visualization.');
