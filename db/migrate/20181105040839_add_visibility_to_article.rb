# frozen_string_literal: true

class AddVisibilityToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :draft, :boolean, default: true, null: false
  end
end
