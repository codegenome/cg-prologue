will_paginate_path = "#{`echo $rvm_path`.strip}/gems/#{ENV['RUBY_VERSION']}@#{app_name}/gems/will_paginate-3.0.pre2/lib/will_paginate"
if Dir.exists will_paginate_path
  gsub_file "#{will_paginate_path}/finders/active_record.rb" , /AssociationCollection/, 'CollectionAssociation'
end

railties_path = "#{`echo $rvm_path`.strip}/gems/#{ENV['RUBY_VERSION']}@#{app_name}/gems/railties-3.1.0.rc4/lib/rails"
if Dir.exists railties_path
  gsub_file "#{railties_path}/commands/plugin.rb", /Commands/, 'RailsCommands'
end
