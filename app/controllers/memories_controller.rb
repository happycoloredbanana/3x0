require 'securerandom'

class MemoriesController < ApplicationController
	def new
  end

  def create
    obj_key = generate_unique_name(params[:file])
    obj = S3_BUCKET.object(obj_key)
    obj.upload_file(params[:file].tempfile)

    @memory = Memory.new(
      url: obj.public_url,
      name: obj.key
    )

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

private
  def generate_unique_name(file)
    ext = File.extname(file.original_filename)
    loop do
      name = SecureRandom.hex + ext 
      return name unless Memory.find_by name: name
    end
  end
end
