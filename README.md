<a href="https://virgilsecurity.com"><img src="images/VirgilLogo.png"></a>

[Virgil Security](https://virgilsecurity.com) is a stack of security libraries and all the necessary infrastructure to enable seamless, end-to-end encryption for any application, platform or device. 

Our libraries allow developers to get up and running with Virgil API quickly and add full end-to-end security to their existing digital solutions to become HIPAA and GDPR compliant and more.

Virgil Security, Inc. guides software developers into the forthcoming security world in which everything will be encrypted (and passwords will be eliminated). In this world, the days of developers having to raise millions of dollars to build secure chat, secure email, secure file-sharing, or a secure anything have come to an end. Now developers can instead focus on building features that give them a competitive market advantage while end-users can enjoy the privacy and security they increasingly demand.

# Content
- [Community](#community)
- [Products](#products)
  - [Tools](#tools)
  - [SDK](#sdk)
  - [Services](#services)
  - [Cryptographic Libraries](#cryptographic-libraries)
- [Production Applications](#production-applications)
- [Integrations](#integrations)
  - [Any platform](#with-any-platform)
  - [Firebase](#with-firebase)
  - [Twilio](#with-twilio)
  - [PubNub](#with-pubnub)
  - [Nexmo](#with-nexmo)
  - [WordPress](#with-wordpress)
- [Blog Posts](#blog-posts)
- [Videos](#videos)
- [License](#license)
- [Contacts](#contacts)

# Community
### Web resources
* [Main Website](https://VirgilSecurity.com)
* [Developers Documentation](https://developer.virgilsecurity.com/docs)
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
* [Virgil CLI](https://github.com/VirgilSecurity/virgil-cli) - a tool to manage your Virgil account and applications.
* [Passw0rd CLI](https://github.com/passw0rd/cli) - a tool for interacting with the [Passw0rd Service](https://passw0rd.io/)

### SDK
* **E3Kit SDK** - Client-side SDK that simplifies work with Virgil services and presents the easiest way to add full end-to-end encryption (E2EE) security to your digital solutions. E3Kit interacts with Cards Service, Keyknox Service and Pythia Service and supports multi-device access and group chat features.
  * [JavaScript/TypeScript](https://github.com/VirgilSecurity/virgil-e3kit-js) 
  * [Swift](https://github.com/VirgilSecurity/virgil-e3kit-x)
  * [Java/Kotlin](https://github.com/VirgilSecurity/virgil-e3kit-kotlin) 

* **PureKit SDK** - Server-side SDK allows developers to communicate with the Virgil PHE service and perform necessary operation to protect users' passwords and personal identifiable information in a database from data breaches and both online and offline attacks.
  * [PHP](https://github.com/VirgilSecurity/virgil-purekit-php) 
  * [C#.NET](https://github.com/VirgilSecurity/virgil-purekit-net)
  * [Golang](https://github.com/VirgilSecurity/virgil-purekit-go)
  * [Java/Kotlin](https://github.com/VirgilSecurity/virgil-purekit-kotlin) 

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

* **Pythia Service SDK** - allows developers to communicate with Virgil Pythia Service to generate a Brainkey (private Key which is based on a password) and protect user passwords in a database.
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

* [Cards Service](https://developer.virgilsecurity.com/docs/api-reference/card-service/v5) - Stores and manages users' Virgil Cards with Public Keys and associated information.
* [Pythia Service](https://developer.virgilsecurity.com/docs/api-reference/pythia-service/v1) - Service provides developers with an ability to generate a user's restorable keypair based on a password.
* [Keyknox Service](https://developer.virgilsecurity.com/docs/api-reference/keyknox-service/v1) - Allows developers to securely store private keys and secrets in the Virgil Cloud and share them between their devices.

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


# Production Applications
* **Virgil Messenger** - End-to-end encrypted messenger with passwordless authentication. Perfect solution for those who care about their privacy. 
  * [Virgil Messenger iOS](https://itunes.apple.com/us/app/virgil-messenger/id1374223472)
    * [Source code](https://github.com/VirgilSecurity/chat-twilio-ios/)
  * [Virgil Messenger Android](https://play.google.com/store/apps/details?id=com.virgilsecurity.android.virgilmessenger)
    * [Source code](https://github.com/VirgilSecurity/demo-twilio-chat-android/tree/extended_e2ee)

# Integrations

### With any platform
* Tutorials
  * [Add end-to-end encryption to your application to secure communication](https://developer.virgilsecurity.com/docs/use-cases/v5/encrypted-communication) - In this tutorial, we will help you add end-to-end encryption to your product to secure your messages and user data.
  * [Protect user passwords and data in your database from data breaches](https://developer.virgilsecurity.com/docs/use-cases/v1/passwords-and-data-protection) - Virgil Security’s Password-Hardened Encryption (PHE) service replaces password hashing with a more cryptographic solution that prevents brute-force attacks on passwords and sensitive data stored in the database, and allows developers to instantly render a stolen database useless without any inconvenience to the end users.
  * [Generate a restorable key pair based on a user's password](https://developer.virgilsecurity.com/docs/use-cases/v1/brainkey) - Create strong cryptographic keys based on a user's password using Virgil Pythia. 
  * [Protect user messages from being decrypted even if the main private key is compromised](https://developer.virgilsecurity.com/docs/use-cases/v4/perfect-forward-secrecy) - In this tutorial, we will help two people or IoT devices to communicate with end-to-end encryption with PFS enabled.
* Demos
  * [Encryption Demo JS](https://github.com/VirgilSecurity/demo-encryption-js) - A simple javascript application with Node.js backend demonstrating the use of Virgil Javascript SDK and Virgil Crypto.

### With Firebase 
* Tutorials
  * [Add end-to-end encryption to your Firebase application](https://developer.virgilsecurity.com/docs/use-cases/v5/encrypted-communication-for-firebase) - In this tutorial, we will help you add end-to-end encryption to your Firebase application to secure your messages and user data.
* Demos
  * Applications
  Simple applications that demonstrate how end-to-end encryption works. The applications use [Firebase](https://github.com/VirgilSecurity/virgil-e3kit-firebase-func) as a backend service for authentication and chat messaging, and Virgil E3Kit SDK for end-to-end encryption.
    * [Demo iOS](https://github.com/VirgilSecurity/demo-firebase-ios)
    * [Demo Android](https://github.com/VirgilSecurity/demo-firebase-android)
    * [Demo Javascript](https://github.com/VirgilSecurity/demo-firebase-js)
  
### With Twilio
* Tutorials
  * [Add end-to-end encryption to your Twilio Programmable Chat](https://developer.virgilsecurity.com/docs/use-cases/v5/encrypted-communication-for-twilio) - In this tutorial, we will help you add end-to-end encryption to your product to secure your messages and user data that you deliver using Twilio Programmable Chat.
* Demos
  * Applications
    * [Demo Android](https://github.com/VirgilSecurity/demo-twilio-chat-android) - A simple Android application that demonstrates how the end-to-end encryption (E2EE) works in chat messaging use case. The application uses Twilio as a messaging provider.
    * [Demo iOS chat](https://github.com/VirgilSecurity/chat-twilio-ios/tree/sample-v5) - A simple E2EE chat for iOS which uses Twilio API and Virgil Security services.
  * Backend
    * [Twilio Sample Backend for Node.js](https://github.com/VirgilSecurity/twilio-sample-backend-nodejs) - A sample backend that demonstrates how to generate a Virgil JWT and Twilio token used for authentication with the Virgil and Twilio services
  
### With Pubnub
* Tutorials
  * [Build HIPAA Compliant End-to-End Encrypted Chat Apps Using PubNub and Virgil Security](https://www.pubnub.com/blog/build-hipaa-compliant-end-to-end-encrypted-chat-apps-using-pubnub-and-virgil-security/) - In this tutorial, we’ll show you how to make PubNub’s ChatEngine live JavaScript app end-to-end encrypted with the Virgil Security SDK.
  * [Add end-to-end encryption to your PubNub IoT Smart Lock Door](https://developer.virgilsecurity.com/docs/use-cases/v5/smart-door-lock) - In this tutorial we'll apply the concept of verifying that the data being sent to and from an IoT device has not been manipulated or altered by another party to the following real-world scenarios involving a smart door lock: building a cloud-connected smart door lock in a way that prevents it from being opened by the manufacturer or by anyone with access to the manufacturer’s cloud account and preventing thefts of opportunity by preventing the manufacturer’s cloud backend from revealing which doors are open and closed.


### With Nexmo
* Demos
  * Applications
    * [Demo E3Kit Android chat](https://github.com/VirgilSecurity/demo-nexmo-chat-e3kit-android) - Demo Android chat that uses Virgil E3Kit and Nexmo.
    * [Demo Android chat](https://github.com/VirgilSecurity/demo-nexmo-chat-android) - A simple Web application that demonstrates how the end-to-end encryption works in chat messaging use case. The application uses Nexmo as a messaging provider.
  * Backend
    * [Demo Java/Android backend](https://github.com/VirgilSecurity/demo-nexmo-chat-backend-java) - This repository contains a sample backend code that demonstrates how to generate a Nexmo and Virgil JWTs using the Java/Android SDK.
  
### With WordPress
* [Virgil Pure Wordpress Plugin](https://github.com/VirgilSecurity/virgil-pure-wordpress) - Free Wordpress Plugin based on a powerful and revolutionary cryptographic technology that protects user passwords from data breaches and both online and offline attacks.

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

# License
BSD 3-Clause. See [LICENSE](https://github.com/VirgilSecurity/virgil/blob/master/LICENSE) for details.

# Contacts
Our developer support team is here to help you. Find out more information on our [Help Center](https://help.virgilsecurity.com/).

You can find us on [Twitter](https://twitter.com/VirgilSecurity) or send us email support@VirgilSecurity.com.

Also, get extra help from our support team on [Slack](https://virgilsecurity.com/join-community).
