class SingleEvent < Event

  belongs_to :recurring_event

  default_scope { order(:start_at) }

  paginates_per 50

end
