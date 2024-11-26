# SoC Estimation and Battery Management System Simulation

This repository contains MATLAB scripts for simulating the State of Charge (SoC) estimation of batteries used in electric vehicles (EVs), specifically under variable load conditions. It also compares the efficiency of user-defined speed profiles with optimal speed profiles, while considering various factors such as road types and temperature variations. The primary goal is to help estimate battery SoC in real-time and analyze its performance under different operational conditions.

## Features

- **SoC Estimation**: Dynamically calculates the SoC over time for both user-defined and optimal speed profiles.
- **Efficiency Comparison**: Estimates battery efficiency as a percentage based on runtime comparisons between user-defined and optimal profiles.
- **Road Type Simulation**: Simulates battery consumption over different road types (e.g., Highway, Muddy Road, Village Road, City Traffic).
- **Temperature Effects**: Simulates the impact of varying temperatures on SoC drain and compares results under normal and temperature-dependent conditions.
- **Visualizations**: Generates various plots to visualize SoC trends, efficiency metrics, and speed profiles over time.

## Prerequisites

- MATLAB R2020b or later.
- Simulink (for additional simulation components, if needed).

## Scripts

### 1. `SoC Estimation and Efficiency Comparison with Speed Profiles`
This script estimates the SoC of an EV battery over time based on user-defined speed profiles and compares its performance with an optimal speed profile.

#### Key Variables:
- `battery_capacity_Ah`: Battery capacity in amp-hours.
- `battery_voltage`: Battery voltage in volts.
- `cycle_weight`, `person_weight`: Weight of the cycle and rider.
- `base_load`: Base power consumption in watts.
- `weight_factor`, `speed_factor`: Scaling factors for load and speed.
- `initial_soc`: Initial SoC in percentage.

#### Functionality:
- Calculates SoC for both user and optimal speed profiles.
- Compares the time to 0% SoC between the user profile and optimal profile.
- Displays efficiency as a percentage based on SoC depletion.

#### Outputs:
- SoC over time for both user and optimal profiles.
- Efficiency comparison.
- Speed profile over time.

### 2. `SoC Estimation under Variable Load with Weight and Speed`
A simplified version of SoC estimation focusing on weight and speed profile inputs.

#### Functionality:
- Takes a user-defined speed profile and calculates SoC over time.
- Displays time to 0% SoC based on energy consumption.

#### Outputs:
- SoC estimation plot over time.
- Time vs SoC plot.
- Speed profile plot.

### 3. `SoC Drain Analysis under Varying Temperature Effects`
This script compares SoC drain under normal conditions (25°C) and temperature-dependent conditions over time.

#### Parameters:
- `battery_capacity`: Battery capacity in Ah.
- `voltage`: Rated voltage in volts.
- `cycling_time_hours`: Duration of the battery testing.
- `temperature_range`: Array of temperatures (20°C to 50°C) for testing.

#### Functionality:
- Simulates SoC drain over time under both normal and temperature-dependent conditions.
- Calculates the temperature-adjusted discharge rate.

#### Outputs:
- SoC comparison plots under normal and temperature-dependent conditions.

### 4. `SoC Estimation on Varied Road Conditions`
This script simulates the SoC reduction of an EV battery based on distances traveled on various road types with different energy consumption rates.

#### Key Variables:
- `initialSoC`: Initial State of Charge (SoC) in percentage.
- `batteryCapacity`: Battery capacity in kWh.
- `roadTypes`: Different road categories (e.g., Highway, Muddy Road, etc.).
- `roadConsumptionRates`: Energy consumption in kWh/km for each road type.
- `distanceTraveled`: Distance covered on each road type (in km).

#### Functionality:
- Simulates SoC reduction on different road types based on their respective energy consumption rates.
- Visualizes the SoC reduction using a bar chart.

#### Outputs:
- Bar chart comparing SoC at the start and after traveling on different road types.
- SoC reduction values annotated on the chart.
