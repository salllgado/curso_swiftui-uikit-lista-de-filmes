//
//  MovieCellView.swift
//  MovieList
//
//  Created by Chrystian Salgado on 27/01/26.
//

import SwiftUI

struct MovieCellView: View {
    
    let movieTitle: String
    
    var body: some View {
        HStack {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.brown)
            Text(movieTitle)
                .lineLimit(2)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.brown)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

#Preview {
    MovieCellView(movieTitle: "Vingadores")
}
