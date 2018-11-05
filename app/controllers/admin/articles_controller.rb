# frozen_string_literal: true

class Admin::ArticlesController < ApplicationController
  layout 'admin'

  # GET /admin/articles
  def index
    @articles = Article.page(params[:page])
  end

  # GET /admin/articles/new
  def new
    @article = Article.new
  end

  # POST /admin/articles
  def create
    @article = Article.new(article_params)
  end

  # GET /admin/articles/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  # PATCH|PUT /admin/articles/:id
  def update
    @article = Article.find(params[:id])
  end

  # DELETE /admin/articles/:id
  def destroy
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
