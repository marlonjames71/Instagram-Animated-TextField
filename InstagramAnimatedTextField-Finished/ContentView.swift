//
//  ContentView.swift
//  InstagramAnimatedTextField-Finished
//
//  Created by Marlon Raskin on 2023-05-23.
//

import SwiftUI

struct ContentView: View {
	
	@State private var text = ""
	
	private let example: Example = .shopping
	
	var body: some View {
		NavigationView {
			VStack(spacing: 4) {
				HStack {
					Text(example.title).font(.callout)
					Spacer()
				}
				.padding(.leading, 6)
				
				HintTextField(
					icon: Image(systemName: "magnifyingglass"),
					text: $text,
					inactivePlaceholder: example.inactivePlaceholder,
					activePlaceholder: example.activePlaceholder,
					hints: example.hints
				)
				.padding(.vertical, 10)
				.padding(.horizontal, 16)
				.background(.regularMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
				.frame(maxHeight: 60)
				
				Spacer()
			}
			.padding()
			.background(
				LinearGradient(
					colors: [.indigo, .teal, .cyan, .blue],
					startPoint: .top,
					endPoint: .bottom
				)
				.ignoresSafeArea()
				.ignoresSafeArea(.keyboard, edges: .bottom)
			)
			.navigationTitle("Discover")
		}
	}
	
	enum Example {
		case shopping
		case locationSearch
		
		var title: String {
			switch self {
			case .shopping:
				return "Search for Products"
			case .locationSearch:
				return "Place of Interest"
			}
		}
		
		var activePlaceholder: String {
			switch self {
			case .shopping:
				return "Search"
			case .locationSearch:
				return "Ex:"
			}
		}
		
		var inactivePlaceholder: String {
			switch self {
			case .shopping:
				return "Search"
			case .locationSearch:
				return "Ex: 123 Clark St"
			}
		}
		
		var hints: [String] {
			switch self {
			case .shopping:
				return ExampleHints.items
			case .locationSearch:
				return ExampleHints.locations
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
