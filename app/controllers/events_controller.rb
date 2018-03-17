class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index,:show,:calendar_download]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :download]
  skip_authorization_check :only => [:calendar_download]
  load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
     if Date.valid_date? params[:year].to_i, params[:month].to_i, params[:day].to_i
      event_date = Date.parse("#{params[:year]}.#{params[:month]}.#{params[:day]}")
     end
     unless event_date.nil?
      @events = Event.paginate(:page => params[:page],:per_page => 8).where("publish=true and date(start_at)=?",event_date).order('start_at Desc')
     else
     @events = Event.paginate(:page => params[:page],:per_page =>8 ).where("publish=true ", params[:id]).order('start_at DESC')
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    if user_signed_in?
      @attendee = @event.attendees.where(:user_id=>current_user).first
    end
    @community = Community.find(@event.community_id) unless @event.community_id.nil?
  end

  # GET /events/new
  def new
    @event = Event.new
    @tickets = @event.tickets.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def calendar_download
    cal = @event.create_calendar_entry
    filename = 'floss-pa-event.ics'
    send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :title, :image, :location, :frecuency, :start_at_date, :start_at_time, :end_at_date,:end_at_time, :description, :keyworkds, :ticket_url, :community_id, :organizer, :publish, :latitude, :longitude, tickets_attributes: [:id, :event_id, :ticket_type_id, :amount, :token])
    end
end
