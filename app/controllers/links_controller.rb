require 'socket'
require 'date'

class LinksController < ApplicationController
  #If i remove this line even the authentication will work once i have been removed the commented line from routes
  before_filter :authenticate_user!, only: [:new,:create]
  before_action :get_location
  respond_to :html, :js

  attr_reader :ip_address
  attr_reader :country

  def index
    @links = Link.includes(:clicks)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @link = Link.new
  end

  def go
    link = Link.find_by(shortened_url: params["short_url"])
    click = Click.where(link: link.id).last
    if link.created_at < link.created_at + 30.days
      if click && click.user_id == current_user.id
        click.count += 1
        click.save
      elsif click && click.user_id != current_user.id
        Click.create(link_id: link.id, user_id: current_user.id, count: "#{click.count += 1}", ip_address: ip_address, country: country)
      end
      redirect_to link.given_url
    else
      link.destroy
      render :file => 'public/404.html', :status => :not_found, :layout => false 
    end
  end

  def create
    @link = Link.new(link_params)
    unless link_params["given_url"].empty?
      url = @link.shorten(link_params["given_url"])
      @link.given_url = link_params["given_url"]
      @link.shortened_url = url
    end
    respond_to do |format|
      if @link.save
        Click.create(link_id: @link.id, user_id: current_user.id, count: 0, ip_address: ip_address, country: country)
        format.js 
        format.json
        format.html { render :new }
      else
        format.js 
        format.html { render :new, notice: 'Enter valid URL'}
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_location
      @ip_address = current_user.current_sign_in_ip
      @country = Geocoder.search(ip_address).first.country
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:given_url)
    end
end
