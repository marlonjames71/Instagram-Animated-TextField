//
//  ExampleHintData.swift
//  InstagramAnimatedTextField-Finished
//
//  Created by Marlon Raskin on 2023-05-24.
//

import Foundation

// MARK: - Hint

enum ExampleHints {
	static let items = [
		"watercolor",
		"home spa",
		"jazz guitar",
		"tie dye",
		"edc",
		"running shoes",
		"water bottle"
	]
	
	static let locations: [String] = [
		"3rd st promenade",
		"Los Angeles",
		"1234 Highland Ave",
		"LAX",
		"Crypto.com Arena"
	]
	
	static let numbers: [String] = (0...4).map(String.init(describing:))
}

// MARK: - Examples

struct Example {
	let title: String
	let activePlaceholder: String
	let inactivePlaceholder: String
	let hints: [String]
}

extension Example {
	static let shopping: Self = .init(
		title: "Search for Products",
		activePlaceholder: "Search",
		inactivePlaceholder: "Search",
		hints: ExampleHints.items
	)
}

extension Example {
	static let locationSearch: Self = .init(
		title: "Place of Interest",
		activePlaceholder: "Ex:",
		inactivePlaceholder: "Ex: 123 Clark St",
		hints: ExampleHints.locations
	)
}

extension Example {
	static let numbers: Self = .init(
		title: "Index",
		activePlaceholder: "Index:",
		inactivePlaceholder: "Index",
		hints: ExampleHints.numbers
	)
}
