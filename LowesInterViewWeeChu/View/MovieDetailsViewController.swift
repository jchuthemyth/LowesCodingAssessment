//
//  MovieDetailsViewController.swift
//  LowesInterViewWeeChu
//
//  Created by Coding on 9/20/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescription: UITextView!
    
    let imageManager = ImageManager()
    
    var movieName: String? = ""
    var releaseDate: String? = ""
    var overview: String? = ""
    var imagePath: String? = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movieName
        movieReleaseDate.text = "Release Date : \(releaseDate ?? "Not Available")"
        movieDescription.text = overview
        
        guard let imagePath = imagePath else {
            return
        }

        imageManager.getImage(imagePath: imagePath) {[weak self] image, error in
            DispatchQueue.main.async {
                self?.movieImageView.image = image
            }
        }
    }

}
