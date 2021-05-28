protocol HomeModule: Presentable {
    typealias OnElementTapped = (PostInfo) -> Void
    var onElementTapped: OnElementTapped? { get set }
}
