# Project Proposal

## 1. Motivation & Objective
With the growing popularity of smart devices, the Internet of Things (IoT) has become more important and relevant as a way to connect various types of devices together in a collaborative network. In order to have an effective IoT network, communication between devices with each other and remote servers must be fast and reliable. However, cloud computing comes with many requirements and constraints, including latency, security, throughput, and power consumption. 

In this project, we focus on one of these requirements: power consumption. IoT devices can consume a lot of power, and they are often portable and/or energy-constrained. So, it is imperative to focus on energy efficiency. Edge-computing is a way to process information and data on the devices themselves. This can improve latency and lower the amount of wireless communication needed from the devices to the cloud. However, image sensors are not the best candidates for edge-computing since they already consume a lot of power, and transmitting images requires even more power. 

The objective of our project is to optimize the power consumption of a system of edge-connected image sensors. We aim to do this by optimizing the rate of transmission of images from a network of devices to the cloud, by both reducing the rate of capture, transmitting only images of interest, and preventing transmission of redundant captures. By doing this, image processing and classification can be performed on the image sensors while minimizing power consumption.

## 2. State of the Art & Its Limitations
In recent years, there have been multiple proposals for techniques that can reduce the power consumption of image sensors. One way to reduce power consumption is to reduce the frequency of image transmission from the image sensor to the cloud. By utilizing both lower frequency of transmission, as well as using an algorithm to transmit only images of interest, researchers were able to reduce power consumption by 41% compared to the baseline method.  

In the case of using a network of image sensors, another way to reduce power consumption is to prevent transmission of redundant frames that have been captured by multiple devices. For example, if an object of interest has been captured by 4 different image sensors, only one of the sensors needs to send the image to the cloud. If all of the sensors send the image to the cloud, 3 of the transmissions are redundant, and have consumed power unnecessarily. By using these methods, researchers were able to reduce transmission of images by 75%. 

While the first method proved to be effective in reducing the power consumption of the image sensing device, it only looked at a single device. So, it is possible that power consumption could be further improved. 
The second method showed that image transmission could be further reduced. However, it did not analyze the improvements in power consumption that could have resulted in the process. 


## 3. Novelty & Rationale

Our approach is to combine the techniques from the above stated research. To improve power consumption of edge-computing image sensors, we will reduce the frequency of transmission to the cloud by utilizing an on-off scheduling system as well as capturing only objects of interest that have been classified by a neural network on-board. We will also reduce image transmission by preventing transmission of redundant objects of interest that have been captured by both image sensors in our network. Finally, if time allows, we will train our image sensing devices to learn the area of overlap within the fields of vision of both cameras. Then, once the overlapping FoV has been clearly defined, the devices will not have to check with each other to see if captured images are redundant or not - they can simply check the location of the object of interest. This will further reduce power consumption, since communication between the devices to check redundancy will be replaced by an internal positioning check. 

## 4. Potential Impact

If our project is successful, it will show that power consumption can be reduced in a network of edge-computing image sensors. Technically, it will prove that multiple techniques of power optimization can be utilized effectively for edge-computing image sensors. By analyzing our results, we will be able to measure the effectiveness of each technique, and find out if the techniques synergize with each other, or if the improvements in power consumption do not stack effectively. 

If our image sensors are able to effectively learn the overlapping FoV, and use it to gradually improve power consumption even more as time goes on, it could show that machine learning on edge-computing devices is effective and practical, and could open doors for more utilization of machine learning on portable devices as a way to optimize power and more.

## 5. Challenges

There are multiple challenges involved with this project:
- In terms of simply connecting the cameras with the Arduinos, the wired connections must be reliable and short in order to minimize latency and ensure image quality. 
- In our experiments, we plan to use human subjects to be the objects of interest to be captured by the image sensors. This was decided because humans are one of the only resources that we have control over that can move around the field of vision in a manner that we desire. However, gathering image datasets for human subjects may be difficult, since some image datasets feature only faces, and other datasets may have too much variety in their images.
- As Arduinos are not meant to be power computing devices, they may struggle with handling image classification. We will work with lightweight neural networks to overcome this issue.
- Calculating the power consumption of the image sensors may be slightly inaccurate, since we plan to manually measure the currents and voltages of the devices. 
- Communication, whether it is BLE communication between the Arduinos, BLE communication between the Arduinos and the bridge device, or WiFi communication between the bridge device and the cloud, may present challenges as well. Issues may arise with synchronization, data loss, and speed/throughput bottlenecks.

## 6. Requirements for Success

Hardware bring-up and debugging skills are necessary to implement the onboard camera system. Furthermore, the team must have knowledge of image classification models and deployment of these models at the edge to successfully implement the project. Lastly, resources required for this project include Edge Impulse or TF Lite Micro for deploying DNNs, ArduCAM software documentation for camera hardware debugging and  Microsoft Azure/AWS resources for storing images with a cloud service.

## 7. Metrics of Success

The team will implement the system with the energy-efficient approach and without the energy-effecient approach. Without knowledge of overlapping FOV between a two-camera system, unnecessary power will be used for classifying and sending redundant images to the cloud service. We will compare power consumption of the system using the two approaches to demonstrate the success of the approach. 

## 8. Execution Plan

1. Implement two-camera system with cross-camera communication. (Zion)
2. Deploy image classification models which run at the edge using TF Lite Micro or Edge Impulse. (Sung Yoon)
3. Implement code for sending images to bridge device (smartphone or Arduino Nano 33 IoT) to push to cloud service. (Zion)
4. Develop code for energy-efficient approach which minimizes redundant images sent to the cloud service. (Sung Yoon)
5. Design approach for computing overlapping FOV and integrate code for energy-efficient image classification and storage. (Zion)

## 9. Related Work

### 9.a. Papers

List the key papers that you have identified relating to your project idea, and describe how they related to your project. Provide references (with full citation in the References section below).


### 9.b. Datasets

List datasets that you have identified and plan to use. Provide references (with full citation in the References section below).

### 9.c. Software

List softwate that you have identified and plan to use. Provide references (with full citation in the References section below).

## 10. References

List references correspondign to citations in your text above. For papers please include full citation and URL. For datasets and software include name and URL.
