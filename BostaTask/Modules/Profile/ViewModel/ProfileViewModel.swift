//
//  ProfileViewModel.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import Foundation
import RxSwift
import RxRelay

class ProfileViewModel {
    private let apiManager = APIServiceManager()
    private let disposeBag = DisposeBag()
    
    let user: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    let albums: BehaviorRelay<[Album]> = BehaviorRelay(value: [])
    
    func fetchUsers() {
        apiManager.fetch(.getUsers, model: [User].self)
            .subscribe(onSuccess: { [weak self] users in
                guard let self = self, let randomUser = users.randomElement() else { return }
                print("Random User: \(String(describing: randomUser))")
                self.user.accept(randomUser)
                self.fetchAlbums(for: randomUser.id)
                
            }, onFailure: { error in
                print("Error fetching users:", error)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchAlbums(for userId: Int) {
        apiManager.fetch(.getAlbums(userId: userId), model: [Album].self)
            .subscribe(onSuccess: { [weak self] albums in
                print("Fetched Albums: \(albums)")
                self?.albums.accept(albums)
            }, onFailure: { error in
                print("Error fetching albums:", error)
            })
            .disposed(by: disposeBag)
    }
}
