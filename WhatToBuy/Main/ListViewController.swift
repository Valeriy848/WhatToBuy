//
//  ListViewController.swift
//  WhatToBuy
//
//  Created by Valeriy Pokatilo on 02.01.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    private lazy var presenter = ListPresenter()

    override func loadView() {
        view = ListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(view: ListViewWrapper(view: view.originalType()))
        presenter.getData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.detachView()
    }
}
