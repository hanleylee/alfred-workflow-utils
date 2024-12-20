import Foundation

public enum ItemTextType {
    case copy
    case largetype
}

public enum ItemType: String, Codable {
    case `default`
    case file
    case fileSkipcheck
}

public final class Item: HasSubtitle, HasArg, HasIcon, HasVariables, HasValidity {
    public var title: String
    public var subtitle: String?
    public var arg: String?
    private var autocomplete: String?
    private var uid: String?
    var match: String?
    private var quicklookurl: String?
    private var type: String?
    public var valid: Bool?
    public var icon: Icon?
    private var text: [String: String]?
    public var variables: [String: String]?
    private var mods: [String: Mod]?

    public init(title: String) {
        self.title = title
    }

    @discardableResult
    public func autocomplete(_ autocomplete: String) -> Item {
        self.autocomplete = autocomplete

        return self
    }

    @discardableResult
    public func uid(_ uid: String) -> Item {
        self.uid = uid

        return self
    }

    @discardableResult
    public func match(_ match: String) -> Item {
        self.match = match

        return self
    }

    @discardableResult
    public func quicklookurl(_ quicklookurl: String) -> Item {
        self.quicklookurl = quicklookurl

        return self
    }

    @discardableResult
    public func type(_ type: ItemType) -> Item {
        switch type {
        case .file:
            self.type = "file"
        case .fileSkipcheck:
            self.type = "file:skipcheck"
        default:
            self.type = "default"
        }

        return self
    }

    @discardableResult
    public func text(_ text: String, for: ItemTextType) -> Item {
        if self.text == nil {
            self.text = [:]
        }

        switch `for` {
        case .copy:
            self.text?["copy"] = text
        case .largetype:
            self.text?["largetype"] = text
        }

        return self
    }

    @discardableResult
    public func mods(_ mods: Mod...) -> Item {
        for mod in mods {
            self.mod(mod)
        }

        return self
    }

    @discardableResult
    public func mod(_ mod: Mod) -> Item {
        mods = mods ?? [:]
        mods?[String(describing: Swift.type(of: mod)).lowercased()] = mod

        return self
    }
}

extension Item: Codable { }

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.arg == rhs.arg
            && lhs.autocomplete == rhs.autocomplete
            && lhs.uid == rhs.uid
            && lhs.match == rhs.match
            && lhs.quicklookurl == rhs.quicklookurl
            && lhs.type == rhs.type
            && lhs.valid == rhs.valid
            && lhs.icon == rhs.icon
            && lhs.text == rhs.text
            && lhs.variables == rhs.variables
            && lhs.mods == rhs.mods
    }
}
