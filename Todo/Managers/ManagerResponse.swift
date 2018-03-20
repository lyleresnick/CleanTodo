
enum ManagerResponse<Entity, SemanticErrorReason> {
    case success(entity: Entity)
    case failure(code: Int)
    case semanticError(reason: SemanticErrorReason)
}
