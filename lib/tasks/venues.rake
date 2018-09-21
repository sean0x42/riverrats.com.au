namespace :venues do
  task migrate_to_active_storage: :environment do
    Venue.where.not(image_file_name: nil).find_each do |venue|
      # This step helps us catch any attachments we might have uploaded that
      # don't have an explicit file extension in the file name
      image = venue.image_file_name
      ext = File.extname(image)
      image_original = URI.unescape(image.gsub(ext, "_original#{ext}"))

      # this url pattern can be changed to reflect whatever service you use
      image_url = ".../venues/#{venue.id}/#{image_original}"
      venue.image.attach(io: open(image_url),
                         filename: venue.image_file_name,
                         content_type: venue.image_content_type)
    end
  end
end