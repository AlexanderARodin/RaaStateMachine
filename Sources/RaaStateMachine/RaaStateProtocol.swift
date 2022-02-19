//
//  RaaState.swift
//  
//
//  Created by the Dragon on 18.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//



public protocol RaaState {
	associatedtype StateType
	
	func isValidNextState<StateType>(_ nextState: StateType ) -> Bool
}

