//
//  ViewController.swift
//  LowesInterViewWeeChu
//
//  Created by Coding on 9/19/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField! {
        didSet{
            searchTextField.setLeftIcon(imageName: "magnifyingglass")
        }
    }
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var movieTableView: UITableView!
    
    let viewModel = ViewControllerViewModel()
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.color = .blue
        spinner.style = .large
        return spinner
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        searchTextField.delegate = self
        spinner.center = self.view.center
        view.addSubview(spinner)
        viewModel.reloadTable = {[weak self] in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
                self?.spinner.stopAnimating()
                self?.view.isUserInteractionEnabled = true
            }
        }
        
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        performSearch()
    }
    
    // MARK: Perform search function - with text entered in search text field
    func performSearch() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
        guard let text = searchTextField.text else {
            return
        }
        
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        viewModel.fetchMovieData(searchTerm: text)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        let movies = viewModel.getMovieCells()
        cell.movieTitleLabel.text = movies[indexPath.row].title
        cell.movieReleaseDateLabel.text = movies[indexPath.row].release_date
        cell.movieRatingLabel.text = String(movies[indexPath.row].vote_average)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieTableView.deselectRow(at: indexPath, animated: true)
        
        let movies = viewModel.getMovieCells()
        let movie = movies[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieDetails") as! MovieDetailsViewController
        vc.movieName = movie.title
        vc.releaseDate = movie.release_date
        vc.overview = movie.overview
        vc.imagePath = movie.poster_path
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    
    // MARK: Keyboard return button connect to search function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSearch()
        return true
    }
}


