## Usage

To run the example project; clone the repo, and run `pod install` from the Project directory first.

## Installation

LillyInfoPage is available through [bGraphicCocoaPods](https://github.com/bGraphic/bgraphic-cocoa-pods), to install
it simply add the following line to your Podfile:

    pod "bGraphicCommonStuff"

## Release

To release a new version of the pod use the command from the master branch:

    rake release
    
This will update push to the remote repo and create a new tag, then it will push the Podspec to [bGraphicCocoaPods](https://github.com/bGraphic/bgraphic-cocoa-pods). 

Requires that you have called the Specs Repo *bGraphicCocoaPods* on your machine. Check your Specs Repo name by using this command:

    ls ~/.cocoapods/repos/