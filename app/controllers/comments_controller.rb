# frozen_string_literal: true

# A controller for managing comments
class CommentsController < ApplicationController
  before_action :authenticate_player!
  respond_to :js

  # POST /games/:id/comments
  def create
    @game = Game.find(params[:game_id])
    @comment = Comment.new(comment_params)

    # Add relations
    @comment.player = current_player
    @comment.game = @game

    if @comment.save
      @comment = @game.comments.build
      render 'success'
    else
      render 'failure'
    end
  end

  # GET /games/:id/comments/:id
  def edit
    @game = Game.find(params[:game_id])
    @comment = @game.comments.find(params[:id])
  end

  # PATCH|PUT /games/:id/comments/:id
  def update
  end

  # DELETE /games/:id/comments/:id
  def destroy
    @game = Game.find(params[:game_id])
    @comment = @game.comments.find(params[:id])
    @comment.destroy

    render 'destroy'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
