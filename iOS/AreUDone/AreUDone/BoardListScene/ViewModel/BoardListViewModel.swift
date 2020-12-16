//
//  BoardListViewModel.swift
//  AreUDone
//
//  Created by a1111 on 2020/11/25.
//

import Foundation

protocol BoardListViewModelProtocol {
  
  func bindingInitializeBoardListCollectionView(handler: @escaping ([Board]) -> Void)
  func bindingUpdateBoardListCollectionView(handler: @escaping ([Board]) -> Void)
  func bindingDidBoardTapped(handler: @escaping (Int) -> Void)
  func bindingEmptyIndicatorView(handler: @escaping (Bool) -> Void)
  
  func fetchBoardId(for board: Board)
  func changeBoardOption(option: FetchBoardOption)
  func fetchBoard()
}

final class BoardListViewModel: BoardListViewModelProtocol {
  
  // MARK: - Property
  
  private let boardService: BoardServiceProtocol
  
  private var initializeBoardListCollectionViewHandler: (([Board]) -> Void)?
  private var updateBoardListCollectionViewHandler: (([Board]) -> Void)?
  private var didBoardTappedHandler: ((Int) -> Void)?
  private var emptyIndicatorViewHandler: ((Bool) -> Void)?
  
  private var fetchBoardOption: FetchBoardOption = .myBoards {
    didSet {
      if oldValue != fetchBoardOption {
        fetchBoard()
      }
    }
  }

  
  // MARK: - Initializer
  
  init(boardService: BoardServiceProtocol) {
    self.boardService = boardService
  }
  
  
  // MARK: - Method
  
  func fetchBoardId(for board: Board) {
    didBoardTappedHandler?(board.id)
  }
  
  func changeBoardOption(option: FetchBoardOption) {
    fetchBoardOption = option
  }
  
  func fetchBoard() {
    boardService.fetchAllBoards() { result in
      switch result {
      case .success(let boards):
        if self.fetchBoardOption == .myBoards {
          self.updateBoardListCollectionViewHandler?(boards.fetchMyBoard())
          self.emptyIndicatorViewHandler?(boards.fetchMyBoard().isEmpty)
        } else {
          self.updateBoardListCollectionViewHandler?(boards.fetchInvitedBoard())
          self.emptyIndicatorViewHandler?(boards.fetchInvitedBoard().isEmpty)
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
}


// MARK: - Extension bindUI

extension BoardListViewModel {
  
  func bindingInitializeBoardListCollectionView(handler: @escaping ([Board]) -> Void) {
    initializeBoardListCollectionViewHandler = handler
  }
  
  func bindingUpdateBoardListCollectionView(handler: @escaping ([Board]) -> Void) {
    updateBoardListCollectionViewHandler = handler
  }
  
  func bindingDidBoardTapped(handler: @escaping (Int) -> Void) {
    didBoardTappedHandler = handler
  }
  
  func bindingEmptyIndicatorView(handler: @escaping (Bool) -> Void) {
    emptyIndicatorViewHandler = handler
  }
}
