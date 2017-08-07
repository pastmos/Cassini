//
//  ImageViewController.swift
//  Cassini
//
//  Created by Past on 06.08.17.
//  Copyright © 2017 Past. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController/*, UIScrollViewDelegate*/ {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 1
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    var imageURL : URL?{
        didSet{
            image = nil
            if view.window != nil{
            fetchImage()
            }
        }
    }
    
    private func fetchImage(){
        if let url = imageURL{
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents{
                image = UIImage(data: imageData)
                
            }
        }
    }
    
   fileprivate var imageView = UIImageView()
    
    private var image : UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if view.window == nil{
            fetchImage()
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURL = URL(string: "https://www-media.stanford.edu/wp-content/uploads/2017/03/24182714/about_landing-1.jpg")
    }


}


extension ImageViewController : UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


