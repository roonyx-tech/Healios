struct PostInfo {
    let user: User
    let comments: [Comment]
    let post: Post
    
    init(user: User, comments: [Comment], post: Post) {
        self.user = user
        self.comments = comments
        self.post = post
    }
}
