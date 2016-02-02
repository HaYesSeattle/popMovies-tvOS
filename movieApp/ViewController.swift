//
//  ViewController.swift
//  movieApp
//
//  Created by beth hayes on 1/26/16.
//  Copyright © 2016 abraxas creative. All rights reserved.
//

import UIKit
//UICollectoinViewDelegate
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
// delegate:    flowLayout: allows to set size
    let URL_BASE = "http://api.themoviedb.org/3/movie/popular?api_key=ff743742b3b6c89feb59dfc138b4c12f"
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // ideally dont do this here do it in download controller
        downloadData()
        
    }
    
    func downloadData() {
        let url = NSURL(string: URL_BASE)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) ->
            Void in
            
            if error != nil{
                print(error.debugDescription)
            } else {
                do {
                    // dictionary
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? Dictionary<String, AnyObject>
                    
                    if let results = dict! ["results"] as? [Dictionary<String, AnyObject>] {
                        for obj in results {
                            let movie = Movie(movieDict: obj)
                            self.movies.append(movie)
                        }
                        //Main UI Thread
                        dispatch_async(dispatch_get_main_queue()) {
                            self.collectionView.reloadData()
                            
                        }
                        
                    }
                } catch {
                    
                }
                
            }
            
        }
        task.resume()
        
    }

   

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell =
            collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCell {
                
                let movie = movies[indexPath.row]
                cell.configureCell(movie)
                
        /// garg !!
                //this works great
                //let movieOverview = movie.overview
                //print(":::::::::", movieOverview)
        //
                
                if cell.gestureRecognizers?.count == nil{
                    
                    let tap = UITapGestureRecognizer(target: self, action: "tapped:")
                    
                    tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                    cell.addGestureRecognizer(tap)
                
                    
                }
                
                return cell
                
        } else {
            return MovieCell()
        }
        
    }
    
    func tapped (gesture: UITapGestureRecognizer){
        
        
        if let cell = gesture.view as? MovieCell {
            
//// garg!!!
            
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let vc = storyboard.instantiateViewControllerWithIdentifier("MovieDetailView") //as! UIViewController
            //self.presentViewController(vc, animated: true, completion: nil)
            
            
            // use sender to pass data
            let indexPath = collectionView.indexPathForCell(cell)
            let selectedMovie = movies[indexPath!.row]
//            print(selectedMovie.overview)
            
            //let str = vc
            performSegueWithIdentifier("goToMovieDetailView", sender: selectedMovie)
            
            
            
            // check movie.swift for some other garg changes that might not be needed
            
            // load the next view controller and pass the movie
            print ("tapped it!!!!!")
            
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(232, 337)
    }
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        
    }
    
   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this is where you do work right before the view loads
        // keep in mind - the next view controller has already been initialized
        if segue.identifier == "goToMovieDetailView" {
            if let detailVC = segue.destinationViewController as? MovieDetailView {
               print("second IF")
                if let selectedMovie = sender as? NSArray {
                    print("third IF")
                    //detailVC.transferText = selectedMovie
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

