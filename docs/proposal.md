# Project Proposal

## 1. Motivation & Objective

With the growing popularity of smart devices, the Internet of Things (IoT) has become more important and relevant as a way to connect various types of devices together in a collaborative network. In order to have an effective IoT network, communication between devices with each other and remote servers must be fast and reliable. However, cloud computing comes with many requirements and constraints, including latency, security, throughput, and power consumption.

In this project, we focus on one of these requirements: power consumption. IoT devices can consume a lot of power, and they are often portable and/or energy-constrained. So, it is imperative to focus on energy efficiency. Edge-computing is a way to process information and data on the devices themselves. This can improve latency and lower the amount of wireless communication needed from the devices to the cloud. However, image sensors are not the best candidates for edge-computing since they already consume a lot of power, and transmitting images requires even more power.

The objective of our project is to optimize the power consumption of a system of edge-connected image sensors. We aim to do this by optimizing the rate of transmission of images from a network of devices to the cloud, by both reducing the rate of capture, transmitting only images of interest, and preventing transmission of redundant captures. By doing this, image processing and classification can be performed on the image sensors while minimizing power consumption.

## 2. State of the Art & Its Limitations

In recent years, there have been multiple proposals for techniques that can reduce the power consumption of image sensors. One way to reduce power consumption is to reduce the frequency of image transmission from the image sensor to the cloud. By utilizing both lower frequency of transmission, as well as using an algorithm to transmit only images of interest, researchers were able to reduce power consumption by 41% compared to the baseline method.

In the case of using a network of image sensors, another way to reduce power consumption is to prevent transmission of redundant frames that have been captured by multiple devices. For example, if an object of interest has been captured by 4 different image sensors, only one of the sensors needs to send the image to the cloud. If all of the sensors send the image to the cloud, 3 of the transmissions are redundant, and have consumed power unnecessarily. By using these methods, researchers were able to reduce transmission of images by 75%.

While the first method proved to be effective in reducing the power consumption of the image sensing device, it only looked at a single device. So, it is possible that power consumption could be further improved. The second method showed that image transmission could be further reduced. However, it did not analyze the improvements in power consumption that could have resulted in the process.

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

Firmware/low-level software debugging and hardware testing skills are necessary to implement the onboard camera system. Furthermore, the team must have knowledge of image classification models and deployment of these models at the edge to successfully implement the project. Lastly, resources required for this project include Edge Impulse or TF Lite Micro for deploying DNNs, ArduCAM software documentation for camera hardware debugging and  Microsoft Azure/AWS resources for storing images with a cloud service.

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

- __CONVINCE: Collaborative Cross-Camera Video Analytics at the Edge:__ Cross-camera communication approach for image classification with edge devices.
- __CamThings: IoT Camera with Energy-Efficient Communication by Edge Computing based on Deep Learning:__ Energy-efficient method of minimizing redundant classified images sent to a shared cloud service.
- __Parallel Inclusive Communication for Connecting Heterogeneous IoT Devices at the Edge:__ Methods for parallel communication using BLE and Wifi for heterogenous edge devices.

### 9.b. Datasets

- __MPII Human Pose Dataset:__ This dataset includes thousands of frames of humans gathered from YouTube videos.
- __Open Images V6 (Google):__ This is another dataset we may use. It contains labeled images of various objects and subjects.

### 9.c. Software

- __Arduino IDE:__ Developing image/video capture scripts for ArduCAM board.
- __Edge Impulse CLI:__ Tool for deploying image classification models on Arduino Nano 33 BLE Sense boards.
- __ArduCAM Repository:__ Open-source code for capturing images using the ArduCAM (OV2640) camera module on edge devices.

## 10. References

1. H. B. Pasandi and T. Nadeem, "CONVINCE: Collaborative Cross-Camera Video Analytics at the Edge," 2020 IEEE International Conference on Pervasive Computing and Communications Workshops (PerCom Workshops), 2020, pp. 1-5. 
 [_https://ieeexplore.ieee.org/document/9156251_](https://ieeexplore.ieee.org/document/9156251)
2. J. Lim, J. Seo and Y. Baek, "CamThings: IoT Camera with Energy-Efficient Communication by Edge Computing based on Deep Learning," 2018 28th International Telecommunication Networks and Applications Conference (ITNAC), 2018, pp. 1-6. 
_https://ieeexplore.ieee.org/document/8615368_
3. Zicheng Chi, Yan Li, Xin Liu, Yao Yao, Yanchao Zhang, and Ting Zhu. 2019. Parallel inclusive communication for connecting heterogeneous IoT devices at the edge. In Proceedings of the 17th Conference on Embedded Networked Sensor Systems (SenSys '19). Association for Computing Machinery, New York, NY, USA, 205–218. 
_https://doi.org/10.1145/3356250.3360046_
4. MPII Human Pose Dataset: _http://human-pose.mpi-inf.mpg.de/#overview_
5. Open Images V6: _https://storage.googleapis.com/openimages/web/index.html_
6. Arduino IDE: _https://www.arduino.cc/en/software_
7. Edge Impulse CLI: _https://docs.edgeimpulse.com/docs/cli-installation_
8. ArduCAM Repository: _https://github.com/ArduCAM/Arduino_
