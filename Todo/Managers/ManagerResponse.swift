
enum ManagerResponse<Entity, FailureSource, SemanticErrorReason> {
    case success(entity: Entity)
    case failure(source: FailureSource, code: Int, description: String)
    case semanticError(reason: SemanticErrorReason)
}
