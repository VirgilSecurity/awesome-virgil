# Getting started

The goal of Virgil .NET/C# Cards SDK Documentation is to give a developer the knowledge and understanding required to implement 
security into his application using Virgil Security ecosystem.

Virgil Cards SDK is a communication gateway between your application and [Virgil services](https://stg.virgilsecurity.com/docs/services/services).
To start using Virgil SDK you will only need to install a NuGet package and create a free account on [Virgil Developer’s 
portal](https://developer.virgilsecurity.com/account/signup).

## Installation

1.	Use NuGet Package Manager (Tools -> Library Package Manager -> Package Manager Console)
2.	Run

	`PM> Install-Package Virgil.SDK`

## Create Virgil account

1.	Register at [Developer’s portal](https://developer.virgilsecurity.com/account/signup)
2.	[Create an application](https://stg.virgilsecurity.com/docs/faq/create-app) 
3.	[Generate an access token](https://stg.virgilsecurity.com/docs/faq/add-access-token)

Your access token is used for secure access to [Virgil Cards Service](https://stg.virgilsecurity.com/docs/services/cards/v4.0(latest)/cards-service) and is passed with every 
API call. The access token also allows the API to associate your app’s requests with your Virgil Security developer’s account.