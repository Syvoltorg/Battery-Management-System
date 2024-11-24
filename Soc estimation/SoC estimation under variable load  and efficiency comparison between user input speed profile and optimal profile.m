% SOC_Estimation_with_Efficiency.m
% Version: 1.0
% Script for State of Charge (SOC) estimation under variable load 
% and efficiency comparison between user input speed profile and optimal profile.

% -----------------------------
% Parameters
% -----------------------------
battery_capacity_Ah = 10;  % Battery capacity in Ah
battery_voltage = 36;      % Battery voltage in volts
cycle_weight = 20;         % Weight of the cycle in kg
person_weight = 70;        % Weight of the rider in kg
total_weight = cycle_weight + person_weight;  % Total load in kg
initial_soc = 100;         % Initial SOC in percentage

% Load parameters
base_load = 150;           % Base load power in Watts
weight_factor = 0.5;       % Power scaling factor by weight
speed_factor = 1;          % Power scaling factor by speed

% Time parameters
time_step = 1;             % Time step in seconds
max_duration = 7200;       % Maximum simulation duration in seconds (2 hours)
time = 0:time_step:max_duration;

% -----------------------------
% User Input: Speed Profile
% -----------------------------
prompt = 'Enter speed in km/h (single value or array for variable speed): ';
user_speed_input = input(prompt);  % Example: [10, 15, 20, 25] for varying speeds

% Handle constant or variable speed inputs
if length(user_speed_input) == 1
    speed_profile = user_speed_input * ones(size(time));  % Constant speed
else
    % Interpolation for variable speed inputs
    speed_time_points = linspace(0, max_duration, length(user_speed_input));
    speed_profile = interp1(speed_time_points, user_speed_input, time);
end

% Convert speed from km/h to m/s
speed_profile_mps = speed_profile * 1000 / 3600;

% Optimal operation profile
optimal_speed_kmh = 15;  % Moderate optimal speed in km/h
optimal_speed_mps = optimal_speed_kmh * 1000 / 3600;  % Convert to m/s
optimal_load_power = base_load + weight_factor * total_weight + speed_factor * optimal_speed_mps^2;

% -----------------------------
% Load and SOC Calculation
% -----------------------------
load_power_profile = base_load + weight_factor * total_weight + speed_factor * speed_profile_mps.^2;
battery_capacity_Wh = battery_capacity_Ah * battery_voltage;  % Battery capacity in Wh
soc = zeros(size(time));  % SOC array for user profile
optimal_soc = zeros(size(time));  % SOC array for optimal profile
soc(1) = initial_soc;         % Initial SOC for user profile
optimal_soc(1) = initial_soc; % Initial SOC for optimal profile

% SOC Calculation Loop
time_to_zero_soc = 0;         % Time for 0% SOC (user profile)
optimal_time_to_zero_soc = 0; % Time for 0% SOC (optimal profile)

for i = 2:length(time)
    % User profile
    power_consumption = load_power_profile(i);  % Power consumed
    energy_consumed_Wh = power_consumption * (time_step / 3600);  % Convert to Wh
    soc(i) = soc(i-1) - (energy_consumed_Wh / battery_capacity_Wh) * 100;
    
    % Optimal profile
    optimal_energy_consumed_Wh = optimal_load_power * (time_step / 3600);  % Convert to Wh
    optimal_soc(i) = optimal_soc(i-1) - (optimal_energy_consumed_Wh / battery_capacity_Wh) * 100;
    
    % Check if SOC reaches 0% for user profile
    if soc(i) <= 0 && time_to_zero_soc == 0
        soc(i) = 0;
        time_to_zero_soc = time(i);  % Record time for user profile
    end
    
    % Check if SOC reaches 0% for optimal profile
    if optimal_soc(i) <= 0 && optimal_time_to_zero_soc == 0
        optimal_soc(i) = 0;
        optimal_time_to_zero_soc = time(i);  % Record time for optimal profile
    end
end

% Calculate efficiency
efficiency = (time_to_zero_soc / optimal_time_to_zero_soc) * 100;

% -----------------------------
% Results Visualization
% -----------------------------
figure;

% Plot 1: SOC over time
subplot(3,1,1);
plot(time(1:i) / 60, soc(1:i), 'b', 'LineWidth', 2);
hold on;
plot(time(1:i) / 60, optimal_soc(1:i), 'r--', 'LineWidth', 2);
xlabel('Time (minutes)');
ylabel('State of Charge (SOC) %');
title('SOC Estimation: User vs Optimal Profile');
legend('User Profile', 'Optimal Profile');
grid on;

% Display efficiency
disp(['Time to 0% SOC (User Profile): ', num2str(time_to_zero_soc / 60), ' minutes']);
disp(['Time to 0% SOC (Optimal Profile): ', num2str(optimal_time_to_zero_soc / 60), ' minutes']);
disp(['Battery Efficiency: ', num2str(efficiency), '%']);

% Plot 2: Time vs SOC
subplot(3,1,2);
plot(soc(1:i), time(1:i) / 60, 'b', 'LineWidth', 2);
hold on;
plot(optimal_soc(1:i), time(1:i) / 60, 'r--', 'LineWidth', 2);
xlabel('State of Charge (SOC) %');
ylabel('Time (minutes)');
title('Time to 0% SOC: User vs Optimal Profile');
legend('User Profile', 'Optimal Profile');
grid on;

% Plot 3: Speed profile
subplot(3,1,3);
plot(time / 60, speed_profile, 'b', 'LineWidth', 2);
xlabel('Time (minutes)');
ylabel('Speed (km/h)');
title('User Input Speed Profile Over Time');
grid on;
