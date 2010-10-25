initializer('active_record.rb') do
<<-'FILE'
# This forces you to set attr_accessible in all your models
ActiveRecord::Base.send(:attr_accessible, nil)
FILE
end

initializer('haml.rb') do
<<-'FILE'
Haml::Template.options[:format] = :html5
FILE
end