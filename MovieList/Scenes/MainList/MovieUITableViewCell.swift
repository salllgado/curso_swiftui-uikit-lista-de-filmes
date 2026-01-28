//
//  MovieUITableViewCell.swift
//  MovieList
//
//  Created by Chrystian Salgado on 27/01/26.
//

import UIKit
import SwiftUI

class MovieUITableViewCell: UITableViewCell {
    
    func setup(movieTitle: String) {
        self.contentConfiguration = UIHostingConfiguration {
            MovieCellView(movieTitle: movieTitle)
        }
    }
}
