FOG_STORAGE  = Fog::Storage.new({:provider => 'AWS', :aws_access_key_id => "AKIAIIY3JNRNOMPO4ROA", :aws_secret_access_key => "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"})
AMAZON_SES = AWS::SES::Base.new(:access_key_id => 'AKIAIIY3JNRNOMPO4ROA', :secret_access_key => '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')
