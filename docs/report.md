# Table of Contents
* Abstract
* [Introduction](#1-introduction)
* [Related Work](#2-related-work)
* [Technical Approach](#3-technical-approach)
* [Evaluation and Results](#4-evaluation-and-results)
* [Discussion and Conclusions](#5-discussion-and-conclusions)
* [References](#6-references)

# Abstract

With recent advances in edge computing, networks of IoT devices have become more pervasive and as a result require more energy-efficient approaches for achieving tasks at the edge. Recent research aims to develop means for connecting various types of edge devices together in collaborative networks. To achieve better performance, novel methods must be developed to connect to remote servers in a fast and reliable manner. The objective of this project is to implement a dual camera edge device system which minimizes power consumption for running image classification models at the edge. In this project, the team implements an energy-efficient approach which utilizes camera-to-camera communication via BLE to reduce power consumption by minimizing redundant images sent to a shared cloud service. To achieve this objective, the team first implements a two-camera system with cross-camera communication via BLE. Second, the team deploys an image classification model which runs at the edge. Third, the team develops code for an energy-efficient approach which minimizes redundant images sent to the WiFi-device. Finally, the results of this project are measured by comparing power consumption of the system with energy-efficient communication and without it. Ultimately, the energy conservation that resulted from the two-camera overlap system was quite small, saving the system an estimated 0.74% in power consumption as compared to a system that does not utilize the two-camera overlap system.

# 1. Introduction

## Motivation & Objective
This project seeks to improve upon contemporary developments with edge computing specifically related to TinyML and multi-camera systems deployed on embedded systems. With a contemporary need to execute high compute, low latency tasks on large networks of edge devices, our project aims to improve power efficiency for image processing and classification systems while maintaining commensurate performance required of edge devices. Based on contemporary research which investigates optimization methods for power consumption on resource constrained edge devices, we would like to contribute a cross-camera communication approach which is energy efficient for image classification applications deployed on edge devices with limited hardware resources.

## State of the Art & Its Limitations
Novel research has proposed methods for reducing power consumption of image sensor and edge devices. One method proposed by J. Lim, J. Seo, and Y. Baek proposes an energy-efficient approach which reduces the frequency of image transmission to a shared cloud service. In this work, CamThings: IoT Camera with Energy-Efficient Communication by Edge Computing based on Deep Learning, the authors lower frequency of transmission and propose a deep neural network to transmit images of interest in order to achieve energy conservation. Power consumption via this novel approach achieved a 41% decrease compared to a baseline method. This approach is limited in that it only explores the reduction of power consumption when deploying the approach for a single device. Much more energy savings can be achieved if this approach were deployed for a multi-camera system.

Another novel research approach from H. B. Pasandi and T. Nadeem, presented in CONVINCE: Collaborative Cross-Camera Video Analytics at the Edge, aims to take advantage of spatio-temporal correlations between cameras as well as knowledge sharing to reduce overall power consumption. By reducing the number of redundant images sent to a shared cloud service, the proposed approach aims to reduce the costly power consumption related to sending images to the cloud via edge devices. This method was found to reduce transmission of redundant images by 75%; however, this approach still has the potential for further improvements. This work is limited in its analysis of energy savings associated with less frequency image transmission. Further power consumption could still be done to quantify the benefits of the approach proposed by CONVINCE.

## Novelty & Rationale
Our approach is to combine the energy-efficient camera-based edge computing approaches proposed by CONVINCE and CamThings. To improve power consumption of edge-computing image sensors, we first aim to reduce the frequency of transmission by utilizing an on-off scheduling system as well as capturing only events of interest that have been classified by a neural network at the edge. Second, we reduce image transmission by preventing transmission of redundant events of interest that have been captured by both image sensors in our network. Improved power consumption demonstrated from the CONVINCE and CamThings methods provides a reasonable rationale for expected improvements if the two approaches are combined in a multi-camera deep learning network for transmission of event images.

## Potential Impact
With an increased interest in event cameras and energy-efficient edge computing systems related to multiple image sensors, this project could demonstrate a viable approach for energy-efficient multi-camera networks in real-world applications. In terms of technical contributions, this project could demonstrate that multiple techniques for power optimization can be combined for effective edge computing and deep learning. Analysis of our project results will also provide approximate quantitative data for these techniques as a basis from which future work may build upon. 

## Challenges
There were many challenges with this project:
* Extremely heavy computational requirements for MobileNet V2 TF Lite image classification models. Even after reduction of layers when migrating to MobileNet V1, Arduino Nano 33 BLE Sense would frequently reach memory limitations when BLE capabilities were added. Compilation times were also massively increased due to the size of the TF Lite models.
* Major issues of BLE 5 for the Arduino Nano 33 BLE Sense include time synchronization, bandwidth limitations, speed of transfer and throughput bottlenecks. 
   * Established connections between BLE devices in the network frequently lapsed and disconnects became more frequency when memory resources became restricted during inference in real-time.
   * Bandwidth restrictions of BLE 5 disallowed the transmission of images via Bluetooth Low Energy; therefore, adjustments in system design were required to instead transfer labels for knowledge sharing between Arduino Nano devices.
   * Alternate methods such as image buffer chunking or image compression would further increase computational load on the edge device which made these approaches undesirable from a power saving perspective.
* Event camera modules and incompatibility with our resource constrained platform, Arduino Nano 33 BLE Sense. The initial technical approach involved transmission of 2MP images via the OV2640 camera module; however, image size and computational restrictions of the Arduino Nano made this camera unviable for the project.
* Limitations of OV7670 Camera. After making the pivot from the OV2640, the project made a tradeoff between compute and image quality. Lower resolution images from the OV7670 made classifications less optimal than initially expected but allowed the project to move along to further evaluation steps. OV7670 also faced unexpected connectivity issues and would sporadically yield blurry or misaligned images after processing. 

## Requirements for Success
Firmware/low-level software debugging and hardware testing skills are necessary to implement the onboard camera system. Furthermore, the team must have knowledge of image classification models and deployment of these models at the edge to successfully implement the project. Lastly, resources required for this project include Edge Impulse or TF Lite Micro for deploying DNNs, ArduCAM software documentation for camera hardware debugging and Microsoft Azure/AWS resources for storing images with a cloud service.

## Metrics of Success
The overall metrics for project success will be power consumption (mW) which will be calculated given voltage measurements and current measurements in various test cases. As a practical secondary indicator of project viability in real-world applications, the team will translate power consumption to energy savings (mA/hr) which will be beneficial for indicating how these approaches may influence battery-powered systems. Analysis will compare power consumption for communication-free multi-camera set up to the proposed cross-camera communication system built from scratch. 

# 2. Related Work
In recent years, there have been multiple proposals for techniques that can reduce the power consumption of image sensors. In one paper, “CamThings: IoT Camera with Energy-Efficient Communication by Edge Computing based on Deep Learning” researchers found that one way to reduce power consumption is to reduce the frequency of image transmission from the image sensor to the cloud. By utilizing both lower frequency of transmission, as well as using an algorithm to transmit only images of interest, they were able to reduce power consumption of their system by 41% compared to the baseline method.

In the case of using a network of multiple image sensors, another way to reduce power consumption is to prevent transmission of redundant frames that have been captured by multiple devices. In the paper “CONVINCE: Collaborative Cross-Camera Video Analytics at the Edge”, researchers found that if an object of interest has been captured by 4 different image sensors, only one of the sensors needs to send the image to the cloud. If all of the sensors send the image to the cloud, 3 of the transmissions are redundant, and have consumed power unnecessarily. So, they constrained the image transmission to a single camera device. By using these methods, they were able to reduce transmission of images by 75% while retaining high model accuracy.

While the first method proved to be effective in reducing the power consumption of the image sensing device, it only looked at a single device. So, it is possible that power consumption could be further improved. The second method showed that image transmission could be further reduced. However, it did not analyze the improvements in power consumption that could have resulted in the process. By combining these approaches, our project explores a new way to optimize a system for power consumption by using multiple camera perspectives, as well as using machine learning in edge-computing devices.

# 3. Technical Approach
Our approach is to leverage the energy-efficient event camera computing approaches proposed by CONVINCE and CamThings and to create a novel multi-camera with deep learning deployed at the edge. For our technical approach, we aim to decrease power consumption of our event camera system, by introducing delay of image capture as well as an onboard image classification model to identify events of interest. Furthermore, we reduce image transmission by introducing cross-camera communication and knowledge sharing or image inference for both image sensors in our network.

## Hardware Implementation

* Arduino Nano 33 BLE Sense (Memory Constrained, Low Compute Device) x2
* ArduCam OV7670 0.3 MP Camera Module (Low-Quality Image Sensor) x2
* WiFi Connected Device

### ![slide9](https://user-images.githubusercontent.com/6758294/145257958-984c47fc-1409-4245-af2d-39d1b08d2592.PNG)

## Software Implementation 
By order of execution in implementation:
* **BLE 5 Cross-Camera Communication Setup:** Advertising Central and Peripheral devices to establish connection and knowledge sharing via event image characteristics
* **Image Capture and Digital Processing:** Image capture, cropping and resizing are executed once connection is established and generates an 96x96 image buffer to be accepted by MobileNet V1 model.
* **Model Inference:** Image Classification model deployed on Arduino 33 BLE Sense devices generate inferences on input 96x96 preprocessed image buffers and continues with knowledge sharing on established BLE connection
* **Image Transmission:** Labels are compared to reduce transmission of redundant images. Preprocessed images are transmitted to a shared WiFi connected device and redundant images are not sent by both devices. 

## Image Collection and Model Testing

Training datasets used for this project primarily focus on images of human faces as the subject of interest. Only event images of interest are transmitted to the shared WiFi connected device. Faces are the primary focus in terms of the data collected from the dataset rather than full body images of humans in various scenarios. Although this subject of interest could have been made to be more practical, the provided data set achieves its purpose and serves as a baseline for further iterations. Since the primary metric for success of the project is power consumption rather than model accuracy, model performance is presented as means of demonstrating validity and viability of MobileNet V1 deployed on the Arduino Nano 33 BLE Sense in conjunction with BLE connectivity.  

**Databases:** Publicly available, open source image libraries (128x128 resolution)
1. **Flickr-Faces-HQ Dataset:** Contains images of human faces (children, teens , adults of all ethnicities and background) under various lighting conditions
2. **Linnaeus 5 Dataset:** Contains images of various types of dogs, birds, flowers, berries, and other miscellaneous objects under various lighting conditions

### ![slide7ds](https://user-images.githubusercontent.com/6758294/145258243-145ab68a-295d-4de9-9d2a-5a98425728f7.PNG)


**Image Processing:** 128x128 database images were cropped and resized to 96x96 and were also rotated and flipped in random order to improved robustness of MobileNet V1 during test time.

### ![slide7ip](https://user-images.githubusercontent.com/6758294/145258080-6d904dde-617f-4167-b1b5-d10743e7fa46.PNG)

## Model Performance and Training

**MobileNet V1 0.1:** 53.2K RAM and 101K ROM (default settings and optimizations) 
87% accuracy on test set, 20 training cycles, 1,000 human samples, 1,000 unknown → Transfer Learning 

**Model Advantages and Selection Criteria:**
* Speed: inference time < 300 ms on average
* Low Compute: Runs on Arduino Nano 33 BLE Sense with 256KB (nRF52840)
* Compatibility with Arduino Nano: lightweight library for edge device

## Cross-Camera Communication
BLE Central device is programmed to execute an inference on image captured in real-time. The classified label (integer value) is then advertised via a shared event image characteristic which is then read by the peripheral device. This cross-camera communication prevents redundant transmissions to WiFi connected device thus contributing to energy savings.


# 4. Evaluation and Results

## Model Performance Overview
	
The model which was deployed on the 2 Arduino Nano 33 BLE Sense boards was the MobileNet V1 0.1 model which is designed for executing image classification and image processing task for microcontroller architecture with 53.2Kb RAM and 101K RAM. For training setups, the model was given images of faces (babies, teens, adults etc.) from the Flickr Faces HQ database and images of other objects from the Linneas 5 database. The MobileNet V1 TF Lite model performed with 87% accuracy after training on about 1,000 pre-labeled person images and 1,000 pre-labeled unknown objects. The model’s performance was evaluated against a test set of about 200 unknown and person images. Furthermore, upon deployment of the model on the Arduino Nano 33 BLE Sense board, the model was found to successfully make inferences on the Arduino Nano 33 BLE Sense using the OV7670 camera module to capture images. 

Evaluation found that the onboard digital signal processing executed in approximately 0.18 ms when deployed on hardware. Further evaluation found that the model running onboard executed the inference task using the MobileNet V1 TF Lite model in 0.320 ms on average. Given that the MobileNet V1 model performed with 87% accuracy, it is valid for image classification at the edge and was further used in the evaluation of power consumption for the multi-camera system of this project. Despite the lower performance relative to MobileNet V2, the model deployed for this project was necessary to allow memory resources to be reallocated to image transmission and BLE communication tasks in real-time. Sumary of the model performance is as follows: 51 ms inference time, 66.1k Peak RAM, and 107.7K Flash during testing.


## Power Consumption

To measure power consumption, we used the following tools: RIGOL DS1102E oscilloscope, HP974A multimeter, and a TENMA 72-6628 power supply.
The power supply was set to around 7.5V (measured voltage of 7.44V with 120-160 mV peak-to-peak), and was connected to the input voltage pin of the Arduino Nano. The oscilloscope was set to 1V/div and time scale of 1ms/div throughout each of the cases to ensure consistency in measurements. 

![IMG_4076](https://user-images.githubusercontent.com/6758294/145184204-ac397acc-4c08-41bf-a362-8e72bd23cdf2.JPG)

We initially attempted to measure the current by using a small sense resistor and measuring the voltage across the resistor differentially. However, the oscilloscope was not able to provide accurate readings at values on the order of mV, so we decided to use a multimeter instead. Unfortunately, since we were not able to use the scope to measure current, we were not able to obtain graphs of the current over time.

We decided to use an input voltage of 7.5V. This was because we needed to ensure that the input power from the USB would be ignored. The Arduino Nano 33 BLE features a Schottky diode that feeds USB power to the Vin pin of the microcontroller. By introducing a larger voltage supply to the Vin pin, the diode is reverse-biased, and the USB power is essentially ignored by the system. By preventing USB current from entering and exiting the Arduino from the computer, we were able to constrain the current through the device to one path - from the power supply and through our multimeter. Thus, our current measurements using the multimeter were made as accurate as possible, while retaining the ability to read messages from the Arduino via the Serial monitor on the computer.

Because our system was not capable of completing the entire process flow of taking an image, classifying it, communicating with the other device to check for redundant labels, and sending it to the computer, we decided to break up the steps into 4 cases and deduce the power consumption of each stage separately. Then, we could extrapolate our results to infer the power consumption optimizations that would be caused by our system improvements.

The 4 cases are as follows:

**Case 0**: Bare Minimum Arduino Program
* The Arduino was reset using the physical reset button, which represented a totally empty program. Once reset, we measured the current draw of the device, which was around 9 mA. 
* We also tried the “Blink” program, which is provided as an example program from the official Arduino documentation. This program simply blinks an onboard LED on and off at a set interval. With this program, the current draw was 17.38 mA when the LED was off and 19.88 mA when the LED was on. We also tried plugging the Arduino into the computer via USB cable to find the current draw when both the power supply & the computer supply were connected to the device. We found that the current draw was 17.36 mA when the LED was on and 19.83 mA when the LED was off. So, we concluded that the contribution of the USB power source was negligible (<0.1 mA).

**Case 1**: Image Classification Model Program
* The Arduino was loaded with the image classification program from Edge Impulse. The image classification program can be described with the following flow: Take photo, inference (classify) the label, and delay for 2 seconds. By monitoring the multimeter, we found that the current draw for each of these stages was 26.8mA, 27.8mA, and 24.3mA, respectively. The first 2 stages took around 2 seconds combined.
* <img width="960" alt="Screen Shot 2021-12-08 at 1 45 36 AM" src="https://user-images.githubusercontent.com/6758294/145186359-9df3f4b3-ef51-4e6c-ae54-b17110dc3d15.png">
* We also used the “Average” function of the multimeter, which averages the most recent 8 measurements. For further clarification, 2-4 measurements are taken each second by the multimeter. We found that the average current consumption of the device with the image classification program was around 26 mA.
* We took the same current measurements with the USB power not into the Arduino, and found that the average current draw was decreased by around 0.2 mA - again, we considered this amount to be negligible, since it was less than 1% of the average current draw.
    
**Case 2**: Classification + BLE Communication Program
* In this program, the Arduino searches for a peripheral device to connect to over Bluetooth, and only classifies images once it has found and connected to another device. The general flow is as follows: searching for a peripheral device, connect, delay, take photo & inference, disconnect. The cycle then repeats. The instantaneous current draw of the device for each of these stages was 13.3 mA, 10.3 mA, 28-29 mA, 31-32 mA, and 20-21 mA, respectively. 
* <img width="893" alt="Screen Shot 2021-12-08 at 1 44 32 AM" src="https://user-images.githubusercontent.com/6758294/145186452-b0918fc0-9a3f-478f-9728-c5a83dcf814e.png">
* We found the average current of the device in two separate conditions. When the device was not connected, the average current was 13.3 mA. When the device was connected, the average current was 28 mA.

**Case 3**: Images Transmission from Arduino to WiFi Device Program
* In this case, we measured the current consumption of the device when it transmitted the binary data of an image to the computer. We found that the idle, taking photo, and transmitting photo currents were around 25 mA, 29 mA and 27 mA, respectively. 

| Case |         Task         | Min Current | Max Current | Avg. Current | Avg. Power |
|:----:|:--------------------:|:-----------:|:-----------:|:------------:|:----------:|
|   0  |     Bare Minimum     |      -      |      -      |     9 mA     |   67.5 mW  |
|   1  |    Classification    |   24.3 mA   |   27.8 mA   |     26 mA    |   195 mW   |
|   2  | Classification + BLE |    10 mA    |    32 mA    |     28 mA    |   210 mW   |
|   3  |  Image Transmission  |      -      |      -      |     27 mA    |  202.5 mW  |

In all cases, the measured voltage of the Vin pin of the Arduino was found to be 7.44V, with a peak-to-peak voltage of 120-160 mV. 

In summary, we found that the current consumption of the Arduino varied with different loads and different stages in the programs. The highest current was found when the Arduino was executing the Classification + BT program, specifically in the “taking photo” stage at 31-32 mA. 
We also found that the current contamination of the USB connection from the computer was negligible, at less than 1% of the total average current consumption in all cases. 


# 5. Discussion and Conclusions
From the data that we collected, we were able to make some conclusions:
* We found that reducing image transmissions by eliminating redundancies does not reduce power consumption significantly in a 2-camera system.
    * The image transmission portion of the program required around the same amount of current as the image classification portion of the program (27 mA compared to 28 mA). The image taking portion of the program took around 1 s, while the classification portion took around 330 ms. 
    * Practical application:
        * Let’s say the region of overlap in the camera’s perspectives is 50%, and the number of captured frames that have a redundant subject is also 50%. It takes ~ 2 seconds to capture each frame, ~330 ms for classification/inferencing, ~320 ms for image transmission, and then a 2 second delay between each capture in order to lower the capture frequency. Other time durations (such as bluetooth label communication) are negligible. Then, the total time for each frame capture and processing is ~4.65 seconds. Now, we can estimate the energy consumed in a single frame. 
        * Energy consumed = energy(photo) + energy(inference) + energy(transmission) + energy(delay)
        * Energy consumed = 2 seconds * 29 mA + 0.33 seconds * 30 mA + 0.32 seconds * 29 mA + 2 seconds * 26 mA = 129.18 mAh
            * This is using data from Case 2, which had the most consistent readings. We also found from Case 3 that using BLE increased power consumption by about 2 mA, so this was also accounted for in this calculation. 
        * The energy consumed while transmitting an image (29 mA) is only 3 mA more than when the system is in its delay state (26 mA).
        * The image transmission time is 320 ms, so the energy saved is 0.32 s * 3 mA = 0.96 mAh saved per frame.
        * This is 0.96/129.18 = 0.00743, or **0.74% energy conservation**.
* Bluetooth communication increased power consumption slightly.
    * In Case 3, we found that the average power consumption of the device with Bluetooth was increased by around 2 mA compared to the device without Bluetooth. We found that power consumption increased throughout the entire duration of the program uniformly. This is due to the fact that when Bluetooth is used with the central device, it is constantly advertising values of the “eventImageCharacteristic” so that the peripheral device can receive it. For this reason, using Bluetooth increased the power consumption of the device.
* Image classification & image transmission have similar power consumption (27-28 mA)
    * We found that image classification and image transmission had similar amounts of current draw, with only a difference of about 1 mA. In general, most of the operations of the program had current consumption in the high 20s of mA, with the exception of when the device was looking for another device to connect to via Bluetooth, where it only used about 10 mA. Surprisingly, even the delay state of the Arduino consumed current around 26 mA, even while intensive processes were not being executed.
* Taking photos/inferencing results in highest current spike (31-32 mA)
    * Perhaps not surprisingly, the highest current that we measured was during the “taking photos/inferencing” stage in Case 2. It makes sense that the highest power consumption would be during a processor-intensive operation such as taking a photo and classifying the image based on a machine learning model, as there are many calculations to be completed.

## Future Steps
* Develop overlapping field-of-view algorithm
    * Although we did not have time to pursue this idea, it may be an interesting way to further optimize the device for power consumption.
* Optimize compatibility of microcontroller and camera module for image processing and data transmission
    * Perhaps using a different edge-computing device such as the Raspberry Pi instead of the Arduino would be a more effective strategy. Also, it may be possible to find a better camera sensor that is more reliable than the OV2640 or the OV7670.
* Enable finer granularity for on-board image classification (black dog versus white dog)
    * In future projects, higher granularity could be used to further cater towards specific applications, such as a security system.
* Improve latency and throughput by optimizing neural network architecture while maintaining low power consumption
    * Latency and throughput could possibly be improved by utilizing strategies such as image downsampling - by reducing time spent doing power-expensive operations such as image transmitting and classifications, power consumption could be further improved.
* Analyze power consumption with portable power supply (battery) in real-life case study
    * It would be interesting to see how these techniques of frequency reduction and redundant frame transmission canceling would perform in a real-life embedded system such as a security camera system running on batteries.


# 6. References
1. H. B. Pasandi and T. Nadeem, "CONVINCE: Collaborative Cross-Camera Video Analytics at the Edge," 2020 IEEE International Conference on Pervasive Computing and Communications Workshops (PerCom Workshops), 2020, pp. 1-5. 
 [_https://ieeexplore.ieee.org/document/9156251_](https://ieeexplore.ieee.org/document/9156251)
2. J. Lim, J. Seo and Y. Baek, "CamThings: IoT Camera with Energy-Efficient Communication by Edge Computing based on Deep Learning," 2018 28th International Telecommunication Networks and Applications Conference (ITNAC), 2018, pp. 1-6. 
[_https://ieeexplore.ieee.org/document/8615368_](https://ieeexplore.ieee.org/document/8615368)
3. Zicheng Chi, Yan Li, Xin Liu, Yao Yao, Yanchao Zhang, and Ting Zhu. 2019. Parallel inclusive communication for connecting heterogeneous IoT devices at the edge. In Proceedings of the 17th Conference on Embedded Networked Sensor Systems (SenSys '19). Association for Computing Machinery, New York, NY, USA, 205–218. 
[_https://doi.org/10.1145/3356250.3360046_](https://doi.org/10.1145/3356250.3360046)
4. Linnaeus 5 Dataset: [_http://chaladze.com/l5/_](http://chaladze.com/l5/)
5. Flickr Faces HQ Dataset (FFHQ): [_https://github.com/NVlabs/ffhq-dataset_](https://github.com/NVlabs/ffhq-dataset)
6. Arduino IDE: [_https://www.arduino.cc/en/software_](https://www.arduino.cc/en/software)
7. Edge Impulse CLI: [_https://docs.edgeimpulse.com/docs/cli-installation_](https://docs.edgeimpulse.com/docs/cli-installation)
8. ArduCAM Repository: [_https://github.com/ArduCAM/Arduino_](https://github.com/ArduCAM/Arduino)
