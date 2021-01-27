class Admin::AboutsController < Admin::AdminController
  before_action :set_about, only: [:show, :edit, :update, :destroy]

  layout 'jumbotron'

  # GET /abouts
  # GET /abouts.json
  def index
    @abouts = About.all.reverse_order.send "with_rich_text_#{I18n.locale}"
  end

  # GET /abouts/1
  # GET /abouts/1.json
  def show
  end

  # GET /abouts/new
  def new
    @about = About.new
  end

  # GET /abouts/1/edit
  def edit
  end

  # POST /abouts
  # POST /abouts.json
  def create
    @about = About.new(about_params)

    respond_to do |format|
      if @about.save
        format.html { redirect_to url_for(action: 'show', id: @about), notice: f(@about) }
        format.json { render :show, status: :created, location: @about }
      else
        format.html { render :new }
        format.json { render json: @about.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /abouts/1
  # PATCH/PUT /abouts/1.json
  def update
    respond_to do |format|
      if @about.update(about_params)
        format.html { redirect_to url_for(action: 'show', id: @about), notice: f(@about) }
        format.json { render :show, status: :ok, location: @about }
      else
        format.html { render :edit }
        format.json { render json: @about.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abouts/1
  # DELETE /abouts/1.json
  def destroy
    @about.destroy
    respond_to do |format|
      format.html { redirect_to url_for(action: 'index'), notice: f(@about) }
      format.json { head :no_content }
    end
  end

private
  def set_about
    @about = About.find(params[:id])
  end

  def about_params
    params.require(:about).permit(:fr, :en)
  end
end
