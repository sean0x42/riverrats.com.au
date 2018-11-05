# frozen_string_literal: true

# A controller for managing articles
class ArticlesController < ApplicationController
  # GET /news
  def index
    @articles = Article.page(params[:page]).per(25)
  end

  # GET /news/:id
  def show
    @article = Article.find(params[:id])
  end
end
