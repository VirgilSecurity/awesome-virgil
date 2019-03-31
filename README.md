<a href="https://virgilsecurity.com"><img src="images/VirgilLogo.png"></a>

[Virgil Security](https://virgilsecurity.com) is a stack of security libraries and all the necessary infrastructure to enable seamless, end-to-end encryption for any application, platform or device. In a few simple steps you can encrypt communication, securely store data, provide passwordless login, and ensure data integrity.

Our libraries allow developers to get up and running with Virgil API quickly and add full end-to-end security to their existing digital solutions to become HIPAA and GDPR compliant and more.

Virgil Security, Inc. guides software developers into the forthcoming security world in which everything will be encrypted (and passwords will be eliminated). In this world, the days of developers having to raise millions of dollars to build secure chat, secure email, secure file-sharing, or a secure anything have come to an end. Now developers can instead focus on building features that give them a competitive market advantage while end-users can enjoy the privacy and security they increasingly demand.

## Content
- [Community](#community)
- [Products](#products)
  - [Tools](#tools)
  - [SDK](#sdk)
- [License](#license)

# Community
### 1. Web resources
* [Main Website](https://VirgilSecurity.com)
* [Developers Documentation](https://developer.virgilsecurity.com/docs)
* [Virgil Developer Dashboard](https://dashboard.VirgilSecurity.com)
* [Help Center](https://help.VirgilSecurity.com)
* [PasswOrd Community](https://passw0rd.io/)

### 2. Social media
* [Facebook](https://www.facebook.com/VirgilSec)
* [Twitter](https://twitter.com/VirgilSecurity)
* [LinkedIn](https://www.linkedin.com/company/virgil-security-inc-/)
* [DOU](https://jobs.dou.ua/companies/virgil-security-inc/)

### 3. Blogs
* [Medium Blog](https://medium.com/@VirgilSecurity)
* [Habr](https://habr.com/company/VirgilSecurity)

### 4. Support
* Slack https://VirgilSecurity.slack.com/
* [Email](mailto:support@VirgilSecurity.com)

# Products

### Tools

* [Virgil CLI](https://github.com/VirgilSecurity/virgil-cli) - a tool to manage your Virgil account and applications.
* [Passw0rd CLI](https://github.com/passw0rd/cli) - an tool for interacting with the [Passw0rd Service](https://passw0rd.io/)

### SDK

* **E3Kit SDK** - Client-side SDK that simplifies work with Virgil services and presents the easiest way to add full end-to-end encryption (E2EE) security to your digital solutions. E3Kit interacts with Cards Service, Keyknox Service and Pythia Service and supports multi-device access and group chat features.
  * [Javascript](https://github.com/VirgilSecurity/virgil-e3kit-js) [![npm](https://img.shields.io/npm/v/@virgilsecurity/e3kit.svg)](https://www.npmjs.com/package/@virgilsecurity/e3kit)
  * [Swift](https://github.com/VirgilSecurity/virgil-e3kit-x) [![CocoaPods Compatible](https://img.shields.io/cocoapods/v/VirgilE3Kit.svg)](https://cocoapods.org/pods/VirgilE3Kit)
  * [Kotlin](https://github.com/VirgilSecurity/virgil-e3kit-kotlin) [![Maven Central](https://maven-badges.herokuapp.com/maven-central/com.virgilsecurity/purekit/badge.svg)](https://maven-badges.herokuapp.com/maven-central/com.virgilsecurity/purekit)


* **PureKit SDK** - Server-side SDK allows developers to communicate with the Virgil PHE service and perform necessary operation to protect users' passwords and personal identifiable information in a database from data breaches and both online and offline attacks.
  * [PHP](https://github.com/VirgilSecurity/virgil-purekit-php) [![Latest Version on Packagist](https://img.shields.io/packagist/v/virgil/purekit.svg?style=flat-square)](https://packagist.org/packages/virgil/purekit)
  * [.NET/C#](https://github.com/VirgilSecurity/virgil-purekit-net) [![Nuget package](https://img.shields.io/nuget/v/virgil.purekit.svg)](https://www.nuget.org/packages/Virgil.PureKit/)
  * [Golang](https://github.com/VirgilSecurity/virgil-purekit-go)
  * [Kotlin/Java](https://github.com/VirgilSecurity/virgil-purekit-kotlin)  [![Maven Central](https://maven-badges.herokuapp.com/maven-central/com.virgilsecurity/purekit/badge.svg)](https://maven-badges.herokuapp.com/maven-central/com.virgilsecurity/purekit)


* **Cards Service SDK** - interacts with Virgil Cards Service and allows developers to add end-to-end encryption (E2EE) security to their new and existing digital products. SDK can be used on both client-side and server-side.
  * [Javascript](https://github.com/VirgilSecurity/virgil-sdk-javascript)  [![npm](https://img.shields.io/npm/v/virgil-sdk.svg)](https://www.npmjs.com/package/virgil-sdk)
  * [.NET/C#](https://github.com/VirgilSecurity/virgil-sdk-net) [![Nuget package](https://img.shields.io/nuget/v/Virgil.SDK.svg)](https://www.nuget.org/packages/Virgil.SDK/)
  * [C++](https://github.com/VirgilSecurity/virgil-sdk-cpp)
  * https://github.com/VirgilSecurity/virgil-sdk-x
  * https://github.com/VirgilSecurity/virgil-sdk-php
  * https://github.com/VirgilSecurity/virgil-sdk-java-android
  * https://github.com/VirgilSecurity/virgil-sdk-python
  * https://github.com/VirgilSecurity/virgil-sdk-go
  * https://github.com/VirgilSecurity/virgil-sdk-ruby


* **Pythia Service SDK** - allows developers to communicate with Virgil Pythia Service to generate a Brainkey (private Key which is based on a password) and protect user passwords in a database.
  * https://github.com/VirgilSecurity/virgil-pythia-go
  * https://github.com/VirgilSecurity/virgil-pythia-node
  * https://github.com/VirgilSecurity/virgil-pythia-x
  * https://github.com/VirgilSecurity/pythia-net
  * https://github.com/VirgilSecurity/virgil-pythia-java


* **Keyknox Service SDK** - allows developers to communicate with the Virgil Keyknox Service to upload, download, and synchronize encrypted sensitive data (private keys) between user's devices.
  * https://github.com/VirgilSecurity/virgil-keyknox-kotlin
  * https://github.com/VirgilSecurity/virgil-keyknox-x
  * https://github.com/VirgilSecurity/virgil-keyknox-javascript


* **Double Ratchet Service SDK** - allows developers to communicate with PFS service and implements the Double Ratchet algorithm, which is used by parties to exchange encrypted messages based on a shared secret key.
  * https://github.com/VirgilSecurity/virgil-ratchet-x

* **PFS Service SDK** - interacts with Virgil PFS Service and allows developers to add Virgil Perfect Forward Secrecy (PFS) to their end-to-end chat to prevent a possibly compromised long-term secret key from affecting the confidentiality of past communications.
  * https://github.com/VirgilSecurity/virgil-sdk-pfs-x
  * https://github.com/VirgilSecurity/virgil-pfs-net
  * https://github.com/VirgilSecurity/virgil-pfs-java


# License
BSD 3-Clause. See [LICENSE](https://github.com/VirgilSecurity/virgil/blob/master/LICENSE) for details.

# Contacts
Our developer support team is here to help you. Find out more information on our [Help Center](https://help.virgilsecurity.com/).

You can find us on [Twitter](https://twitter.com/VirgilSecurity) or send us email support@VirgilSecurity.com.

Also, get extra help from our support team on [Slack](https://virgilsecurity.com/join-community).
