//
//  WrapperMode.swift
//  
//
//  Created by the Dragon on 19.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//



@propertyWrapper
public struct StateMachine<State: StateProtocol> {
	private var machine:RaaStateMachine<State>
	public var wrappedValue:State {
		get {machine.state}
		set {machine.enter(newValue)}
	}
	public var projectedValue:RaaStateMachine<State> {machine}
	
	public init( wrappedValue: State) {
		self.machine = RaaStateMachine(with: wrappedValue)
	}
}
