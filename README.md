# CombineVisualizerApplication

## Overview
CombineVisualizerApplication is a macOS-exclusive application designed to receive and display method information of Combine elements (Publishers, Subscribers, Subscriptions, and Subjects) in a visually appealing format from [CombineVisualizer](https://github.com/momo-youngg/CombineVisualizer). This project complements CombineVisualizer by acting as a receiver for the method information transmitted over the localhost.

## Description
The CombineVisualizerApplication acts as a visualizer for the method invocations captured by the CombineVisualizer project. It sets up an embedded server to listen for incoming method information transmitted from [CombineVisualizer](https://github.com/momo-youngg/CombineVisualizer). Upon receiving the method information, the application presents it on the screen in an aesthetically pleasing manner.

The application provides a user-friendly interface that allows developers to analyze the execution flow of Combine workflows effectively. By visually representing the method invocations, including the order, threads, and other relevant details, developers can gain valuable insights into the inner workings of their Combine-based applications.

## Usage
To use CombineVisualizerApplication, follow these steps:

1. Ensure that the CombineVisualizer project is running and transmitting the method information to the localhost.
2. Build and run the CombineVisualizerApplication on your macOS machine. (or you can just run it by .dmg file in root directory)
3. The application will automatically listen for incoming method information from CombineVisualizer.
4. Default port is 8080. If you want to change, fill the form with the port which you want to use (must same as in [CombineVisualizer](https://github.com/momo-youngg/CombineVisualizer)) and press 'apply' button. 
5. Once the method information is received, the application will display it on the screen in a visually appealing format.

## Example:
![CombineVisualizerApplication Screenshot](https://github.com/momo-youngg/CombineVisualizerApplication/tree/main/screenshots/main.png)


## Reference 
- [GCDWebServer](https://github.com/swisspol/GCDWebServer)
