# Virgil Security for Java

<a href="https://d3js.org"><img width="230px" src="https://github.com/VirgilSecurity/virgil-net/blob/master/logo.png" align="left" hspace="10" vspace="6"></a>

Virgil is a stack of security libraries (ECIES with Crypto Agility wrapped in Virgil Cryptogram) and all the necessary infrastructure to enable seamless, end-to-end encryption for any application, platform or device. Get in touch with us to get preview access to our key infrastructure.

Virgil Security, Inc., guides software developers into the forthcoming security world in which everything will be encrypted (and passwords will be eliminated). In this world, the days of developers having to raise millions of dollars to build a secure chat, secure email, secure file-sharing, or a secure anything have come to an end. Now developers can instead focus on building features that give them a competitive market advantage while end-users can enjoy the privacy and security they increasingly demand.

##Build

```
mvn clean package source:jar javadoc:jar -DskipTests=true
```

##Build with functional tests

```
mvn clean package source:jar javadoc:jar -DskipTests=true -DAPPLICATION_ID={application_id} -DSERVICE_ACCOUNT={mailinator_account}
-DCLIENT_ACCOUNT={mailinator_account} -DACCESS_TOKEN={access_token}
```

## Resources

* [Quickstart](https://github.com/VirgilSecurity/virgil/blob/master/java-android/quickstart/readme.md)
* Crypto Library 
  * [Tutorial](https://github.com/VirgilSecurity/virgil/blob/master/java-android/crypto-library/readme.md) 
* SDK
  * [Tutorial](https://github.com/VirgilSecurity/virgil/blob/master/java-android/keys-sdk/readme.md)

## License
BSD 3-Clause. See [LICENSE](https://github.com/VirgilSecurity/virgil/blob/master/LICENSE) for details.

## Contacts
Email: <support@virgilsecurity.com>

