//
//  BookInfoController.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

import UIKit

class BookInfoController: UIViewController {

    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        // 제목 레이블 설정
        titleLabel.text = "모달 창"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
        // 레이블 추가 및 레이아웃 설정
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()  // 중앙에 배치
        }

        // 닫기 버튼 추가
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)  // 모달 창 닫기
    }
}

