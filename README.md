# NetworkEngine
NetworkEngine will help you to make API call easily with out the overhead of writing tons of boilerplate codes.

# Quick Start

In your [Podfile]:

```ruby
use_frameworks!

target "Change Me!" do
  pod "NetworkMediator"
end
```

NetworkEngine support Xcode 8.3, 9.0, 9.1, 9.2 and 9.3; Swift 3.1,
3.2, 3.3, 4.0 and 4.1.

# Getting Started

Create an Operation which is a subclass of JSONOperation and provide a ResponseModel which conform to Codable protocol.

```swift
public class StartWarsOperation: JSONOperation<StarWarsCharacterResponseModel> {
    public override init() {
        super.init()
        self.request = Request(method: .get, endpoint: "/people", params: nil, fields: nil, body: nil)
    }
}
```

Response model will look like,

```swift
public struct StarWarsCharacterResponseModel:Codable {
    let next: String
    let characters: [JediProfile]
    
    private enum CodingKeys: String,CodingKey {
        case next
        case characters = "results"
    }
}
```
Finaly, create a ServiceConfig and Service to make API call.

```swift
//You could configure your own service instance with different config setup.
let serviceConfig = ServiceConfig(name: "StarWars", base: "https://swapi.co/api")
let service = Service(configuration: serviceConfig!)
StartWarsOperation().execute(in: service) { [weak self] (startWarsResponse, resultType) in
    self?.jdProfiles = startWarsResponse?.characters
    DispatchQueue.main.async {
         completion(true)
    }
}
```
For more details please check [Example](Swift_NetworkEngine/Example/)
