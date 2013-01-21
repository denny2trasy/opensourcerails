# require 'image_size'
module ProjectHelpers
  def project_url(project)
    "/#{project.id}/"
  end

  def project_cover_image(project)
    if File.exists?("#{root}/source/screenshots/#{project.id}/cover.jpg")
      "/screenshots/#{project.id}/cover.jpg"
    else
      "/images/simplething/samples/sample.jpg"
    end
  end

  # returns an array of Hashes, one for each associated project screenshot
  # include fields for :src, :index, :width, and :height
  def project_screenshots(project)
    imgs = []

    files = Dir.glob("#{root}/source/screenshots/#{project.id}/**/screen*", File::FNM_CASEFOLD)
    files.each_with_index do |file, index|
      next if File.directory?(file)

      img = {}.with_indifferent_access
      img[:src] = file.gsub("#{root}/source", "")
      img[:index] = index+1

      # # set width/height programatically
      # open(file, "rb") do |fh|
      #   size = ImageSize.new(fh.read).get_size
      #   img[:width] = size.first
      #   img[:height] = size.last
      # end

      imgs << img
    end

    imgs
  end

  def project_description(project)
    Redcarpet.new(project.description.to_s, :smart, :fenced_code).to_html
  end
end
