# frozen_string_literal: true

# A helper for the venues scope
module VenuesHelper
  def venue_address(venue)
    lines = [
      venue.address_line_one,
      venue.address_line_two,
      construct_suburb_state_tuple(venue)
    ]
    render 'venues/address', lines: lines
  end

  private

  def construct_suburb_state_tuple(venue)
    format(
      '%<suburb>s %<state>s, %<post_code>d',
      suburb: venue.suburb,
      state: venue.state,
      post_code: venue.post_code
    )
  end
end
