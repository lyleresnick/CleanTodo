
enum Response<Entity, DomainIssue> {
    case success(entity: Entity)
    case failure(description: String)
    case domain(issue: DomainIssue)
}
