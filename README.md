# flickrSharks

This is a rough draft of an application - it fetches Flickr photos of Tiger Sharks, displays in a collection view
There are a lot of parts in code that are basically placeholders with minimum code.
I wanted to show the whole structure of the project and how different parts integrate with each other rather than making perfectly working code but having it all spagehetti (eg. having all network calls together with caching, operations etc in one file) 

Thus, lots of things are obmitted, here is the list of ToDo's:
- Not optimized for threading to the extend as it should be - added some placeholders for nsoperation queues and operations
- Need to add dependencies so that an image can't be downloaded until image loading is completed
- Added placeholders for cancelling operations when cells are off screen, but needs to be debugged and all glued together:
- It should start loading once a user stopped scrolling, cancel operations for cells off screen
- add a dependency for async operations to have thumbnail loaded first, then better quality picture, then wanted to add filter
- Using AFNetwork instead of NSURLSession for BaseNetworkManager - need to change that. 
Essentially the biggest difference in terms of threads is that NSURLSession automatically switches to a background thread but you’re responsible for switching  back, AFNetworking also switches back.
Downloading an image using NSURLSession directly as a starting point.
- I showed how I’d handle base network manager. it has base url as Flickr which isn’t quite right since FlickrNetworkManager should encapsulate all flickr details, but since normally it would be the same base url for the whole app, I left it in place
- I showed how I’d handle different status codes from the network, there’s a TODO to handle custom Flickr search ones
- Not making a separate request in the details view controller, just loading image - need to make another request to the 2nd api which returns an individual photo details with photo user, tags, etc.
- No pagination, only first page returned in the collection view for now, page is a parameter, need to tie triggering next page for a range
- Need to finish up rotation - working only in certain positions
- Pull to refresh not done - need to create a custom view and reload table
- Caching is just a very rough version to showcase how it would play together in a data manager
- the whole UI isn't using all the assets or custom fonts/colors defined in the app
- not opening in Flickr - would need to add a web view controller and pass the url
