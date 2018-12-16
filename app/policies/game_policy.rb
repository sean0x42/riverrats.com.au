# frozen_string_literal: true

# A policy for managing access to recording games
class GamePolicy < ApplicationPolicy
  def new?
    user.admin
  end

  def create?
    user.admin
  end
end
