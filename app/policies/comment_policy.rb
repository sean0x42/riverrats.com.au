# frozen_string_literal: true

# A policy for managing comments
class CommentPolicy < ApplicationPolicy
  # Scoping comments
  class Scope < Scope
    def resolve
      if user.admin? || user.tournament_director?
        scope.all
      else
        scope.where(deleted: false)
      end
    end
  end
end
