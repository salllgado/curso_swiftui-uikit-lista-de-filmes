//
//  MovieUITableViewCell.swift
//  MovieList
//
//  Created by Chrystian Salgado on 27/01/26.
//

import UIKit
import SwiftUI

final class MovieUITableViewCell: UITableViewCell {
    
    func setup(movie: MovieModel) {
        self.contentConfiguration = UIHostingConfiguration {
            MovieCellView(movie: movie)
        }
    }
}
