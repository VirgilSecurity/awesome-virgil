<a href="https://virgilsecurity.com"><img src="images/VirgilLogo.png"></a>

[Virgil Security](https://virgilsecurity.com) is a stack of security libraries and all the necessary infrastructure to enable seamless, end-to-end encryption for any application, platform or device.

Our libraries allow developers to get up and running with Virgil API quickly and add full end-to-end security to their existing digital solutions to become HIPAA and GDPR compliant and more.

Virgil Security, Inc. guides software developers into the forthcoming security world in which everything will be encrypted (and passwords will be eliminated). In this world, the days of developers having to raise millions of dollars to build secure chat, secure email, secure file-sharing, or a secure anything have come to an end. Now developers can instead focus on building features that give them a competitive market advantage while end-users can enjoy the privacy and security they increasingly demand.

# Content
- [Community](#community)
- [Products](#products)
  - [Tools](#tools)
  - [Secure Communications Platform (coming)](#secure-communications-platform-coming)
  - [Security Frameworks](#security-frameworks)
  - [Core SDK](#core-sdk)
  - [Services](#services)
  - [Cryptographic Libraries](#cryptographic-libraries)

- [E3Kit](#E3Kit)
  - [With any platform](#with-any-platform)
  - [With Firebase](#with-firebase)
  - [With Twilio](#with-twilio)
  - [With PubNub](#with-pubnub)
  - [With Nexmo](#with-nexmo)
- [PureKit](#PureKit)
  - [With any backend language](#with-any-backend-language)
  - [With MariaDB](with-mariadb)
  - [With WordPress](#with-wordpress)
- [IoTKit](#iotkit)
- [WaveKit](#wavekit)
- [Production Applications](#production-applications)
- [Blog Posts](#blog-posts)
- [Videos](#videos)
- [HashTags](#hashtags)
- [License](#license)
- [Contacts](#contacts)

# Community
### Web resources
* [Main Website](https://VirgilSecurity.com)
* [Developer Documentation](https://developer.virgilsecurity.com/docs)
* [Virgil Developer Dashboard](https://dashboard.VirgilSecurity.com)
* [Help Center](https://help.VirgilSecurity.com)

### Social media
* [Facebook](https://www.facebook.com/VirgilSec)
* [Twitter](https://twitter.com/VirgilSecurity)
* [LinkedIn](https://www.linkedin.com/company/virgil-security-inc-/)
* [DOU](https://jobs.dou.ua/companies/virgil-security-inc/)

### Blogs
* [Medium Blog](https://medium.com/@VirgilSecurity)
* [Habr](https://habr.com/company/VirgilSecurity)

### Support
* [Slack](https://VirgilSecurity.slack.com/)
* [Email](mailto:support@VirgilSecurity.com)


# Products

### Tools
* [Virgil CLI](https://github.com/VirgilSecurity/virgil-cli) - a tool to manage your Virgil account and applications, and perform cryptographic operations.
* [IoT Dev Tools](https://github.com/VirgilSecurity/virgil-iotkit#iot-dev-tools). Virgil Security also provides a set of tools for secure device lifecycle:
  - **Virgil Trust Provisioner**. The Virgil Trust Provisioner is a CLI used to manage your distributed trust between all parties, including IoT devices, in your IoT solutions. The CLI is aimed at key pairs and TrustList generation and management, which together make each IoT device identifiable, verifiable and trusted by each party of IoT solution. To start working with the tool, read more [here](https://github.com/VirgilSecurity/virgil-iotkit/tree/master/tools/virgil-trust-provisioner).
  - **Virgil Device Initializer**. In order to make each IoT device identifiable, verifiable and trusted by each party of IoT solution, you have to provide it with specific provision files, generate private keys and create the digital cards for further device registration on the Virgil Cloud. Virgil Device Initializer allows you to make IoT device provisioning and prepare your IoT device (create digital cards) for its further registration on the Virgil Cloud. To start working with the tool, read more [here](https://github.com/VirgilSecurity/virgil-iotkit/tree/master/tools/virgil-device-initializer).
  - **Virgil Device Registrar**. Virgil IoT Device Registrar is used to register IoT devices and their digital cards with the Virgil Security Cloud. To start working with the tool, read more [here](https://github.com/VirgilSecurity/virgil-iotkit/tree/master/tools/virgil-device-registrar).
  - **Virgil Firmware Signer**. Virgil Firmware Signer is a CLI that allows you to sign firmware in order to provide integrity before distributing it. To start working with the tool, read more [here](https://github.com/VirgilSecurity/virgil-iotkit/tree/master/tools/virgil-firmware-signer).
  - **Virgil SnapD**. Virgil SnapD is a local web utility which allows you to obtain information and statistics about your IoT devices. In order to get such device information, SnapD interacts with Virgil SNAP protocol, which operates directly with your IoT devices. As far as Virgil SnapD is a local service, the obtained information can be displayed in browser under http://localhost:8080/ (by default). If you're working with the Virgil IoT Simulator, you can run SnapD under http://localhost:8081/. To start working with the tool, read more [here](https://github.com/VirgilSecurity/virgil-iotkit/tree/master/tools/virgil-snapd).


### Secure Communications Platform (coming)

* **[Secure Communications Platform](https://virgilsecurity.com/secure-communications-platform/)** - Virgil Security introduces the most secure programmable communications platform that allows protecting your company communications, intellectual property and privacy. Now, you can build your own communication applications with secure voice & video calls and other communications features faster, secure and cheaper. 

### Security Frameworks 

* **[E3Kit](https://virgilsecurity.com/e3kit/)** -  an open-source client-side framework that allows developers to add end-to-end encryption to their messaging applications, file sharing programs, and other digital communication products in just a few simple steps to become HIPAA and GDPR compliant and more. E3Kit interacts with Cards Service, Keyknox Service and Pythia Service and supports multi-device access and group chat features.
  * [JavaScript/TypeScript](https://github.com/VirgilSecurity/virgil-e3kit-js)
  * [Swift](https://github.com/VirgilSecurity/virgil-e3kit-x)
  * [Java/Kotlin](https://github.com/VirgilSecurity/virgil-e3kit-kotlin)

* **[PureKit](https://virgilsecurity.com/purekit/)** - an open-source security framework for enabling post-compromise protection for stored data. PureKit allows developers to protect users' passwords and personal data from hacking and securely share data. The framework can be used within any database or login system that uses a password, so it’s applicable for a company of any industry or size.
  * [PHP](https://github.com/VirgilSecurity/virgil-purekit-php)
  * [C#.NET](https://github.com/VirgilSecurity/virgil-purekit-net)
  * [Golang](https://github.com/VirgilSecurity/virgil-purekit-go)
  * [Java/Kotlin](https://github.com/VirgilSecurity/virgil-purekit-kotlin)

* **IoTKit** - A framework for connecting IoT devices to Virgil IoT Security PaaS. IoTKit helps you easily add security to your IoT devices at any lifecycle stage for secure provisioning and authenticating devices, secure updating firmware and trustlists, and for secure exchanging messages using any transport protocols.
  * [C](https://github.com/VirgilSecurity/virgil-iotkit/)

### Core SDK

* **Cards Service SDK** - interacts with Virgil Cards Service and allows developers to add end-to-end encryption (E2EE) security to their new and existing digital products. SDK can be used on both client-side and server-side.
  * [JavaScript/TypeScript](https://github.com/VirgilSecurity/virgil-sdk-javascript)  
  * [C#/.NET](https://github.com/VirgilSecurity/virgil-sdk-net)
  * [C++](https://github.com/VirgilSecurity/virgil-sdk-cpp)
  * [Swift/Objective-C](https://github.com/VirgilSecurity/virgil-sdk-x)
  * [PHP](https://github.com/VirgilSecurity/virgil-sdk-php)
  * [Java/Android](https://github.com/VirgilSecurity/virgil-sdk-java-android)
  * [Python](https://github.com/VirgilSecurity/virgil-sdk-python)
  * [Golang](https://github.com/VirgilSecurity/virgil-sdk-go)
  * [Ruby](https://github.com/VirgilSecurity/virgil-sdk-ruby)

* **Pythia Service SDK** - allows developers to communicate with Virgil Pythia Service to generate a Brainkey (private Key that is based on a password) and protect user passwords in a database.
  * [Golang](https://github.com/VirgilSecurity/virgil-pythia-go)
  * [Node.js](https://github.com/VirgilSecurity/virgil-pythia-node)
  * [Swift](https://github.com/VirgilSecurity/virgil-pythia-x)
  * [C#/.NET](https://github.com/VirgilSecurity/pythia-net)
  * [Java/Kotlin](https://github.com/VirgilSecurity/virgil-pythia-java)

* **Keyknox Service SDK** - allows developers to communicate with the Virgil Keyknox Service to upload, download, and synchronize encrypted sensitive data (private keys) between user's devices.
  * [Java/Kotlin](https://github.com/VirgilSecurity/virgil-keyknox-kotlin)
  * [Swift](https://github.com/VirgilSecurity/virgil-keyknox-x)
  * [JavaScript/TypeScript](https://github.com/VirgilSecurity/virgil-keyknox-javascript)

### Services

* [Cards Service](https://developer.virgilsecurity.com/docs/platform/api-reference/cards-service/) - Stores and manages users' Virgil Cards with Public Keys and associated information.
* [Pythia Service](https://developer.virgilsecurity.com/docs/platform/api-reference/pythia-service/) - Provides developers with an ability to generate a user's restorable keypair based on a password.
* [Keyknox Service](https://developer.virgilsecurity.com/docs/platform/api-reference/keyknox-service/) - Allows developers to securely store private keys and secrets in the Virgil Cloud and share them between their devices.

### Cryptographic Libraries

[Virgil Crypto](https://github.com/VirgilSecurity/virgil-crypto) is an open-source high-level cryptographic library that allows you to perform all necessary operations for secure storing and transferring data in your digital solutions. Crypto Library is written in C++, suitable for mobile and server platforms and supports bindings with the following programming languages: Swift, Obj-C, Java (Android), С#/.NET, JS, Python, Ruby, PHP, Go.

* **Wrappers**
  * [JavaScript/TypeScript](https://github.com/VirgilSecurity/virgil-crypto-javascript)
  * [PHP](https://github.com/VirgilSecurity/virgil-crypto-php)
  * [C#/.NET](https://github.com/VirgilSecurity/virgil-crypto-net)
  * [Ruby](https://github.com/VirgilSecurity/virgil-crypto-ruby)
  * [C](https://github.com/VirgilSecurity/virgil-crypto-c)
  * [Python](https://github.com/VirgilSecurity/virgil-crypto-python)
  * [Golang](https://github.com/VirgilSecurity/virgil-crypto-go)
  * [Java/Kotlin](https://github.com/VirgilSecurity/virgil-crypto-kotlin)
  * [Swift](https://github.com/VirgilSecurity/virgil-crypto-x)
  

# E3Kit

### With any platform

* [Add end-to-end encryption to your application to secure communication](https://developer.virgilsecurity.com/docs/e3kit/get-started/quickstart/) - In this tutorial, we will help you add end-to-end encryption to your product to secure your messages and user data.
* Demo backends:
  * [NodeJS](https://github.com/VirgilSecurity/sample-backend-nodejs)
  * [Java](https://github.com/VirgilSecurity/sample-backend-java)
  * [Python](https://github.com/VirgilSecurity/virgil-sdk-python/tree/master#sample-backend-for-jwt-generation)
  * [PHP](https://github.com/VirgilSecurity/sample-backend-php)
  * [Golang](https://github.com/VirgilSecurity/sample-backend-go)
  * [Other Languages](https://developer.virgilsecurity.com/docs/e3kit/get-started/generate-client-tokens/)
* Demo applications:
  * [Demo iOS](https://github.com/VirgilSecurity/virgil-e3kit-x)
  * [Demo Web](https://github.com/VirgilSecurity/demo-e3kit-web)

### With Firebase

* [Add end-to-end encryption to your Firebase application](https://developer.virgilsecurity.com/docs/e3kit/integrations/firebase/) - In this tutorial, we will help you add end-to-end encryption to your Firebase application to secure your messages and user data.
* [Demo Web](https://github.com/VirgilSecurity/demo-firebase-js) - A simple Web application that demonstrates how the end-to-end encryption works. The application uses Firebase as a backend service for authentication and chat messaging.
* [Virgil Cloud Function for Firebase](https://github.com/VirgilSecurity/virgil-e3kit-firebase-func) use Firebase as a backend service for authentication and chat messaging and Virgil E3kit.

### With Twilio

* [Add end-to-end encryption to your Twilio Programmable Chat](https://developer.virgilsecurity.com/docs/e3kit/integrations/twilio/) - In this tutorial, we will help you add end-to-end encryption to your product to secure your messages and user data that you deliver using Twilio Programmable Chat.
* [Demo iOS](https://github.com/VirgilSecurity/demo-e3kit-ios-twilio) - A simple iOS application that demonstrates how the end-to-end encryption works with Twilio.
* [Twilio Sample Backend for Node.js](https://github.com/VirgilSecurity/twilio-sample-backend-nodejs) - A sample backend that demonstrates how to generate a Virgil JWT and Twilio token used for authentication with the Virgil and Twilio services

### With Pubnub

* [Add end-to-end encryption to your PubNub Chat](https://developer.virgilsecurity.com/docs/e3kit/integrations/pubnub/) - In this tutorial, we will help you add end-to-end encryption to your product to secure your messages and user data that you deliver using PubNub Chat.

### With Nexmo

* [Demo E3Kit Android chat](https://github.com/VirgilSecurity/demo-nexmo-chat-e3kit-android) - Demo Android chat that uses Virgil E3Kit and Nexmo.
* [Demo Java/Android backend](https://github.com/VirgilSecurity/demo-nexmo-chat-backend-java) - This repository contains a sample backend code that demonstrates how to generate a Nexmo and Virgil JWTs using the Java/Android SDK.

# PureKit

### With any backend language

* [Protect user passwords and data in your database from data breaches](https://developer.virgilsecurity.com/docs/purekit/get-started/) - In this tutorial, we will help you to set up PureKit on your backend to secure data and passwords in your database.

### With MariaDB

* [Virgil PureKit MariaDB Demo](https://github.com/VirgilSecurity/virgil-mariadb-demo) - The Demo App is a simple web application that illustrates how Virgil PureKit can be used with MariaDB to store and share data in the most secure way. The Demo App is based on use case involving a hypothetical business scenario involving a patient, physician and laboratory, and shows how distinct roles within a customer's application can be defined and used to restrict ePHI access in a HIPAA-compliant manner.

### With WordPress

* [Virgil Pure Wordpress Plugin](https://github.com/VirgilSecurity/virgil-pure-wordpress) - Free Wordpress Plugin based on a powerful and revolutionary cryptographic technology that protects user passwords from data breaches and both online and offline attacks.

# IoTKit

* [Virgil IoTKit Sandbox](https://github.com/VirgilSecurity/virgil-iotkit/tree/master/scripts) - A demo IoT sandbox is based on Virgil IoTKit and its dev tools. It allows you to emulate IoT devices, manage Firmware, TrustList and see the security for IoT devices in action. The Sandbox is conditionally divided into 3 actors (Vendor, Factory, and End-User) to easily understand the whole development process.
* [IoTKit Demo Samples for UNIX-like OS](https://github.com/VirgilSecurity/demo-iotkit-nix) - The demo samples contain key elements that are necessary for implementation of the secure IoT lifecycle, and tests for all the provided features.

# WaveKit

* [Virgil WaveKit](/WaveKit.md) - an easy-to-use client-side framework that provides developers with full security functionality to implement and manage secure V2X communication according to the architecture and operations of a WAVE system based on IEEE 1609 family standards.

# Production Applications

* **Virgil Messenger** - End-to-end encrypted messenger with passwordless authentication. Perfect solution for those who care about their privacy.
  * [Virgil Messenger iOS](https://itunes.apple.com/us/app/virgil-messenger/id1374223472)
    * [Source code](https://github.com/VirgilSecurity/chat-twilio-ios/)
  * [Virgil Messenger Android](https://play.google.com/store/apps/details?id=com.virgilsecurity.android.virgilmessenger)
    * [Source code](https://github.com/VirgilSecurity/demo-twilio-chat-android/tree/extended_e2ee)

# Blog Posts

* TechCrunch: [Adding end-to-end encrypted messaging to your app just got a lot easier](https://techcrunch.com/2016/05/03/adding-end-to-end-encrypted-messaging-to-your-app-just-got-a-lot-easier/)
* eWeek: [Virgil Security Raises $4M for Application Security](https://www.eweek.com/security/virgil-security-raises-4m-for-application-security)
* Atomicorp: [Adding Elliptic Curve Noise Socket Crypto to Your OSSEC Deployment](https://www.atomicorp.com/adding-elliptic-curve-noise-socket-crypto-ossec-deployment/)
* Cointelegraph: [Research: Telegram Passport Is Vulnerable to Brute Force Attacks](https://cointelegraph.com/news/research-telegram-passport-is-vulnerable-to-brute-force-attacks)
* Medium: [Implement Virgil Security’s End-to-End Encryption in your Firebase App — Why and How?](https://medium.com/@geekyants/implement-virgil-securitys-end-to-end-encryption-in-your-firebase-app-why-and-how-dc5286920a32)
* The IOT Magazine: [Shaken and Stirred - The challenge of IoT cyber security and privacy](https://theiotmagazine.com/shaken-and-stirred-5f96ff135bf9)
* Firebase Blog: [The Latest Firebase Tutorials - Fall 2018](https://firebase.googleblog.com/2018/09/the-latest-firebase-tutorials-fall-2018.html)


# Videos

**Our Youtube channel:** [Virgil Security Academy](https://www.youtube.com/channel/UCU8BhA1nVzKKRiU5P4N3D6A)

**Featuring videos:**
* [MacVoices #18140: WWDC/AltConf - Virgil Security Provides End-To-End Encryption SDK's For Developers](https://www.youtube.com/watch?v=MSnKQXvXe-g)
* [TiE50 Room 212 - Virgil Security, Inc](https://www.youtube.com/watch?v=avYpSTfbb14)
* [REAL-TIME COMMS TRACK | Add Encryption to Chat - Dmitry Dain (Virgil Security)](https://www.youtube.com/watch?v=wITDSt9RgUE)
* [How to protect 1 trillion IoT devices / Alexey Ermishkin (Virgil Security)](https://www.youtube.com/watch?v=qLidSKPJCiQ)
* [Key transparency: Blockchain meets NoiseSocket / Alexey Ermishkin (Virgil Security)](https://www.youtube.com/watch?v=hQZ9tSF6g1Y)

# HashTags
You can use the following hashtags while tagging Virgil Security Inc.: [#SecuredByVirgil](https://virgilsecurity.com/), [#SecureTheFuture](https://virgilsecurity.com/), [#VirgilSecurity](https://virgilsecurity.com/).

# License
BSD 3-Clause. See [LICENSE](https://github.com/VirgilSecurity/virgil/blob/master/LICENSE) for details.

# Contacts
Our developer support team is here to help you. Find out more information on our [Help Center](https://help.virgilsecurity.com/).

You can find us on [Twitter](https://twitter.com/VirgilSecurity) or send us email support@VirgilSecurity.com.

Also, get extra help from our support team on [Slack](https://virgilsecurity.com/join-community).
