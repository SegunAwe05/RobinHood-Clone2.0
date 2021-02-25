//
//  searchBar.swift
//  StockProject
//
//  Created by Segun Awe on 2/13/21.
//

import SwiftUI

struct searchBar: View {
    @Binding var text: String
    @State private var isEditing = false
 
    func dismissKey() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        HStack {
            TextField("Search AAPL, AMZN, GME", text: $text)
                .foregroundColor(.white)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color.green)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .modifier(BarShadows())
                .onTapGesture {
                    isEditing = true
                }
            
                Button(action: {
                    dismissKey()
                    isEditing = false
                    self.text = ""
                    
                }) {
                    Text("Cancel")
                        .foregroundColor(.green)
                }
               .padding(.trailing, 10)

        }
    }
}

struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        searchBar(text: .constant(""))
    }
}

struct BarShadows: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.4), radius: 10, x: -5, y: -5)
        
    }
}
