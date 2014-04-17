module S3
  class Helper
    def self.unique_file_name(object)
      "#{object.class}_#{object.created_at}".gsub!(/:/,"").gsub!(/ /,"_").gsub!(/-/,"_").downcase
    end
  end
end