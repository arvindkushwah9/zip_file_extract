class DocumentsController < ApplicationController
  require 'zip'
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  
  def show
    unless File.file?(@document.extracted_file_path)
       @document.extract_zip(@document.file_path, @document.destination_path)  
    end
    redirect_to @document.extracted_file_path.gsub("#{Rails.root.to_s}/public","")
    # file_path = @document.name.path
    # Zip::File.open(file_path) do |zip_file|
    #   # Handle entries one by one
    #   zip_file.each do |entry|
    #     # Extract to file/directory/symlink
    #     puts "Extracting #{entry.name}"
    #     entry.extract(dest_file)

    #     # Read into memory
    #     content = entry.get_input_stream.read
    #   end

    # # Find specific entry
    # # entry = zip_file.glob('*.xml').first
    # # puts entry.get_input_stream.read

    # # xml = File.open("myfile.xml")
    # # data = Hash.from_xml(xml)
    # end

  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def file_path
    file_path = Rails.root.join("public", "uploads", "document", "name","#{@document.id}","#{@document.zip_file_name}").to_s
  end
  def destination_path
    destination_path =  Rails.root.join("public", "uploads", "document", "name","#{@document.id}").to_s
  end
  def extracted_file_path
    extracted_file_path = Rails.root.join("public", "uploads", "document", "name","#{@document.id}","#{@document.extracted_file_name}").to_s
  end
  def zip_file_name
    @document.name.file.filename     
  end
  def extracted_file_name
    extracted_file_name = @document.zip_file_name.split(".zip").first  
    if @document.zip_file_name.include?(".tar.gz")
      extracted_file_name = @document.zip_file_name.split(".tar.gz").first     
    end
    return extracted_file_name  
  end
  def extract_zip(file, destination)
    FileUtils.mkdir_p(destination)

    Zip::File.open(file) do |zip_file|
      zip_file.each do |f|
        fpath = File.join(destination, f.name)
        zip_file.extract(f, fpath) unless File.exist?(fpath)
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :user_id, :description)
    end
end
