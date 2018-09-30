# frozen_string_literal: true

# A controller for the landing page
class LandingController < ApplicationController
  # GET /
  def index
    @games = Game.includes(:venue).first(8)
  end

  # GET /privacy-policy
  def privacy_policy; end

  # GET /release-notes
  def release_notes; end
end
