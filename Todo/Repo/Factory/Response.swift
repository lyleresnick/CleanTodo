
enum DataSource {
    case test
    case coreData
    case networked
}

enum Response<Entity, DomainIssue> {
    case success(entity: Entity)
    case failure(source: DataSource?, description: String)
    case domain(issue: DomainIssue)
}
