# Places

This app allows you to enter a place and we can deeplink this place to the wikipedia app for more details.

# Architecture

This app uses SwiftUI , MVVM+Usecase architecture. We are using this arctecture because its simple, scalable and maintainable for most moderate enterprise applications. 
Also allows new developers to get up to spead because of the folder struture and the naminng conventions used.

## Diagram

<img src="./app-archtecture.jpg" height="400" style="width: auto;">

## Arcthitecture explainations and naming conventions

- ### View
This is mainly SwiftUI and should not contains any logic, its simply renderes the current state of the view.
A view has one ViewModel
- ### ViewModel
This has all the logic required to manipulate the view, like form validation, updating the state of the view. 
This ViewModel also has a concept called `Configurations`.

Configuration consists of: 
* Colors
* Constants
* Localizable Strings

These are structs of which their values can be changed , they are not fixed we mainly change these values when testing, for example in the app we have a debounce of 500 milliseconds, we can update this to 0 in tests if we wihs to make the tests faster. These are ure usually injected so they can be injected and used anywhere with the feature of the app

A ViewModel can make use of many usescases
- ### Usecase
In most applications this layers just passes Data to the `ViewModel`. In our case it does much more. in such a way tha simplifies the implementation of the ViewModel and further separates concerns. The usecase introduces an entity that can be easily used by the View and `ViewModel`, so it transaforms and parepared the codable structs from the Network or any other datasource so that the view and `ViewModel` can easily use this object without further manipulation.
A `usecase` owns the model that its manipulating for the view
- ### Client
In ourcase the client makes the network calls, the client's only knows how to fetch data from the given source


### Naming Convention and Folder structure

<img src="./folder-structure.png" height="400" style="width: auto;">

The app has two main componenents `Common` and `Features`

### Common

Here we have the `RequestManager` this handles the encoding and decoding of the requests and responses from the internet.
We also created `EndpointProtocol` this allows to easily create structured HTTP `URLRequests` 

This allows us to make HTTP requests easily per `feature`:

```swift
func getPlaces() async throws -> PlacesResponse {
        try await manager.perform(
            request: PlacesEndpoint.getPlaces
        )
    }
```

### Features

A feature is flow within the app like making a payment , so a feature groups related screens and related entities and models

### Folder structure per screen in a feature 

We use a consitent repeative folder structure per feature and per screen

<img src="./folder-structure-struct.png" height="400" style="width: auto;">

The above is the folder structure of each screen
Each screen has

* ## Data
This folder contains all the logic to get the data 
- ### Client 
Knows how to make the HTTP requests
- ### Model
We have the raw response Object from from the network
- ### Usecase
* Mapping
This knows how to map the raw HTTP response to a Model that can be easily usable by the `view` and `viewModel`
* Model
This containst the model that can easily be used by the view and the `ViewModel`
* Usecase
This has the usecase that uses the client to fetch the data from source and transforms to a `Model` that can be used by the View and ViewModel

* ## Views
This has all the swiftUI views required to render this screen Including as well all the localizations







