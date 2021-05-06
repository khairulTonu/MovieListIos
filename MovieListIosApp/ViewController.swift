
import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    let movieViewModel = MovieVM()
    var movieList:[Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        tableView.tableFooterView = UIView()
        
        searchTextField.layer.borderWidth = 0.5
        searchTextField.layer.borderColor = UIColor.gray.cgColor
        
        movieViewModel.delegate = self
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        getMoviesBySearch(query: searchTextField.text ?? "")
    }
    
    
    func getMoviesBySearch(query: String) {
        DispatchQueue.main.async {
            Singleton.sharedInstance().showProgessBar()
            self.movieViewModel.getMovies(query: query)
        }
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.selectionStyle = .none
        cell.movieDescriptionLbl.text = movieList[indexPath.row].overview ?? "N/A"
        cell.titleLbl.text = movieList[indexPath.row].title ?? "N/A"
        if let posterUrl = movieList[indexPath.row].poster_path
        {
            cell.moviePoster?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(posterUrl)")) { (image, error, cache, urls) in
                        if (error != nil) {
                            cell.moviePoster.image = #imageLiteral(resourceName: "large_movie_poster")
                        } else {
                            cell.moviePoster.image = image
                        }
            }
            cell.moviePoster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(posterUrl)") )
        }
        cell.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        return cell
    }
}

extension ViewController : MovieListDelegate {
    func Success(_ Response: Movie) {
        DispatchQueue.main.async { [self] in
            Singleton.sharedInstance().hideProgessBar()
            self.movieList = Response.results ?? []
            print(movieList)
            self.tableView.reloadData()
        }
    }
    
    func Failure(_ message: String) {
        DispatchQueue.main.async {
            Singleton.sharedInstance().hideProgessBar()
            print(message)
        }
    }
    
    
}
