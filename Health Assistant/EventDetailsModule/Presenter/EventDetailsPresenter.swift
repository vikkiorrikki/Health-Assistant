//
//  EventDetailsPresenter.swift
//  Health Assistant
//
//  Created by Виктория Саклакова on 24.06.2020.
//  Copyright © 2020 Viktoriia Saklakova. All rights reserved.
//

import Foundation

class EventDetailsPresenter {
    
    //MARK: - Properties
    
    weak var view: EventDetailsViewDelegateForPresenter?
    private var event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    //MARK: - Methods
    
    func viewDidLoad(){
        view?.setTitleColor(for: event)
        view?.setUI(for: event)
    }
    
    func userPressedEditButton() {
        view?.openEditEventPage(for: event)
    }
    
    func updateValueForEditedEvent(_ event: Event) {
        self.event = event
        viewDidLoad()
        view?.editedEventIsSaved(with: event)
    }
    
}
