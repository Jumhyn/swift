// RUN: %target-typecheck-verify-swift -swift-version 5

struct ImplicitMembers: Equatable {

    static var optional: ImplicitMembers? = ImplicitMembers()
}

let _: ImplicitMembers? = .optional

