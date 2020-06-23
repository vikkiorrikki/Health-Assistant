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
    
    weak var view: EventDetailsViewDelegate?
    var event: Event?
    
    //MARK: - Methods
    
    func setUI(){
        guard let event = self.event
            else { return }
        
        view?.setTitleColor(for: event)
        view?.setUI(for: event)
    }
    
    func userPressedEditButton() {
        guard let event = self.event
            else { return }
        
        view?.userPressedEditButton(for: event)
    }
    
    func userEditedEvent(_ event: Event) {
        self.event = event
        setUI()
        view?.updateEventTable(with: event)
    }
    
}
