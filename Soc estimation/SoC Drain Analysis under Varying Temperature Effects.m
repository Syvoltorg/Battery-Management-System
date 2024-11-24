% SoC Drain Comparison with Temperature Effects
% Version: 1.0
% This script compares the State of Charge (SoC) drain of a battery under normal
% and temperature-dependent conditions over a period of time.
% The discharge rate increases with temperature deviations from the reference temperature.

%% Parameters
% Initial settings and battery specifications
initial_soc = 100; % Initial state of charge (100% at the start)
time_hours = 0:0.5:2; % Time vector from 0 to 2 hours with 0.5 hour intervals
temperature_range = 20:5:50; % Temperature range (20°C to 50°C in 5°C steps)

% Battery specifications
battery_capacity = 10; % Battery capacity in Ah
voltage = 36; % Rated voltage in volts
cycling_time_hours = 2; % Continuous cycling time in hours

% Discharge rate settings
reference_temperature = 25; % Reference temperature (25°C) for normal discharge rate
normal_discharge_rate = 1 / (battery_capacity * cycling_time_hours); % Base discharge rate at 25°C
temperature_discharge_factor = 0.002; % Additional SoC discharge factor per °C deviation from reference

%% SoC Calculation
% Calculate SoC for normal operation (25°C) and temperature-dependent operation

% SoC under normal operation (25°C)
soc_normal = calculate_soc(initial_soc, normal_discharge_rate, time_hours);

% SoC under temperature-dependent operation
soc_temp_dependant = zeros(length(time_hours), length(temperature_range)); % Initialize matrix

% Loop over each temperature to calculate temperature-dependent SoC drain
for j = 1:length(temperature_range)
    current_temp = temperature_range(j);
    % Calculate discharge rate with temperature adjustment
    discharge_rate = normal_discharge_rate + temperature_discharge_factor * (current_temp - reference_temperature);
    soc_temp_dependant(:, j) = calculate_soc(initial_soc, discharge_rate, time_hours);
end

%% Plotting the Results
% Plot SoC for both normal operation and temperature-dependent operation

figure;

% Plot SoC under normal operation (25°C)
plot(time_hours, soc_normal, 'k--', 'LineWidth', 2);
hold on;

% Plot SoC under temperature-dependent operation for each temperature
for j = 1:length(temperature_range)
    plot(time_hours, soc_temp_dependant(:, j), 'LineWidth', 1.5);
end

% Add labels, title, and legend
xlabel('Time (hours)');
ylabel('State of Charge (SoC)');
title('SoC Drain Comparison: Normal vs. Temperature-Dependent Operation');
legend(['Normal Operation (25°C)', ...
    arrayfun(@(x) sprintf('Temp = %d°C', x), temperature_range, 'UniformOutput', false)]);
grid on;
hold off;

%% Function Definitions

% Function to calculate State of Charge (SoC) based on a discharge rate
function soc = calculate_soc(initial_soc, discharge_rate, time_hours)
    % Calculate the SoC using exponential decay based on the discharge rate
    soc = initial_soc * exp(-discharge_rate * time_hours);
end
