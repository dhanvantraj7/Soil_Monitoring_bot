# Soil-Monitoring-Bot
Allocated theme for E-yantra Robotics Competition 2021-2022 

## Theme Introduction
Soil is at the heart of agriculture and its quality directly affects the quality of the yield. While soil is regarded as the “fertile substrate” for agriculture, it is important to understand that a balance among mineral components, soil organic matter, air and water is essential for soil to make it suitable for agriculture.

Keeping the above scenario in mind, in eYRC 2021-22 present the theme Soil Monitoring Bot (SM), as the name suggests this comprises a robot deployed to monitor the soil conditions within an agriculture field divided into various farmlands. The robot swiftly navigates through them and monitors the soil condition. It then goes to the storage unit and supplies the necessary mineral, nutrients, organic matter, etc. as required by the soil.

In this theme, the team will build the SM Bot to deploy it on an arena that is the abstraction of the agriculture field. The brain of the robot is powered by an FPGA (Field Programmable Gate Array) that controls its sensors, actuators and pick-place mechanism.

Major challenges and learnings in this theme include building the Soil Monitoring Bot from scratch using an FPGA. This FPGA based robot will be able to traverse the arena, sense the environment and pick-and-place the necessary supplies from the supply unit to the field. It will also use wired and wireless communication techniques.

## Theme Implementation

### Project Description

A Soil monitoring robot was built using differential drive back tyres by the help of n20 motors with a castor wheel. An Electromagnet can hold and drop down the blocks. The IR sensors on the bot helps in finding the line to follow. The color sensor helps in finding the color required according to the need. The Xbee module is used for the wireless communication between laptop and bot which transmit and recieve the required inputs and outputs. The DE0-Nano FPGA board acts as the brain to control the overall functions interfacing all the IPs.

The codes needed for the final Implementation: The verilog codes used for different sensors with basic description of the code is given below.

adc_control: used in changing the analog data to digital data from IR sensor

uart: used in Transmission and Recieving of Xbee module

PWM_Generator: used for adjusting the wheel velocity

fsm: The transition between different states to achieve each functionality
