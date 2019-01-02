# frozen_string_literal: true

# A policy for managing venues
class VenuePolicy < ApplicationPolicy
  def new?
    %i[tournament_director admin].include? user.group
  end

  def create?
    %i[tournament_director admin].include? user.group
  end

  def edit?
    %i[tournament_director admin].include? user.group
  end

  def update?
    %i[tournament_director admin].include? user.group
  end

  def destroy?
    user.admin?
  end
end
