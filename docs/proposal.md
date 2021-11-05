# Project Proposal

## 1. Motivation & Objective

What are you trying to do and why? (plain English without jargon)

## 2. State of the Art & Its Limitations

How is it done today, and what are the limits of current practice?

## 3. Novelty & Rationale

What is new in your approach and why do you think it will be successful?

## 4. Potential Impact

If the project is successful, what difference will it make, both technically and broadly?

## 5. Challenges

What are the challenges and risks?

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
