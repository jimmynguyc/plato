class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: %i[show edit update destroy]

  # GET /boards or /boards.json
  def index
    @boards = current_user.boards
    @organization_boards = (current_user.organization&.boards || []) - current_user.boards
  end

  # GET /boards/1 or /boards/1.json
  def show; end

  # GET /boards/new
  def new
    @board = current_user.boards.new
  end

  # GET /boards/1/edit
  def edit; end

  # POST /boards or /boards.json
  def create
    @board = current_user.boards.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to board_url(@board), notice: 'Board was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to board_url(@board), notice: 'Board was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def board_params
    params.require(:board).permit(:title)
  end
end
