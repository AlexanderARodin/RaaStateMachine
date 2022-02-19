import XCTest

@testable import RaaStateMachine
//	//	//	//	//	//	//	//



final class RaaStateMachineTests: XCTestCase {
	
	func testSimpleTransitions() throws {
		let stateMachine = RaaStateMachine(with: StateA.one)
		XCTAssert(stateMachine.state == .one)
		XCTAssert(stateMachine.isValidNextState(.one))
		XCTAssert(stateMachine.isValidNextState(.two))
		XCTAssert(stateMachine.isValidNextState(.three(i: 3)))
		XCTAssert(stateMachine.isValidNextState(.three(i: 4)))
		XCTAssert(stateMachine.attemptToEnter( .three(i: 5)) )
		XCTAssert(stateMachine.state == .three(i: 5))
		XCTAssert(stateMachine.state != .one)
		XCTAssert(stateMachine.state != .two)
		XCTAssert(stateMachine.state != .three(i: 2))
		
		XCTAssert(stateMachine.isValidNextState(.one))
		XCTAssert(stateMachine.isValidNextState(.two))
		XCTAssert(stateMachine.isValidNextState(.three(i: 3)))
		XCTAssert(!stateMachine.isValidNextState(.three(i: 10)))
		XCTAssert(!stateMachine.attemptToEnter( .three(i: 15)) )
		XCTAssert(stateMachine.state == .three(i: 5))
		XCTAssert(stateMachine.attemptToEnter( .two) )
		XCTAssert(stateMachine.state == .two)
	}
	
	
}


extension RaaStateMachineTests {
	override func setUpWithError() throws {
		suppressLogs = false
		raaLog("")
		raaLog("---->")
	}
	override func tearDownWithError() throws {
		suppressLogs = false
		raaLog("###############################")
		raaLog("")
	}
}


enum StateA: RaaState {
	static func !=(left: StateA, right: StateA) -> Bool {
		!(left == right)
	}
	static func ==(left: StateA, right: StateA) -> Bool {
		switch (left, right) {
		case (one, one), (two, two):
			return true
		case ( three(let i1), three(let i2) ):
			return i1 == i2
		default:
			return false
		}
	}
	static func isTransitionAllowed(from prevState: RaaState, to nextState: RaaState) -> Bool {
		guard let nextState = nextState as? StateA else {return false}
		switch nextState {
		case .three(let i):
			return i < 10
		default:
			return true
		}
	}
	
	
	case one
	case two
	case three( i: Int)
}
