%% Simulate Battery Management System (BMS) for EV on Different Road Types
% Version: 1.0
% Description: This script simulates the State of Charge (SoC) reduction of an EV battery
% based on distances traveled on various road types with different energy consumption rates.

%% Initial Parameters
initialSoC = 100; % Initial State of Charge in percentage
batteryCapacity = 75; % Battery Capacity in kWh
roadTypes = {'Highway', 'Muddy Road', 'Village Road', 'City Traffic Road'}; % Road categories
roadConsumptionRates = [0.15, 0.3, 0.25, 0.4]; % Energy consumption (kWh/km) for each road type
distanceTraveled = [50, 20, 30, 15]; % Distance traveled on each road type (in km)

%% Initialize Variables
SoC = initialSoC; % Current State of Charge
socHistory = [SoC]; % Record of SoC at each stage

%% Simulate SoC Reduction
for i = 1:length(roadTypes)
    % Calculate energy used and update SoC
    energyUsed = roadConsumptionRates(i) * distanceTraveled(i); % Energy used on this road
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
