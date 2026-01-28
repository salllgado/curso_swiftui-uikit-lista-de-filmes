//
//  MainListViewModel.swift
//  MovieList
//
//  Created by Chrystian Salgado on 28/01/26.
//

import Foundation

protocol MainListViewModelDelegate: AnyObject {
    func displayData(values: [Movies])
}

protocol MainListViewModelProtocol: AnyObject {
    var delegate: MainListViewModelDelegate? { get set }
    func loadData()
}

final class MainListViewModel: MainListViewModelProtocol {
    
    weak var delegate: MainListViewModelDelegate?
    
    // MARK: - Public methods
    func loadData() {
        requestPopularFilms()
    }
}

extension MainListViewModel {
    
    /*
     curl --request GET \
          --url 'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1' \
          --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMTY5NGMxOTllYzI2ODM0NmU2MzdiYzA0MGZhZDUxOCIsIm5iZiI6MTU1ODg5MTQ2Ni41ODYsInN1YiI6IjVjZWFjYmNhMGUwYTI2NjQzZmNkMzViMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DfLd7Z-h7dMuvZF5w-WNW-RfOWtky6qolFzHbAUPKp4' \
          --header 'accept: application/json'
     */
    func requestPopularFilms() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")!
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMTY5NGMxOTllYzI2ODM0NmU2MzdiYzA0MGZhZDUxOCIsIm5iZiI6MTU1ODg5MTQ2Ni41ODYsInN1YiI6IjVjZWFjYmNhMGUwYTI2NjQzZmNkMzViMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DfLd7Z-h7dMuvZF5w-WNW-RfOWtky6qolFzHbAUPKp4", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data {
                do {
                    let popularFilmsResponse = try JSONDecoder().decode(PopularFilmsResponse.self, from: data)
                    print(String(data: data, encoding: .utf8))
                    DispatchQueue.main.async {
                        self.delegate?.displayData(values: popularFilmsResponse.results)
                    }
                } catch {
                    print("erro ao decodificar")
                }
            } else {
                print("algo deu errado")
            }
        })
        task.resume()
    }
}

struct Movies: Codable {
    let title: String
}

struct PopularFilmsResponse: Codable {
    let results: [Movies]
}
