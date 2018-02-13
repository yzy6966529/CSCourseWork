// Model.swift
// Manages the Twitter Searches data
import Foundation

// delegate protocol that enables Model to
// notify controller when the data changes
protocol ModelDelegate {
    func modelDataChanged()
}

// private - class members only accessible in the file in which they're defined.
// public - class members defined public can be reused in other apps.
// internal - class members declared to be internal can only be used within the project.

// manages the saved searches
class Model {
    // keys used for storing app's data in app's NSUserDefaults
    
    fileprivate let pairsKey = "TwitterSearchesKVPairs" // for tag-query pairs
    fileprivate let tagsKey = "TwitterSearchesKeyOrder" // for tags
    
    // dictionaries contain key-value pairs. In this case, the key is the "tag" the user enters for their query and the value is the actual search term.
    fileprivate var searches: [String: String] = [:] // stores tag-query pairs
    fileprivate var tags: [String] = [] // stores tags in user-specified order
    
    fileprivate let delegate: ModelDelegate // delegate is MainViewController
    
    // initializes the Model
    // initializers are like constructors in other languages.
    // initializers allow you to set properties of an object when it is instantiated.
    // every object has an intitialzer, if the programmer does not define one, the default is used.
    
    init(delegate: ModelDelegate) {
        self.delegate = delegate
        
        // get the NSUserDefaults object for the app
        let userDefaults = UserDefaults.standard

        // get Dictionary of the app's tag-query pairs
        if let pairs = userDefaults.dictionary(forKey: pairsKey) {
            self.searches = pairs as! [String : String]
        }
        
        // get Array with the app's tag order
        if let tags = userDefaults.array(forKey: tagsKey) {
            self.tags = tags as! [String]
        }
        
        // iCloud stores key-value pairs that sync across all devices using the same Apple ID.
        // register to iCloud change notifications
        
        // .addObserver registers the device to receive iCould notifications:
        NotificationCenter.default.addObserver(
            self,

            selector: #selector(Model.updateSearches(_:)),

             // name of the notification being registered to receive;
             //  this is a predefined String used by iCloud for key-value store changes:
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,

             // defaultStore returns the key-value pairs:
            object: NSUbiquitousKeyValueStore.default()
        )
    }
    
    // called by view controller to synchronize model after it's created
    // this means that the MasterViewController calls this function to ensure that the local key-value pairs (tag-query in our case) are the same as those on other devices.
    func synchronize() {
        NSUbiquitousKeyValueStore.default().synchronize()
    }
    
    // returns the tag at the specified index
    // this is used in the MasterViewController to reference the tag for a search a user made.
    func tagAtIndex(_ index: Int) -> String {
        return tags[index]
    }
    
    // returns the query String for a given tag
    // this is used in the MasterViewController to reference the corresponding search term.
    func queryForTag(_ tag: String) -> String? {
        return searches[tag]
    }
    
    // returns the query String for the tag at a given index
    func queryForTagAtIndex(_ index: Int) -> String? {
        return searches[tags[index]]
    }
    
    // returns the number of tags
    var count: Int {
        return tags.count
    }
    
    // deletes the tag from tags Array, and the corresponding
    // tag-query pair from searches iCloud
    func deleteSearchAtIndex(_ index: Int) {
        searches.removeValue(forKey: tags[index])
        let removedTag = tags.remove(at: index)
        updateUserDefaults(updateTags: true, updateSearches: true)
        
        // remove search from iCloud
        let keyValueStore = NSUbiquitousKeyValueStore.default()
        keyValueStore.removeObject(forKey: removedTag)
    }
    
    // reorders tags Array when user moves tag in controller's UITableView
    func moveTagAtIndex(_ oldIndex: Int, toDestinationIndex newIndex: Int) {
        let temp = tags.remove(at: oldIndex)
        tags.insert(temp, at: newIndex)
        updateUserDefaults(updateTags: true, updateSearches: false)
    }
    
    // update user defaults with current searches and tags collections
    func updateUserDefaults(updateTags: Bool, updateSearches: Bool) {
        let userDefaults = UserDefaults.standard
        
        if updateTags {
            userDefaults.set(tags, forKey: tagsKey)
        }
        
        if updateSearches {
            userDefaults.set(searches, forKey: pairsKey)
        }
       
        userDefaults.synchronize() // force immediate save to device
    }
    
    // update or delete searches when iCloud changes occur:
    @objc func updateSearches(_ notification: Notification) {

        if let userInfo = notification.userInfo {

            // check reason for change and update accordingly:
            if let reason = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as! NSNumber? {
                // if changes occurred on another device:
                if reason.intValue == NSUbiquitousKeyValueStoreServerChange ||
                   reason.intValue == NSUbiquitousKeyValueStoreInitialSyncChange {
                    performUpdates(userInfo) // update searches
                }
            }
        }
    }
    
    // add, update or delete searches based on iCloud changes
    func performUpdates(_ userInfo: [AnyHashable : Any]) {
        // get changed keys NSArray; convert to [String]
        let changedKeysObject =
            userInfo[NSUbiquitousKeyValueStoreChangedKeysKey]
        let changedKeys = changedKeysObject as! [String]
        
        // get NSUbiquitousKeyValueStore for updating
        let keyValueStore = NSUbiquitousKeyValueStore.default()
        
        // update searches based on iCloud changes
        for key in changedKeys {
            if let query = keyValueStore.string(forKey: key) {
                saveQuery(query, forTag: key, syncToCloud: false)
            } else {
                // let tempSearches = searches
                searches.removeValue(forKey: key)
                tags = tags.filter{$0 != key}
                updateUserDefaults(updateTags: true, updateSearches: true)
            }

            delegate.modelDataChanged() // update the view
        }
    }
    
    // save a tag-query pair
    func saveQuery(_ query: String, forTag tag: String,
        syncToCloud sync: Bool) {

        // Dictionary method updateValue returns nil if key is new
        // let tempSearches = searches
        let oldValue = searches.updateValue(query, forKey: tag)
            
        if oldValue == nil {
            tags.insert(tag, at: 0) // store search tag
            updateUserDefaults(updateTags: true, updateSearches: true)
        } else {
            updateUserDefaults(updateTags: false, updateSearches: true)
        }
        
        // if sync is true, add tag-query pair to iCloud
        if sync {
            NSUbiquitousKeyValueStore.default().set(
                query, forKey: tag)
        }
    }
}


/*************************************************************************
* (C) Copyright   by Deitel & Associates, Inc. All Rights Reserved.   *
*                                                                        *
* DISCLAIMER: The authors and publisher of this book have used their     *
* best efforts in preparing the book. These efforts include the          *
* development, research, and testing of the theories and programs        *
* to determine their effectiveness. The authors and publisher make       *
* no warranty of any kind, expressed or implied, with regard to these    *
* programs or to the documentation contained in these books. The authors *
* and publisher shall not be liable in any event for incidental or       *
* consequential damages in connection with, or arising out of, the       *
* furnishing, performance, or use of these programs.                     *
*                                                                        *
* As a user of the book, Deitel & Associates, Inc. grants you the        *
* nonexclusive right to copy, distribute, display the code, and create   *
* derivative apps based on the code. You must attribute the code to      *
* Deitel & Associates, Inc. and reference the book's web page at         *
* www.deitel.com/books/ios8fp1/. If you have any questions, please email *
* at deitel@deitel.com.                                                  *
*************************************************************************/

