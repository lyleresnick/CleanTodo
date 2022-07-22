
enum NetworkIssue {
    case noNetwork
    case unknown(Int?, String)
}

enum Response<Entity, DomainIssue> {
    case success(entity: Entity)
    case failure(description: String)
    case domain(issue: DomainIssue)
    case networkIssue(issue: NetworkIssue)
}
