//
//  SettingsNavigationIdentifier.swift
//  Ice
//

/// An identifier used for navigation in the settings interface.
enum SettingsNavigationIdentifier: String, NavigationIdentifier {
    case general = "General"
    case menuBarLayout = "Menu Bar Layout"
    case menuBarAppearance = "Menu Bar Appearance"
    case hotkeys = "Hotkeys"
    case advanced = "Advanced"
    case about = "About"

    /// Localized display name for the identifier.
    var localized: String {
        switch self {
        case .general: String(localized: "General")
        case .menuBarLayout: String(localized: "Menu Bar Layout")
        case .menuBarAppearance: String(localized: "Menu Bar Appearance")
        case .hotkeys: String(localized: "Hotkeys")
        case .advanced: String(localized: "Advanced")
        case .about: String(localized: "About")
        }
    }
}
