//
//  LocationItem.swift
//  Wikipedia Places App
//
//  Created by Divine Dube on 29/01/2026.
//

import SwiftUI

struct PlacesItemView: View {
    let location: LocationModel
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack {
                Text(location.name)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }
}
