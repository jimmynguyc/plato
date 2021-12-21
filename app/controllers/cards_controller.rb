class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parents
  before_action :set_card, only: %i[show edit update destroy]

  # GET /cards or /cards.json
  def index
    @cards = @lane.cards.all
  end

  # GET /cards/1 or /cards/1.json
  def show; end

  # GET /cards/new
  def new
    @card = @lane.cards.new
  end

  # GET /cards/1/edit
  def edit; end

  # POST /cards or /cards.json
  def create
    @card = @lane.cards.new(card_params)

    respond_to do |format|
      if @card.save
        format.turbo_stream do
          turbo_stream.replace "lane_#{@lane.id}_new_card", partial: 'cards/new_card_button', locals: { lane: @lane }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.turbo_stream
      else
        format.html do
          render :edit, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = @lane.cards.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.require(:card).permit(:title, :description)
  end

  def set_parents
    @board = Board.find(params[:board_id])
    @lane = @board.lanes.find(params[:lane_id])
  end
end
