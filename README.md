Unit 8: Group Milestone - Hidden Gem README 
===

<!-- :::info
**Below is an example** of what your **Group Project README** should include and how it should be structured for the **Unit 8 Group Milestone Submission**.
::: -->

# Hidden Gem

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)

## Overview
### Description
Displays locations that users mark as interesting, unique, or hidden. Can potentially contain locations and routes that individuals will explore with friends and family.  

### App Evaluation
- **Category:** Travel / Social
- **Mobile:** This app would be primarily developed for mobile but would perhaps be just as viable on a computer. Functionality wouldn't be limited to mobile devices, however mobile version could potentially have more features.
- **Story:** Analyzes users location, and displays marked locations within the users desired vicinity. The user can then decide to mark a new location or view marked locations.
- **Market:** Any individual could choose to use this app, and to keep it a safe environment, people would be showed locations at a maximum of 20 miles away from their current location.
- **Habit:** This app could be used as often or unoften as the user wanted depending on how adventurous they are, and what exactly they're looking for.
- **Scope:** First we would start with displaying marked locations based on the individual's location preferences, then perhaps this could evolve into a travel guide application as well to broaden its usage.


<!-- Eduardo has stopped editting at this location -->

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* All users can view, add, update, and delete hidden gems based off their location
* Profile pages for each user
* Settings (Accesibility, Notification, General, etc.)

**Optional Nice-to-have Stories**

* Map kit to display hidden gems on the map as pins
* Shortest route to selected hidden gem
* Favoriting and rating hidden gems for logged in users 

### 2. Screen Archetypes

* Login 
    * Users who already logged in will remain logged in
* Register
    * User signs up or logs into their account
* Maps 
    * Shows a map with hidden locations marked, also includes a search bar to search for specific hidden gems, also an add button to add new hidden gem locations
* Creation
    * Create a new hidden gem to add to maps
* Detail
    * Click on a specific hidden gem location and view details about the location
* Profile 
   * Allows user to upload a photo and fill in information that is interesting to them and others
* Settings
   * Lets people set location, change language, and app notification settings.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Add Locations
* Search
* Profile
* Settings

Optional:
* Map
* Discover (Popular Choices)

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available
* Map/Stream -> Add Location -> Creation
* Creation -> Add image, location, tags and description -> Post (End creation)
* Map/Stream -> Search -> Details -> Locations on map
* Profile -> Change of name, location, favorited locations. 
* Settings -> Change of language, access to location

## Wireframes
<img src="https://i.imgur.com/apKfylG.jpg" width=800><br>

<!-- ### [BONUS] Digital Wireframes & Mockups
<img src="https://i.imgur.com/lYHn37F.jpg" height=200>

### [BONUS] Interactive Prototype
<img src="https://i.imgur.com/AiKfE5g.gif" width=200> -->

## Schema 

### Objects
- User
- hiddenGem
- Settings
- (Map) --> consult first

### Models
[Add table of models]

User:
| Property | Type | Description |
|----------|:----:|:-----------:|
|objectId|String|unique id for each user|
|username|String|username for the user|
|password|String|password for the user|
|email|String|email for the user|
|createdAt|DateTime|date and time of when user was created|
|updatedAt|DateTime|date and time of when user was updated|

hiddenGem: 
| Property | Type | Description |
|----------|:----:|:-----------:|
|objectId|String|unique id for each hidden gem|
|name|String|name of the hidden gem|
|location|String|location of the hidden gem|
|username|String|username who inputted this hidden gem|
|createdAt|DateTime|date and time of when user was created|
|updatedAt|DateTime|date and time of when user was updated|

Settings:
| Property | Type | Description |
|----------|:----:|:-----------:|
|username|Pointer to User|which user's settings it belongs to|
|language|String|what language is used for the app|
|location|String|location of the user for the app|

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
- Login
    - (Create/POST) Log in for the user
    ```swift
         let username = usernameField.text!
         let password = passwordField.text!
         
         PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
             if (user != nil) {
                 self.performSegue(withIdentifier: "loginSegue", sender: nil)
             }
             else {
                 print("Error: \(error?.localizedDescription)")
             }
         }
     ```
- Register
    - (Create/POST) Create a new user
    ```swift
         let user = PFUser()
         user.username = usernameField.text
         user.password = passwordField.text
         user.email = emailField.text
        
         user.signUpInBackground { (success, error) in
             if (success) {
                 self.performSegue(withIdentifier: "loginSegue", sender: nil)
             }
             else {
                 print("Error: \(error?.localizedDescription)")
             }
         }
     ```
- Maps
    - (Read/GET) Query all the hidden gems
    ```swift
         let query = PFQuery(className:"HiddenGems")
         query.whereKey("name", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (hiddenGems: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let hiddenGems = hiddenGems {
               print("Successfully retrieved \(hiddenGems.count) hidden gems.")
           // TODO: Do something with hidden gems...
            }
         }
     ```
- Creation
    - (Create/POST) Create a new hidden gem
    ```swift
         let hiddenGems = PFObject(className:"HiddenGems")
         
         hiddenGem["name"] = nameField.text
         hiddenGem["location"] = locationField.text
         hiddenGem["username"] = user.username
         
         hiddenGems.saveInBackground {
           (success: Bool, error: Error?) in
              if (success) {
                // The object has been saved.
              }
              else {
               // There was a problem, check error.description
              }
         }
     ```
- Detail
    - (Read/GET) Query specific details of a hidden gem
    ```swift
         let query = PFQuery(className:"HiddenGems")
         query.whereKey("name", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (hiddenGem: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let hiddenGem = hiddenGem {
               print("Successfully retrieved hidden gem.")
           // TODO: Do something with hidden gem...
            }
         }
     ```
    - (Update/PUT) Update details of a hidden gem
    ```swift
         let query = PFQuery(className:"HiddenGems")
         query.getObjectInBackgroundWithId(hiddenGem.id) {
         (hiddenGem: PFObject?, error: NSError?) -> Void in
           if error != nil {
             print(error)
           } 
           else {
             hiddenGem["name"] = nameField.text
             hiddenGem["location"] = locationField.text
           }
         }
     ```
    - (Delete) Delete a hidden gem
    ```swift
        let query = PFQuery(className: "HiddenGems")
        
        query.whereKey("objectId", equalTo: hiddenGem.id)
        query.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]?, error: NSError?) -> Void in
          for hiddenGem in hiddenGems {
              hiddenGem.deleteEventually()
          }
        }
     ```
- Profile
    - (Read/GET) Query details of a user's profile
    ```swift
         let query = PFQuery(className:"Users")
         query.whereKey("username", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (user: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let profile = profile {
               print("Successfully retrieved profile.")
           // TODO: Do something with profile...
            }
         }
     ```
    - (Update/PUT) Update details of a user's profile
    ```swift
         let query = PFQuery(className:"Users")
         query.getObjectInBackgroundWithId(user.id) {
         (user: PFObject?, error: NSError?) -> Void in
           if error != nil {
             print(error)
           } 
           else {
             user["username"] = usernameField.text
             user["password"] = passwordField.text
             user["email"] = emailField.text
           }
         }
     ```
- Settings
    - (Read/GET) Query information about a user's settings
    ```swift
         let query = PFQuery(className:"Settings")
         query.whereKey("User", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (settings: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let settings = settings {
               print("Successfully retrieved settings.")
           // TODO: Do something with settings...
            }
         }
     ```
    - (Update/PUT) Update details of a user's settings
    ```swift
         let query = PFQuery(className:"Settings")
         query.getObjectInBackgroundWithId(settings.id) {
         (settings: PFObject?, error: NSError?) -> Void in
           if error != nil {
             print(error)
           } 
           else {
             settings["language"] = languageField.text
             settings["location"] = locationField.text
           }
         }
     ```
