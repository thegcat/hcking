class WelcomeController < ApplicationController
  def index
    @single_events = SingleEvent.getNextWeeks 4

    if user_signed_in? && !current_user.hate_list.empty?
      @single_events.delete_if do |single_event|
        ((single_event.event.tag_list & current_user.hate_list).length > 0 &&
        (!single_event.users.include? current_user))
      end
    end
  end
end
