//
//  contactsVC.swift
//  YoYou
//
//  Created by zhongyu yang on 11/8/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
//  Reference: chat app is biult based on Firbase Chat App https://www.youtube.com/watch?v=t7m_F27cUHY&list=PLZhNP5qJ2IA0ZamF_MDzvmb3bNMv-mLt5



import UIKit
import CoreData
import FirebaseAuth

class contactsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, FetchData{

    @IBOutlet weak var myTableView: UITableView!
    
    private let CHAT_SEGUE = "ChatSegue"
    
    private var contacts = [Contact]()
    
    
//    override func viewvpear(_ animated: Bool) {
//        DBProvider.Instance.getContacts()
//        myTableView.reloadData()
//        print("qweqweqweqweqweqweqweqweq\(contacts)")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        
        DBProvider.Instance.delegate = self
        DBProvider.Instance.getContacts()
        print("qweqweqweqweqwe\(contacts)")
//        // core data
//        let coreDataConainer = AppDelegate.persistentContainer
//        let context =  coreDataConainer.viewContext
//        
//        let  myPerson: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context)
//        print(myPerson)
    }
    
    func dataReceived(contacts: [Contact]) {
        self.contacts = contacts
        
        // get the name of current user
        for contact in contacts {
            if contact.id == AuthProvider.Instance.getUID(){
                AuthProvider.Instance.userName = contact.name
            }
        }
        
        // Do not show the current user in the contact list
        for i in 0...contacts.count - 1{
//            print("aaaaaaaaaaa\(i)")
//            print(contacts[i].id)
//            print("current\(String(describing: Auth.auth().currentUser?.uid))")
            if self.contacts[i].id == AuthProvider.Instance.getUID(){
                self.contacts.remove(at: i)
                break
            }
        }
        print("qweqweqweqweqwe\(contacts[0].name)")

        //  TODO: get the name of current user
        
        self.myTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // begin to set contact table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
//        print("qweqweqweqweqwe\(contacts[0].name)")
        cell.textLabel?.text = contacts[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CHAT_SEGUE, sender: nil)
    }
    // End Table view
    
    @IBAction func logOutButton(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil)
        } 
    }

}
