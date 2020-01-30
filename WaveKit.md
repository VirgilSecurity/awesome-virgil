## Introduction

As more technology enters the roadways, the advent of wireless communication between a vehicle's onboard equipment, user devices, and roadside units (RSU), such as traffic lights, lane markings, and other vehicles is increasing. At the same time, data protection and privacy of all participants is vitally important. To accomplish both goals simultaneously, it's necessary to have a system that validates, coordinates and secures communication.

In this tutorial, we will help you add a security level to vehicle-to-everything (V2X) communication in onboard (OBU) and RSU units using Virgil WaveKit framework and Virgil Security Credential Management System (SCMS).

<Collapse title="### Click here to read more about what Virgil provides">

Virgil Security provides a developer-convenient complete IEEE 1609.2 security integration for protecting vehicle-to-everything (V2X) communication.

### We Offer

- **Virgil SCMS**. Virgil SCMS is a global, flexible, verifiable and standard-compliant Security Credential Management System designed to fully manage vehicle-to-everything (V2X) secure communication in vehicles (OBU) and roadside units (RSU).
A full range of Virgil SCMS services gives developers the freedom to run production systems, smart city pilots, or technology trials using industry-standard interfaces. The Virgil SCMS has also been architected in a way to allow certain components to be easily deployed in customer premise environments.

- **Virgil WaveKit**. Virgil WaveKit is an easy-to-use client-side framework that provides developers with full security functionality to implement and manage secure V2X communication according to the architecture and operations of a WAVE system based on IEEE 1609 family standards.
WaveKit interacts with the Virgil SCMS and helps automotive OEMs, Tier-1 suppliers, roadside unit manufacturers, and application developers to test, develop and release standard-compliant V2X security solutions.

### Your Benefits
- Easy-to-use WaveKit framework to enroll, register and manage the security services for V2X communications in OBU and RSU
- A global, flexible and verifiable security platform has been architected to allow certain components to be deployed in customer premise environments
- A complete, standard-compliant credential management platform for V2X applications that includes the following services: Enrollment Certificate Authority (ECA), Registration Authority (RA), Pseudonym Certificate Authority (PCA), Linkage Authority (LA), CRL Manager, Policy Generator
- Simple SCMS provides freedom and flexibility for easy-to-run production systems, smart city pilots or technology trials using 1609.2 industry-standard interfaces
- Virgil V2X Simulator gives you the ability to emulate V2X communication and units, as well as toolkits to interact with the SCMS to easily test, develop and release security V2X solutions
- Dedicated customer support and guaranteed SLA
- Convenient Web UI and CLI for SCMS and security management infrastructure
- Ability to integrate with any radio modules, including 5G, for IEEE 1609
- Simulators for debugging, provisioning and configuring OBUs and RSUs
- Ability to run any application process locally for security processing
- Step-by-step V2X Demo App that helps you easily understand and integrate 1609.2 security services into your WAVE application

</Collapse>

## Prepare Environment

To make the development process convenient and quick, Virgil provides development tools that gives you the ability to emulate V2X communication and units, as well as toolkits to interact with the Virgil SCMS to easily test, develop and release standard-compliant V2X security solutions

Follow the steps below to prepare your environment and start development.

### Prerequisites

Before you start, you need to install the following:
- **Virgil CLI** is a unified tool to manage your Virgil Cloud services and perform all required commands to configure the SCMS services. Follow this guide to [install the Virgil CLI](https://developer.virgilsecurity.com/docs/sdk-and-tools/virgil-cli/install) on your platform.
- **Docker** is a tool designed to make it easier to create, deploy, and run applications by using containers. Follow this guide to [install the Docker](https://docs.docker.com/install/) for your platform.

### Step 1. Register Virgil Account
Once the CLI is installed, you need to create a Virgil account using the following CLI command:
```bash
$ virgil register <Your Email>
```
If you already have a Virgil account, use the command below to log in:
```bash
$ virgil login <Your Email>
```
Follow the instruction guidelines in the terminal to finish this step.

### Step 2. Create Virgil App and enable the SCMS
Сreate a Virgil application and initialize the Virgil SCMS services in the application:
```bash
# create new Virgil application and get the App ID in stdout.
$ virgil app create <App Name>

# initialize the Virgil SCMS services using the App ID from the application you previously created.
$ virgil scms init --app-id <App ID>
```

### Step 3. Get App Token
To start sending authentication requests to the Virgil SCMS services, you will need to create a long-term token.
```bash
# use the same App ID you used to initialize the Virgil SCMS services.
$ virgil app token create --app-id <App ID> --name <App Name>
```
<Warning> Store the App Token in a secure place and use it to initialize the V2X Communication Simulator.</Warning>


Here is a step-by-step gif to visually explain the first 3 steps listed above:

![screenshot1](/img/virgil_cli.gif "virgil CLI")

### Step 4. Download V2X Dev Tools

Virgil V2X Dev Tools is a set of scripts and utilities for testing and integrating security services into a WAVE application. The latest version of the Dev Tools package can be downloaded [here](https://bintray.com/virgilsecurity/1609-demo-cdn/download_file?file_path=v2x-security-dev-tools-0.1.0.99.zip).

The Dev Tools package contains the following components:
- scripts for running the Virgil V2X simulator on any platform
- development packages for Linux distributions
- code samples that illustrate the usage of SCMS API and container

## Run the V2X Demo App
In this section, we will help you to run the Virgil V2X Communication Simulator to go through the Demo App. The Demo will guide you through the V2X communication process using emulated devices for illustrating how to initialize onboard (OBU) and roadside (RSU) units, register them in the Virgil SCMS and perform secure communication between units using the dedicated short range communication (DSRC), such a Radio or 5G.

Navigate to your CLI terminal and run the V2X Communication Simulator using the run-simulator script placed in the downloaded Dev Tools package on the step 4, and then specify your `App Token` obtained in the previous step.

Use the command below to run the V2X Communication Simulator:

```bash
# for NIX systems: macOS, Linux
./run-simulator.sh

# for Windows
./run-simulator.bat
```

And finally, choose the appropriate option in your terminal to run the V2X Demo.

#### Run Demo Logs Terminal
To make the whole process clear, run the demo's logs terminal in any browser via the http://localhost:8080/.


## What Demo Illustrates

The V2X Demo illustrates 4 steps that need to be performed by developers in order to start working with V2X secure communication:

**Step 1. Bootstrapping a Device Configuration Manager (DCM)**. At this step, the Demo initializes the DCM, generates public/private key pair for the DCM, creates DCM certificate and registers it in the Virgil SCMS. Then, the DCM gets SCMS certificate chain necessary for OBU and RSU provision. As a result, Demo starts the DCM local service.                                    

**Step 2. Provisioning simulators**. The Demo creates the required files for device simulation, generates the key pair for RSU and OBU, then registers their certificates in Virgil SCMS, and finally, the Demo confirms that the simulated units (RSU and OBU) are properly configured.

**Step 3. Starting up simulation environment**. At this step, you run the configured devices, such as Dedicated Short Range Communication (DRSC) simulator or OBU and RSU simulators, to start broadcasting messages.

**Step 4. Emulating secure communication.** At this step, units devices sends secured messages to each other. The OBU broadcasts a message signed with its private key, then the RSU verifies that signature using the OBU's certificate, and vice versa.



## Start Development
This section will help you to start working on your own V2X project using Virgil CSMS and Virgil development tools package (Dev Tools).

### Prerequisites
- Supported platforms: Fedora 29, Fedora 30, CentOS 7, Ubuntu 14, Ubuntu 18, Ubuntu 19, Raspbian 9, Raspbian 10
- Virgil V2X Simulator should be launched
- Platform-specific development tools like a make, gcc etc. should be installed

To start developing your application follow these steps:
- Open a new terminal window
- Navigate to the downloaded Virgil Dev Tools folder
- Install the preferred development package for the Security Processor communication from the packages folder

```bash
# here is an example for the Ubuntu 18 platform:
$ cd v2x-security-dev-tools-0.1.0.99/packages/Ubuntu_18/
$ sudo apt install ./1609-dev-api_0.1.0-64_amd64.deb
```
- Navigate to the examples/wave-app-simple-example folder and explore the main-demo-app.c file that contains all client-side functions for communicating with the Virgil SCMS.
- Then, compile a project from source code.

```bash
# here is an example for the Ubuntu 18 platform:
$ cd v2x-security-dev-tools-0.1.0.99/examples/wave-app-simple-example
$ make
```

- Now, you can run the wave-app-simple-example file and explore secure communication.

```bash
# here is an example for the Ubuntu 18 platform:
$ ./wave-app-simple-example
```
