// RUN: %target-typecheck-verify-swift -swift-version 5

struct ImplicitGeneric<T> {
    static var implicit: ImplicitGeneric<T> { ImplicitGeneric<T>() }
    var another: ImplicitGeneric<T> { ImplicitGeneric<T>() }
    func getAnother() -> ImplicitGeneric<T> {
        ImplicitGeneric<T>()
    }
    static var implicitGenericInt: ImplicitGeneric<Int> { ImplicitGeneric<Int>() }
}

extension ImplicitGeneric where T == Int {
    static var implicitInt: ImplicitGeneric<Int> { ImplicitGeneric<Int>() }
    static var implicitString: ImplicitGeneric<String> { ImplicitGeneric<String>() }
    var anotherInt: ImplicitGeneric<Int> { ImplicitGeneric<Int>() }
    var anotherIntString: ImplicitGeneric<String> { ImplicitGeneric<String>() }
    func getAnotherInt() -> ImplicitGeneric<Int> {
        ImplicitGeneric<Int>()
    }
}

extension ImplicitGeneric where T == String {
    static var implicitString: ImplicitGeneric<String> { ImplicitGeneric<String>() }
    var anotherString: ImplicitGeneric<String> { ImplicitGeneric<String>() }
    var anotherStringInt: ImplicitGeneric<Int> { ImplicitGeneric<Int>() }
    func getAnotherString() -> ImplicitGeneric<String> {
        ImplicitGeneric<String>()
    }
    func getAnotherStringInt() -> ImplicitGeneric<Int> {
        ImplicitGeneric<Int>()
    }
}

func implicit<T>(_ arg: ImplicitGeneric<T>) {}

implicit(.implicitInt)
implicit(.implicitGenericInt)
implicit(.implicit.anotherInt)
implicit(.implicit.anotherInt.another)
implicit(.implicit.another.anotherInt)
implicit(.implicit.getAnotherInt())
implicit(.implicit.another.getAnotherInt())
implicit(.implicit.getAnother().anotherInt)
implicit(.implicit.getAnotherInt())
implicit(.implicit.getAnother().getAnotherInt())
implicit(.implicitString.anotherStringInt)
let _: ImplicitGeneric<Int> = .implicitString.anotherStringInt
// Member types along the chain can have different generic arguments
implicit(.implicit.anotherIntString.anotherStringInt)

implicit(.implicit.anotherString.anotherStringInt)
implicit(.implicit.getAnotherString().anotherStringInt)
implicit(.implicit.anotherString.getAnotherStringInt())
implicit(.implicit.getAnotherString().getAnotherStringInt())

struct SomeError: Error {
    var code: Int
}

func process(_ callback: (Result<String, SomeError>) -> ()) {
    callback(.success(0).map { "\($0)" } .mapError { SomeError(code: $0.code + 1) })
}

func process2(_ callback: (Result<String, SomeError>) -> ()) {
    callback(.success(0).map { "\($0)" })
}

struct Adder<T: AdditiveArithmetic> {
    init(x: T, y: T) {}
    static func add<U: AdditiveArithmetic>(x: T, y: T) -> Adder<U> {
        print(x + y)
        return Adder<U>(x: .zero, y: .zero)
    }
}

let _: Adder<Int8> = .add(x: 128, y: 128)
