//
//  AlbumDetailsViewModel.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import Foundation
import RxSwift
import RxRelay

class AlbumViewModel {
    private let apiManager = APIServiceManager()
    private let disposeBag = DisposeBag()
    
    let photos: BehaviorRelay<[Photo]> = BehaviorRelay(value: [])
    let filteredPhotos: BehaviorRelay<[Photo]> = BehaviorRelay(value: [])
    
    func fetchPhotos(for albumId: Int) {
        apiManager.fetch(.getPhotos(albumId: albumId), model: [Photo].self)
            .subscribe(onSuccess: { [weak self] photos in
                print("Fetched Photos: \(photos)")
                self?.photos.accept(photos)
                self?.filteredPhotos.accept(photos)
            }, onFailure: { error in
                print("Error fetching photos:", error)
            })
            .disposed(by: disposeBag)
    }
    
    func filterPhotos(by query: String) {
        guard !query.isEmpty else {
            filteredPhotos.accept(photos.value)
            return
        }
        
        let filteredItems = photos.value.filter { photo in
            photo.title.lowercased().contains(query.lowercased())
        }
        filteredPhotos.accept(filteredItems)
    }
}
