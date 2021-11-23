class UrlsController < ApplicationController
  @@redirect_base_url = "http://localhost:3000/surl/"
  def index
    @urls = Url.all.order('updated_at DESC')
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.short_url = @@redirect_base_url+@url.generate_short_url
    if @url.save
      render json: {status: '200', message: "Short URL is created."}
    else
      render json: {status: '404', message: @url.errors.full_messages}, status: 404
    end
  end

  def edit
    @url = Url.where("id=?",params[:id])
    @url_name = @url.pluck(:url_name)[0]
    @long_url = @url.pluck(:long_url)[0]
  end 

  def edit_url
    update_url = Url.find_by(id: params[:id])
    if update_url.update(url_name: params[:url_name], long_url: params[:long_url] )      
      render json: {status: '200', message: "URL is updated."}           
    else
      render json: {status: '404', message: update_url.errors.full_messages}, status: 404
    end
  end 

  def delete
    delete_url = Url.find_by(id: params[:id])
    if delete_url.destroy    
      redirect_to "/"           
    else
      render json: {status: '404', message: "Can't able to delete url."}, status: 404 
    end
  end

  def redirect 
    @long_url = Url.select(:long_url).where("short_url=?",request.original_url).pluck(:long_url)[0]
    if @long_url==nil
      render json: {status: '404', message: 'Not a valid URL.'}, status: 404
    else 
      redirect_to @long_url
    end
  end 

  private

  def url_params
    params.require(:url).permit(:url_name,:long_url,:id)
  end

end
