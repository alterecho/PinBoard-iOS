The entire task is built with Pinterest.workspace.
The workspace contains 2 projects:
    - Downloader.xcodeproj  <- library project that builds a .framework as product, and which is used by the app
    - PinBoard.xcodeproj    <- App project

Downloader.xcodeproj:
    - The layout of the all the main functionality/classes is defined/abstracted as protocols.

    - DownloaderProtocol:
        Defines the initializers and download methods that a class has to implement to be considered as downloder
        Accomodates dependency injection

    - DownloadOperationProtocol:
        Defines the methods that a class capable of downloading anything is expected to have and implement.

    - DownloadableProtocol:
        The Downloders use the classes that conform to this empty protocol.
        Any Class can be made to extend this empty protocol.
    
    Example:
        To download images, a class named ImageDownloader is created and made to conform to the DownloaderProtocol and the DownloadOperationProtocol. It then marks the UIImage as Donloadable by extending the UIImage class and conforming it to the empty DownloadableProtocol.

    Testing:
        Testing implements mocks and dependency injection. Dependency injection is defined by the initializers in the protocols. Mocking is accomplished by abstracting and defining functionality in protocols.

        The sample responses and image are found in the "assets" folder/group.


PinBoard.xcodeproj:
    Is comprised of one ViewController (ViewController.swift) which manages a UICollectionView to display the data downloaded from the URL.

    The JSON data is parsed using Swifts JSONDecoder class and Decodable conformed Classes.

    The Downloader library provides a method to download classes that conform to Decodable protocols, directly.


