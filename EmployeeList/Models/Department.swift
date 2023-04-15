import Foundation

public struct Department: Identifiable {
    public let id = UUID()
    public let title: String
    public let workers: [UUID]
}
