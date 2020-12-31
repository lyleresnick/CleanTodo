
enum ManagerResponse<Entity, FailureSource, SemanticEvent> {
    case success(entity: Entity)
    case failure(source: FailureSource, code: Int, description: String)
    case semantic(event: SemanticEvent)
}
