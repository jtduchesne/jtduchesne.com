class MessagesController < ApplicationController
  layout 'jumbotron'

  # GET /contact
  def new
    @message = Message.new
  end

  # POST /contact
  # POST /contact.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to url_for(action: 'new'), notice: t('.sent') }
        format.json { head :created }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def message_params
    params.require(:message).permit(:from, :subject, :body)
  end
end
