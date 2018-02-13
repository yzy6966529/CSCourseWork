// DetailViewController.swift
// Displays search results for selected query
import UIKit

// inherits from UIViewController and uses the UIWebViewDelegate protocol
class DetailViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView! // displays search results
    var detailItem: URL? // URL that will be displayed

    // configure DetailViewController as the webView's delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
    }
    
    // when view appears, the url is loaded in the UIWebView.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let url = self.detailItem {
            webView.loadRequest(URLRequest(url: url))
        }
    }
    
    // stop page load and hide network activity indicator when 
    // returning to MasterViewController
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared
            . isNetworkActivityIndicatorVisible = false
        webView.stopLoading()
    }

    // when loading starts, show network activity indicator
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared
            . isNetworkActivityIndicatorVisible = true
    }

    // hide network activity indicator when page finishes loading
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared
            . isNetworkActivityIndicatorVisible = false
    }
    
    // This function is called if a webpage fails to properly load in the UIWebView.
    func webView(_ webView: UIWebView,
        didFailLoadWithError error: Error) {
        webView.loadHTMLString(
            "<html><body><p>An error occurred when performing " +
            "the Twitter search: " + "\(error)" +
            "</body></html>", baseURL: nil)
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
