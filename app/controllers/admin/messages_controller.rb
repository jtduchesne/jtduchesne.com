class Admin::MessagesController < Admin::AdminController
  before_action :set_message, only: [:show, :destroy]

  layout 'jumbotron'

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all.reverse_order
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to url_for(action: 'show', id: @message), notice: f(@message) }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to url_for(action: 'index'), notice: f(@message) }
      format.json { head :no_content }
    end
  end

private
  def set_message
    @message = Message.find(params[:id])
  end
  
  def message_params
    params.require(:message).permit(:from, :subject, :body)
  end
end
