//
//  PokedexView.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 10/08/25.
//

import SwiftUI

struct PokedexView: View {
    
    @StateObject var viewModel = PokedexViewModel()
    @State private var selectedPokemon: String?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            ColorUtils.primary
                .ignoresSafeArea(edges: .all)
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Image("pokeball")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 16)
                        .foregroundColor(ColorUtils.white)
                    Text("Pokedex")
                        .font(FontUtils.headerHeadline)
                        .foregroundColor(ColorUtils.white)
                    Spacer()
                }
                .padding(.leading, 16)
                
                HStack(spacing: 0) {
                    SearchBoxComponent(text: $viewModel.searchText)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    
                    SortButtonComponent(isSorted: .constant(false))
                        .padding(.trailing, 16)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(ColorUtils.white)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(viewModel.filteredPokemons, id: \.id) { item in
                                Button {
                                    selectedPokemon = item.name
                                } label: {
                                    PokemonCardComponent(
                                        name: item.name,
                                        imageURL: item.imageURL,
                                        idTag: item.id ?? ""
                                    )
                                }
                            }
                        }
                        .padding()
                        .background(
                            NavigationLink(
                                destination: selectedPokemon.map { PokemonView(viewModel: PokemonViewModel(name: $0)) },
                                isActive: Binding(
                                    get: { selectedPokemon != nil },
                                    set: { if !$0 { selectedPokemon = nil } }
                                )
                            ) {
                                EmptyView()
                            }
                                .hidden()
                        )
                    }
                }
                .padding(8)
            }
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView(viewModel:  {
            let vm = MockPokedexViewModel()
            vm.fetchPokedex()
            return vm
        }())
    }
}
