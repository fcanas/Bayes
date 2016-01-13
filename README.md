# Bayes [![Build Status](https://travis-ci.org/fcanas/Bayes.svg)](https://travis-ci.org/fcanas/Bayes)

Bayes is a [Naive Bayes Classifier](http://en.wikipedia.org/wiki/Naive_Bayes_classifier) for iOS and Mac platforms. 

Bayes is implemented in Swift and takes advantage of generics to enable any `Hashable`, `Equatable` type of your choosing or creation for use as category or feature. 

## Installation

### CocoaPods

Bayes is available as a [CocoaPod](http://cocoapods.org), but has not yet been versioned and submitted to trunk. So to use it:
```ruby
pod 'Bayes', git: 'https://github.com/fcanas/Bayes.git'
```

Since Bayes is written in Swift, you will need to be using a recent version of CocoaPods (>0.36) and you may need to add `use_frameworks!` to your Podfile. See [this blog post](http://blog.cocoapods.org/CocoaPods-0.36/) for more information.

### Framework

The project includes framework targets for iOS and Mac. Pull the repository and build the appropriate target for you. 
When Bayes reaches a release milestone, it will be appropriately tagged and should be easily available via [Carthage](https://github.com/Carthage/Carthage).

## Use

```swift
var eventSpace = EventSpace<String, String>()

eventSpace.observe("Cat", features: ["paw", "tail", "claw"])
eventSpace.observe("Cat", features: ["stripe", "tail", "whisker", "ear"])
eventSpace.observe("Cat", features: ["meow", "vertical pupil"])

eventSpace.observe("Dog", features: ["paw", "tail", "bark"])
eventSpace.observe("Dog", features: ["wag", "fetch", "tail", "paw"])

var classifier = BayesianClassifier(eventSpace: eventSpace)

XCTAssertEqual(classifier.classify(["claw", "tail"])!, "Cat", "Should categorize as Cat, due to claw")
XCTAssertEqual(classifier.classify(["bark", "tail"])!, "Dog", "Should categorize as Dog, due to bark")
XCTAssertEqual(classifier.classify(["tail"])!, "Cat", "Should categorize as Cat, due to base rate")
XCTAssertEqual(classifier.classify(["paw", "tail"])!, "Dog", "Should categorize as Dog, due to prevalence of paw")
```

## Contribute

Contributions are welcome. Please note the following guidelines

* Test public functionality
* Make everything as private as possible; use `private` and `internal` aggressively and only expose what is necessary for external functionality
* Favor structs over classes
* Extract standard mathematical functions that may simplify implementation of future models, _e.g._ `product`, `argmax`
