# Marvel Universe

### Display list of Marvel comic Characters and its detail view

<a href="url"><img src="https://github.com/nigarsk/MarvelUniverse/blob/master/ProjectInfo/Marvel-7.png" align="left" height="480" width="250" ></a>
<a href="url"><img src="https://github.com/nigarsk/MarvelUniverse/blob/master/ProjectInfo/Marvel-8.png" align="left" height="480" width="250" ></a>
<a href="url"><img src="https://github.com/nigarsk/MarvelUniverse/blob/master/ProjectInfo/Marvel-9.png" align="left" height="480" width="250" ></a>

<a href="url"><img src="https://github.com/nigarsk/MarvelUniverse/blob/master/ProjectInfo/Marvel-4.png" align="centre" height="480" width="250" ></a>
<a href="url"><img src="https://github.com/nigarsk/MarvelUniverse/blob/master/ProjectInfo/Marvel-5.png" align="centre" height="480" width="250" ></a>
<a href="url"><img src="https://github.com/nigarsk/MarvelUniverse/blob/master/ProjectInfo/Marvel-1.png" align="centre" height="480" width="250" ></a>

### Installation

Dependencies in this project are provided via Xcodegen (project.yml). Please install all dependecies with

`
brew install xcodegen
`
And after that 

`
xcodegen generate
`

We have two target 

Marvel :
Here all the application logic resides

MarvelTests:
Unit test cases for all the layers

Following are the SPM dependencies required in the yml file
* Alamofire: For all the network calls
* AlamofireImage: Loading remote images in the apps

## Architecture:
Clean MVVM

<a href="url"><img src="https://github.com/nigarsk/MarvelUniverse/blob/master/ProjectInfo/Architecture.png" ></a>

The code is divided in 3 layers, Data, Domain and Presentation. The Application is structured following the main premises of [Clean Architecture](https://github.com/mp911de/CleanArchitecture "Clean Architecture"). The app follows the [dependency inversion principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle) using the protocol oriented approach that Swift has on its foundations. The app has unit test for each layer.

### Data:
On this layer belongs all the classes which main concern is handling the data and the high level rules of the app.

#### Entities
On this group belongs the protocol which represents the data to be consumed by the app. 

#### Provider Implementations

Specific implementations of all Provider Contracts defined on Domain package. 

#### - Services
Services represents external agents like the web service used for getting the data and the repository in which data is stored, grouped and fetched. All the interfaces on this group are protocols, this allows mock objects to conform these protocols and being used for testing purposes on higher layers (like use cases and view models).

### Domain:

The `Domain` is basically what is your App about and what it can do (Models, UseCase etc.) **It does not depend on UIKit or any persistence framework**, and it doesn't have implementations apart from Models

#### UseCase:

The code in this layer contains application specific business rules. Each use case is represented by a protocol, the internal implementation is separated from the interface. 

### Presentation:
The objects on this layer are the UIViewControllers and the UIViews used to present the data to the user. The view controller binds the data from the ViewModels to the UI objects.

#### Presenter:
It works as a bridge between the presentation layer and the business logic.

Its functions are:

1. Handle actions made by the user on the view.
2. Call the app logic layer (Domain) to process these captured actions.
3. Update the view associated to the *(View Controller)* using a new View State.

To update the view we define a **State**. This State is a enum with a set of defined values that represent all the possible states of the view. This state could have associated a **View Model** that includes all the visual information that defines that State, this ViewModel properties are let always, as they represent the visual state of a specific moment. This ViewModel should only be kept a reference to if needed for datasource data.

#### Flow Coordinator:
Navigator is used to navigate between the views

### Unit Tests:
Unit test has been covered for Data m domain and presenter layer. UI tests are not included yet.

## Additional feature:

The app also contains the Accessibility functionality for dynamic system font size changes and voiceover.
View has been designed in simplest way possible in order to incorporate dynamic size changes and voice over sequence on different views.
App view auto adjusts the views to handle run time changes in the font and adjusts frames accordingly without cropping and trimming any data.(Screen shots and videos can be find in the ProjectInfo folder)


