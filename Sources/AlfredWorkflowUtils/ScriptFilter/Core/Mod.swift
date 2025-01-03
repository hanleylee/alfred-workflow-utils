public class Mod: HasSubtitle, HasArg, HasIcon, HasVariables, HasValidity, Codable {
    public var subtitle: String?
    public var arg: String?
    public var valid: Bool?
    public var icon: Icon?
    public var variables: [String: String]?

    public init() {}
}

extension Mod: Equatable {
    public static func == (lhs: Mod, rhs: Mod) -> Bool {
        lhs.subtitle == rhs.subtitle
            && lhs.arg == rhs.arg
            && lhs.valid == rhs.valid
            && lhs.icon == rhs.icon
            && lhs.variables == rhs.variables
    }
}

public class Ctrl: Mod {}
public class Cmd: Mod {}
public class Alt: Mod {}
public class Fn: Mod {}
public class Shift: Mod {}
