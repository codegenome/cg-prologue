will_paginate_path = "#{`echo $rvm_path`.strip}/gems/#{ENV['RUBY_VERSION']}@#{app_name}/gems/will_paginate-3.0.pre2/lib/will_paginate"
gsub_file "#{will_paginate_path}/finders/active_record.rb" , /AssociationCollection/, 'CollectionAssociation'
