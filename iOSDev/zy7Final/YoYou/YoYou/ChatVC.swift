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
import SDWebImage

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
        MessagesHandler.Instance.observeMediaMessages()
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
                // Enlarge photo to full screen by clicking the photo in the bubble

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
           
            let data = UIImageJPEGRepresentation(pic, 0.01)
            
            MessagesHandler.Instance.sendMedia(image: data, video: nil, senderID: senderId, senderName: senderDisplayName)
        }else if let vidURL = info[UIImagePickerControllerMediaURL] as? URL{
            
            MessagesHandler.Instance.sendMedia(image: nil, video: vidURL, senderID: senderId, senderName: senderDisplayName)
        }
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    // End picker view functions
    
    // Delegation function
    func messageReceived(senderID: String, text: String) {
        messages.append(JSQMessage(senderId: senderID, displayName: "empty", text: text))
        collectionView.reloadData()
    }
    
    func mediaReceived(senderID: String, senderName: String, url: String) {
        if let mediaURL = URL(string: url){
            
            do {
                let data = try Data(contentsOf: mediaURL)
                if let _ = UIImage(data: data){
                    let _ = SDWebImageDownloader.shared().downloadImage(with: mediaURL, options: [], progress: nil, completed: {
                        (image, data, error, finished) in
                        
                        DispatchQueue.main.async {
                            let photo = JSQPhotoMediaItem(image: image)
                            if senderID == self.senderId {
                                photo?.appliesMediaViewMaskAsOutgoing = true
                            }else{
                                photo?.appliesMediaViewMaskAsOutgoing = false
                            }
                            
                            self.messages.append(JSQMessage(senderId: senderID, displayName: senderName, media: photo))
                            self.collectionView.reloadData()
                        }
                    })
                }else{
                    let video = JSQVideoMediaItem(fileURL: mediaURL, isReadyToPlay: true)
                    if senderID == self.senderId {
                        video?.appliesMediaViewMaskAsOutgoing = true
                    }else{
                        video?.appliesMediaViewMaskAsOutgoing = false
                    }
                    messages.append(JSQMessage(senderId: senderID, displayName: senderName, media: video))
                    self.collectionView.reloadData()
                }
            } catch {
                
            }
        }
    }

    @IBAction func backToContactButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
