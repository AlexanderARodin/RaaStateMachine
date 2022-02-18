//
//  RaaState.swift
//  
//
//  Created by the Dragon on 18.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//



public protocol RaaState {
	static func isTransitionAllowed(from prevState: RaaState, to nextState: RaaState ) -> Bool
	func willExit( to nextState: RaaState)
	func didEnter( from prevState: RaaState)
}

public extension RaaState {
	func willExit( to nextState: RaaState) {}
	func didEnter( from prevState: RaaState) {}
}
