create_file 'config/initializers/active_record.rb' do
<<-'FILE'
# This forces you to set attr_accessible in all your models
ActiveRecord::Base.send(:attr_accessible, nil)
FILE
end