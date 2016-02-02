//
//  MovieDetailView.swift
//  movieApp
//
//  Created by beth hayes on 1/26/16.
//  Copyright © 2016 abraxas creative. All rights reserved.
//

import UIKit

class MovieDetailView: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var movieImgViewer: UIImageView!
    @IBOutlet var movieDetailsArea: UIScrollView!
    
    var transferText = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("this is the next page", transferText)
        
        //titleLabel.text = transferText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
