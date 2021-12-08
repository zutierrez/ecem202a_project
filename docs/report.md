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

This section should cover the following items:

* Motivation & Objective: What are you trying to do and why? (plain English without jargon)
* State of the Art & Its Limitations: How is it done today, and what are the limits of current practice?
* Novelty & Rationale: What is new in your approach and why do you think it will be successful?
* Potential Impact: If the project is successful, what difference will it make, both technically and broadly?
* Challenges: What are the challenges and risks?
* Requirements for Success: What skills and resources are necessary to perform the project?
* Metrics of Success: What are metrics by which you would check for success?

# 2. Related Work
In recent years, there have been multiple proposals for techniques that can reduce the power consumption of image sensors. In one paper, “CamThings: IoT Camera with Energy-Efficient Communication by Edge Computing based on Deep Learning” researchers found that one way to reduce power consumption is to reduce the frequency of image transmission from the image sensor to the cloud. By utilizing both lower frequency of transmission, as well as using an algorithm to transmit only images of interest, they were able to reduce power consumption of their system by 41% compared to the baseline method.

In the case of using a network of multiple image sensors, another way to reduce power consumption is to prevent transmission of redundant frames that have been captured by multiple devices. In the paper “CONVINCE: Collaborative Cross-Camera Video Analytics at the Edge”, researchers found that if an object of interest has been captured by 4 different image sensors, only one of the sensors needs to send the image to the cloud. If all of the sensors send the image to the cloud, 3 of the transmissions are redundant, and have consumed power unnecessarily. So, they constrained the image transmission to a single camera device. By using these methods, they were able to reduce transmission of images by 75% while retaining high model accuracy.

While the first method proved to be effective in reducing the power consumption of the image sensing device, it only looked at a single device. So, it is possible that power consumption could be further improved. The second method showed that image transmission could be further reduced. However, it did not analyze the improvements in power consumption that could have resulted in the process. By combining these approaches, our project explores a new way to optimize a system for power consumption by using multiple camera perspectives, as well as using machine learning in edge-computing devices.

# 3. Technical Approach

# 4. Evaluation and Results
Power consumption:
To measure power consumption, we used the following tools: RIGOL DS1102E oscilloscope, HP974A multimeter, and a TENMA 72-6628 power supply.
The power supply was set to around 7.5V (measured voltage of 7.44V with 120-160 mV peak-to-peak), and was connected to the input voltage pin of the Arduino Nano. The oscilloscope was set to 1V/div and time scale of 1ms/div throughout each of the cases to ensure consistency in measurements. 
![IMG_4076](https://user-images.githubusercontent.com/6758294/145184204-ac397acc-4c08-41bf-a362-8e72bd23cdf2.JPG)
![IMG_4075](https://user-images.githubusercontent.com/6758294/145184276-ef65f2e1-970c-4f89-8a42-0624cb7f0f15.JPG)
![IMG_4077](https://user-images.githubusercontent.com/6758294/145184290-3a334aa5-43e1-46ce-b60a-60e217f452bc.JPG)

We initially attempted to measure the current by using a small sense resistor and measuring the voltage across the resistor differentially. However, the oscilloscope was not able to provide accurate readings at values on the order of mV, so we decided to use a multimeter instead. Unfortunately, since we were not able to use the scope to measure current, we were not able to obtain graphs of the current over time.

We decided to use an input voltage of 7.5V. This was because we needed to ensure that the input power from the USB would be ignored. The Arduino Nano 33 BLE features a Schottky diode that feeds USB power to the Vin pin of the microcontroller. By introducing a larger voltage supply to the Vin pin, the diode is reverse-biased, and the USB power is essentially ignored by the system. By preventing USB current from entering and exiting the Arduino from the computer, we were able to constrain the current through the device to one path - from the power supply and through our multimeter. Thus, our current measurements using the multimeter were made as accurate as possible, while retaining the ability to read messages from the Arduino via the Serial monitor on the computer.

Because our system was not capable of completing the entire process flow of taking an image, classifying it, communicating with the other device to check for redundant labels, and sending it to the computer, we decided to break up the steps into 4 cases and deduce the power consumption of each stage separately. Then, we could extrapolate our results to infer the power consumption optimizations that would be caused by our system improvements.

The 4 cases were as follows:
* **Case 0**: Empty Arduino program:
    * The Arduino was reset using the physical reset button, which represented a totally empty program. Once reset, we measured the current draw of the device, which was around 9 mA. 
    * We also tried the “Blink” program, which is provided as an example program from the official Arduino documentation. This program simply blinks an onboard LED on and off at a set interval. With this program, the current draw was 17.38 mA when the LED was off and 19.88 mA when the LED was on. We also tried plugging the Arduino into the computer via USB cable to find the current draw when both the power supply & the computer supply were connected to the device. We found that the current draw was 17.36 mA when the LED was on and 19.83 mA when the LED was off. So, we concluded that the contribution of the USB power source was negligible (<0.1 mA).
* **Case 1**: Image Classification program
    * The Arduino was loaded with the image classification program from Edge Impulse. The image classification program can be described with the following flow: Take photo, inference (classify) the label, and delay for 2 seconds. By monitoring the multimeter, we found that the current draw for each of these stages was 26.8mA, 27.8mA, and 24.3mA, respectively. The first 2 stages took around 2 seconds combined.
    * We also used the “Average” function of the multimeter, which averages the most recent 8 measurements. For further clarification, 2-4 measurements are taken each second by the multimeter. We found that the average current consumption of the device with the image classification program was around 26 mA.
    * ![case1](https://user-images.githubusercontent.com/6758294/145184659-5b664ed7-b694-432c-b99d-f300ec5a5615.png)

    * We took the same current measurements with the USB power not into the Arduino, and found that the average current draw was decreased by around 0.2 mA - again, we considered this amount to be negligible, since it was less than 1% of the average current draw.
* **Case 2**: Classification + Bluetooth communication
    * In this program, the Arduino searches for a peripheral device to connect to over Bluetooth, and only classifies images once it has found and connected to another device. The general flow is as follows: searching for a peripheral device, connect, delay, take photo & inference, disconnect. The cycle then repeats. The instantaneous current draw of the device for each of these stages was 13.3 mA, 10.3 mA, 28-29 mA, 31-32 mA, and 20-21 mA, respectively. 
    * ![case2](https://user-images.githubusercontent.com/6758294/145184682-4be1cba1-5a38-4f54-ba98-73b568e3679d.png)
    * We found the average current of the device in two separate conditions. When the device was not connected, the average current was 13.3 mA. When the device was connected, the average current was 28 mA.

* **Case 3**: Image Transmission
    * In this case, we measured the current consumption of the device when it transmitted the binary data of an image to the computer. We found that the idle, taking photo, and transmitting photo currents were around 25 mA, 29 mA and 27 mA, respectively. 


| Case | Task                 | Average Current | Min Current | Max Current |
|------|----------------------|-----------------|-------------|-------------|
| 0    |     Bare Minimum     |       9 mA      |     N/A     |     N/A     |
| 1    |    Classification    |      26 mA      |   24.3 mA   |   27.8 mA   |
| 2    | Classification + BLE |      28 mA      |    10 mA    |    32 mA    |
| 3    |  Image Transmission  |      27 mA      |     N/A     |     N/A     |


* In all cases, the measured voltage of the Vin pin of the Arduino was found to be 7.44V, with a peak-to-peak voltage of 120-160 mV. 
* In summary, we found that the current consumption of the Arduino varied with different loads and different stages in the programs. The highest current was found when the Arduino was executing the Classification + BT program, specifically in the “taking photo” stage at 31-32 mA. 
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

Challenges:
* Limitations of Arduino Nano
    * Low memory - we had to use an extremely lightweight version of the machine learning model. This may have caused some erratic behavior during execution of the program, such as random disconnections between the two Arduino devices.
    * Low processing power - along with classification speed, the device was slow to take photos and transmit them to the computer.
Compiling speed - since we had large file uploads, each compile took several minutes, sometimes requiring restarting the Arduino client.
* Limitations of camera sensors
    * Poor support - we initially used the OV2640 camera sensor, which had a reasonable resolution. However, we found that there was limited support for this camera sensor in conjunction with the Arduino Nano 33 BLE. Most of the time, the Arduino would struggle to transmit an image to a computer connected serially through USB. The transmission rate was inconsistent, and quite slow in general (around 1 image every 3-4 seconds). We suspected that it might be an issue with wiring and loose connections, but even after soldering the pins to the Arduino, the issues remained.
        * We eventually pivoted to using the OV7670 camera sensor. Although this sensor performed slightly better than the OV 2640 sensor, it was still unreliable. Often, after a few rounds of good images, the camera would begin to send corrupted photos, either with misaligned pixels, or sometimes completely unrecognizable photos. Other times, the photos would be too blurry to make out any objects. 
        * ![jumbledphoto](https://user-images.githubusercontent.com/6758294/145184748-f512fc88-373e-4f3c-923e-f81790f7df4a.png)


* Bluetooth issues
    * Unprompted disconnection - We were able to connect the Arduinos to each other via Bluetooth, but they often would disconnect for no apparent reason.
    * Low throughput - with BLE 5, we were not able to send full image data in one transmission, which meant the image had to be split up into packets. Because of this, we ultimately made the decision to pivot from using a Raspberry Pi as the designated WiFi device to upload to the cloud to connecting the Arduinos to a computer via USB connection. We attempted to concatenate the binary bytes into a single file and convert the resulting binary file into a recognizable image, but the image was still too noisy to be able to make out any objects. 

Future plans:
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
