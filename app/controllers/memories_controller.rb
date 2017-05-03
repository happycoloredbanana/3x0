class MemoriesController < ApplicationController
	def new
  end

  def create
    # Make an object in your bucket for your upload
    obj = S3_BUCKET.object(params[:file].original_filename)

    # Upload the file
    obj.upload_file(params[:file].tempfile)

    # Create an object for the upload
    @memory = Memory.new(
      url: obj.public_url,
      name: obj.key
    )

    # Save the upload
    if @memory.save
      redirect_to memories_path, success: 'File successfully uploaded'
    else
      flash.now[:notice] = 'There was an error'
      render :new
    end
  end

  def index
    @memories = Memory.all
  end
end
