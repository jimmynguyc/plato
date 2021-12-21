class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parents
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    @tasks = @card.tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = @card.tasks.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    @task = @card.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.turbo_stream do
          render turbo_stream:
            [
              turbo_stream.replace("card_#{@lane.id}_new_task", partial: 'tasks/new_task_button',
                                                                locals: { card: @card }),
              turbo_stream.replace(@card, partial: 'cards/card', locals: { card: @card })
            ]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@card, partial: 'cards/card', locals: { card: @card })
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@card, partial: 'cards/card', locals: { card: @card })
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = @card.tasks.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :completed)
  end

  def set_parents
    @board = Board.find(params[:board_id])
    @lane = @board.lanes.find(params[:lane_id])
    @card = @lane.cards.find(params[:card_id])
  end
end
