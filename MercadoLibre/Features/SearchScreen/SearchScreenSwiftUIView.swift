//
//  SearchSwiftUIView.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 5/10/20.
//

import SwiftUI

class SearchScreenViewDelegate: ObservableObject {
    @Published var query: String = ""
    @Published var list: [SearchModel] = []
    @Published var error: Error?
    @Published var model: SearchModel?
}

struct SearchScreenSwiftUIView: View {
    @ObservedObject var delegate: SearchScreenViewDelegate
    @State private var searchQuery: String = String()
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                searchBar
                ScrollView {
                    if let error = delegate.error {
                        Text(error.localizedDescription)
                    }
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 75, maximum: 350), spacing: 12, alignment: .top),
                        GridItem(.flexible(minimum: 75, maximum: 350), spacing: 12, alignment: .top),
                        GridItem(.flexible(minimum: 75, maximum: 350), alignment: .top)
                    ], alignment: .leading, spacing: 16, content: {
                        ForEach (delegate.list, id: \.self) { item in
                            SearchScreenCell(item: item)
                                .onTapGesture {
                                    delegate.model = item
                                }
                        }
                    }).padding(.horizontal, 12)
                }
                
            }.navigationBarTitle("Mercado Libre")
        }
    }
    
    var searchBar: some View {
        HStack{
            HStack {
                TextField("Buscar en Mercado Libre...", text: $searchQuery, onCommit: {
                    self.delegate.query = searchQuery
                }).padding(.leading, 24)
            }.padding()
            .background(Color(.systemGray3))
            .cornerRadius(6)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching {
                        Button(action: {
                            searchQuery = String()
                            delegate.query = String()
                            delegate.error = nil
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                }.padding(.horizontal, 32)
                .foregroundColor(.gray)
            ).transition(.move(edge: .trailing))
            .animation(.spring())
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    delegate.list = []
                    searchQuery = String()
                    delegate.query = String()
                    delegate.error = nil
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancelar")
                        .padding(.trailing)
                        .padding(.leading, -12)
                }).transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
}

struct SearchScreenCell: View {
    
    let item: SearchModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            CLImage(urlString: item.thumbnail)
                .scaledToFit()
                .cornerRadius(12)
            Text(item.title)
                .font(.system(size: 10, weight: .semibold))
                .padding(.top, 4)
            Text("\(item.price)")
                .font(.system(size: 9, weight: .regular))
            Text(item.id)
                .font(.system(size: 9, weight: .regular))
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct SearchScreenSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreenSwiftUIView(delegate: SearchScreenViewDelegate())
            .preferredColorScheme(.dark)
    }
}
