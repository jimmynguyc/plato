class LanesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board
  before_action :set_lane, only: %i[show edit update destroy]

  # GET /lanes or /lanes.json
  def index
    @lanes = @board.lanes
  end

  # GET /lanes/1 or /lanes/1.json
  def show; end

  # GET /lanes/new
  def new
    @lane = @board.lanes.new
  end

  # GET /lanes/1/edit
  def edit; end

  # POST /lanes or /lanes.json
  def create
    @lane = @board.lanes.new(lane_params)

    respond_to do |format|
      if @lane.save
        format.turbo_stream do
          turbo_stream.replace :new_lane, partial: 'lanes/new_lane_button', locals: { board: @board }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lanes/1 or /lanes/1.json
  def update
    respond_to do |format|
      if @lane.update(lane_params)
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lanes/1 or /lanes/1.json
  def destroy
    @lane.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lane
    @lane = Lane.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lane_params
    params.require(:lane).permit(:title)
  end

  def set_board
    @board = Board.find(params[:board_id])
  end
end
