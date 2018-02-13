//
//  ChatVC.swift
//  YoYou
//
//  Created by zhongyu yang on 11/22/17.
//  Copyright © 2017 A290/A590 Fall 2017 - zy7. All rights reserved.
// Reference: chat app is biult based on Firbase Chat App https://www.youtube.com/watch?v=t7m_F27cUHY&list=PLZhNP5qJ2IA0ZamF_MDzvmb3bNMv-mLt5

import UIKit
import JSQMessagesViewController
import AVKit
import MobileCoreServices

class ChatVC: JSQMessagesViewController, MessageReceivedDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    private var messages = [JSQMessage]()
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        MessagesHandler.Instance.delegate = self
        
        // Do any additional setup after loading the view.
        
        // set senderID and sender display name
        self.senderId = AuthProvider.Instance.getUID()
        self.senderDisplayName = AuthProvider.Instance.userName
        
        // call observe message func
        MessagesHandler.Instance.observeMessage()
    }
    
    // Start collection view funcions
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        let message = messages [indexPath.item]
        
        if message.senderId == self.senderId{
            return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
        }else{
            return bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.blue)
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "ProfileImg"), diameter: 30)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        let msg = messages[indexPath.item]
        if msg.isMediaMessage{
            if let mediaItem = msg.media as? JSQVideoMediaItem{
                let player = AVPlayer(url: mediaItem.fileURL)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self.present(playerController, animated: true, completion: nil)
            }else if let imageItem = msg.media as? UIImage{
                // TODO: Enlarge photo to full screen by clicking the photo in the bubble
//                let imageView = UIImageView(image: imageItem)
//                imageView.frame = UIScreen.main.bounds
//                imageView.backgroundColor = UIColor.black
//                imageView.contentMode = .scaleAspectFill
//                imageView.isUserInteractionEnabled = true
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    } // End collection view functions
    
    
    // Sending buttons functions
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        MessagesHandler.Instance.sendMessage(senderID: senderId, senderName: senderDisplayName, text: text)
        
        collectionView.reloadData()
        
        // remove the text from the text field
        finishSendingMessage()
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        let alert = UIAlertController(title: "Media Messages", message: "Please Select A Media", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let photo = UIAlertAction(title: "Photos", style: .default) { (alert: UIAlertAction) in
            self.chooseMedia(type: kUTTypeImage)
        }
        let video = UIAlertAction(title: "Videos", style: .default) { (alert: UIAlertAction) in
            self.chooseMedia(type: kUTTypeMovie)
        }
        alert.addAction(cancel)
        alert.addAction(photo)
        alert.addAction(video)
        present(alert, animated: true, completion: nil)
    }
    // End sending butons functions
    
    // Picker view functions
    private func chooseMedia(type:CFString){
        picker.mediaTypes = [type as String]
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pic = info[UIImagePickerControllerOriginalImage] as? UIImage{
           
            let img = JSQPhotoMediaItem(image:pic)
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: img))
        }else if let vidURL = info[UIImagePickerControllerMediaURL] as? URL{
            
            let vid = JSQVideoMediaItem(fileURL: vidURL, isReadyToPlay: true)
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: vid))
        }
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    // End picker view functions
    
    // Delegation function
    func messageReceived(senderID: String, text: String) {
        messages.append(JSQMessage(senderId: senderID, displayName: "empty", text: text + "abc"))
        collectionView.reloadData()
    }

    @IBAction func backToContactButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
