//
//  Comment.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation

struct Comment {
    var commentId: String
    var commentTime: String
    var contents: String
    /// - 각 댓글에서 남긴 별점으로 totalPerfumeScore에 더해지고 빼지는 값입니다.
    /// - 댓글에서 몆점을 주었는지 표시할 예정입니다.
    var perfumeScore: Int
    /// - 댓글의 작성자를 확인하여 수정, 삭제 권한을 확인
    var writerId: String
    var writerNickName: String
    var writerImage: String
}
