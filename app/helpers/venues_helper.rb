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
    out = ''
    out += venue.suburb unless venue.suburb.nil?
    out += ' ' if out.present?
    out += venue.state unless venue.state.nil?
    out += ', ' if out.present?
    out += venue.post_code.to_s unless venue.post_code.nil?
    out
  end
end
