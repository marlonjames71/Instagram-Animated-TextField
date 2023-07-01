//
//  HintTextField.swift
//  InstagramAnimatedTextField-Finished
//
//  Created by Marlon Raskin on 2023-05-24.
//

import SwiftUI

struct HintTextField: View {
	
	let icon: Image?
	@Binding var text: String
	let inactivePlaceholder: String
	let activePlaceholder: String
	let hints: [String]
	let startIndex: HintCarouselView.StartIndex
	
	let onEditingChanged: ((Bool) -> Void)?
	
	@State private var showingCarousel = false
	@State private var isEditing = false
	
	init(
		icon: Image?,
		text: Binding<String>,
		inactivePlaceholder: String,
		activePlaceholder: String,
		hints: [String],
		startIndex: HintCarouselView.StartIndex = .first,
		onEditingChanged: ((Bool) -> Void)? = nil
	) {
		self.icon = icon
		self._text = text
		self.inactivePlaceholder = inactivePlaceholder
		self.activePlaceholder = activePlaceholder
		self.hints = hints
		self.startIndex = startIndex
		self.onEditingChanged = onEditingChanged
	}
	
	// MARK: - Body
	
	var body: some View {
		ZStack {
			HStack {
				if let icon {
					icon
						.foregroundStyle(.secondary)
						.opacity(isEditing ? 1 : 0.6)
						.scaleEffect(isEditing ? 1 : 0.9)
				}
				
				ZStack {
					if showingCarousel {
						HintCarouselView(placeholder: activePlaceholder, hints: hints, startIndex: startIndex)
					}
					
					HStack {
						TextField(placeholder, text: $text.animation(springAnimation)) { isEditing in
							showingCarousel = isEditing && text.isEmpty
							withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0)) {
								self.isEditing = isEditing
							}
							onEditingChanged?(isEditing)
						}
						.textInputAutocapitalization(.never)
						.onChange(of: text) { newValue in
							showingCarousel = newValue.isEmpty && isEditing
						}
						
						Spacer()
						
						if !text.isEmpty && isEditing {
							Button(action: clearText) {
								Image(systemName: "xmark.circle.fill")
									.foregroundStyle(.secondary)
									.tint(.secondary)
							}
							.frame(width: 22, height: 22)
							.animation(.default, value: text)
							.transition(buttonTransition(edge: .trailing).combined(with: .opacity))
						}
					}
				}
			}
		}
	}
	
	// MARK: - Helpers
	
	private func clearText() {
		withAnimation(springAnimation) { text = "" }
	}
	
	private var placeholder: String {
		isEditing ? "" : inactivePlaceholder
	}
	
	private func buttonTransition(edge: Edge) -> AnyTransition {
		AnyTransition.asymmetric(
			insertion: .move(edge: edge).combined(with: .opacity),
			removal: .move(edge: edge).combined(with: .opacity)
		)
	}
	
	private var springAnimation: Animation {
		.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)
		.delay(0.15)
	}
}

// MARK: - Previews -

struct HintTextField_Previews: PreviewProvider {
	static var previews: some View {
		HintTextField(
			icon: Image(systemName: "magnifyingglass"),
			text: .constant(""),
			inactivePlaceholder: "Search",
			activePlaceholder: "Search",
			hints: ExampleHints.shopping
		)
	}
}
