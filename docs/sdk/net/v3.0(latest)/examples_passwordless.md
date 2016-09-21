#Passwordless Authentication Client Side

## Example C#/.Net

###Install
Use the NuGet Package Manager (Tools -> Library Package Manager -> Package Manager Console) to install the Virgil.SDK.Keys package, running the command:
```
PM> Install-Package Virgil.Crypto
```

### Implementation

```csharp
var authResponse = await WebClient.Post<AuthResponse>("/auth")
    .Body(new { email = "user-email@example.com" });

var authResult = await WebClient.Post<AuthResult>("/auth")
    .Body(new
    {
        email = "user-email@example.com",
        decrypted_token = VirgilCrypto.Decrypt(authResponse.EncryptedToken, myPrivateKey)
    });
```

## Example Java/Android

###Install
In the Gradle dependencies sections add

```
compile 'com.vergilsecurity.android:sdk:+'
```

### Implementation
```java	
final Call<AuthResponse> handshake = authService.handshake("user-email@example.com");
handshake.enqueue(new ResponseCallback<AuthResponse>() {
    @Override
    public void onResult(@Nullable AuthResponse authResponse) {
        authService.authorize("user-email@example.com", 
        	VirgilCrypto.decrypt(authResponse.encryptedToken, _myPrivateKey));
    }
});
```

##Example Javascript

### Install
Use bower or npm to install Virgil.SDK packages.
```
bower install virgil-browsers
```
```
npm install virgil-browsers
```
###Implementation

```javascript
function initiateHandShake () {
	return post('/auth', {
		email: 'user-email@example.com'
	});
}

function decryptAndSendToken (res) {
	return post('/auth', {
		email: 'user-email@example.com',
		decrypted_token: Virgil.Crypto.decrypt(res.token, myPrivateKey)
	});
}
```

