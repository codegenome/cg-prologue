create_file 'lib/sort_index.rb' do
<<-'FILE'
module SortIndex

  SORT_KEY_ASC = 'asc'
  SORT_KEY_DESC = 'desc'

  SORT_DIRECTION_MAP = { 
    SORT_KEY_DESC => 'DESC', 
    SORT_KEY_ASC => 'ASC' 
  }

  class Config
    attr_accessor :columns
    attr_accessor :default_direction
    
    def default
      return @default
    end

    def initialize(default, columns, default_direction = nil)
      @columns = columns
      @default_direction = default_direction || SORT_KEY_DESC
      
      raise "default only supports 1 pair" if default.length != 1
      default.each_pair { |key, value|
        @default = value
        @columns[key] = value
      }
    end
  end

  class Sortable 

    def initialize(params, config, index_url = nil)
      @config = config
      @params = params
      @index_url = index_url || params[:controller]
      
      # sets up for building the sql order by
      @sort_direction = SORT_DIRECTION_MAP[@params[:sort_direction]] || @config.default_direction
      @sort_by = @config.columns[@params[:sort_by]] || @config.default
    end

    def order
      specified_sort_by || "#{@sort_by} #{@sort_direction}"
    end

    def header_link(sort_key, display, sortable = true, element_id = '')
      
      if @config.columns[sort_key].nil? and sortable then
        raise "Sort key of '#{sort_key}' not found. Check your controllers SortIndex::Config variable" 
      end
      
      id_attr = ""
      if element_id != '' then
        id_attr = "id=\"#{element_id}\""
      end
      
      class_attr = ""
      if @config.columns[sort_key] == @sort_by then
        class_attr = " class='current-sort-#{@sort_direction.downcase}'"
      end
      
      a_href = "<a#{class_attr} href=\"/#{@index_url}?sort_by=#{sort_key}&amp;sort_direction=#{next_direction}\" title=\"#{display}\" #{id_attr}>#{display}</a>"
      if sortable == false then
        a_href = "<span>#{display}</span>"
      end
      
      return "#{a_href}".html_safe
    end

    def next_direction
      sort_direction = SORT_KEY_ASC
      if (@params[:sort_direction].nil?) then
        sort_direction = (@sort_direction == SORT_KEY_ASC) ? SORT_KEY_DESC : SORT_KEY_ASC
      elsif (@params[:sort_direction] == SORT_KEY_ASC) then
        sort_direction = SORT_KEY_DESC
      end
      return sort_direction
    end

    def specified_sort_by
      sort = @config.columns[@params[:sort_by]]
      return nil if sort.nil?
      return sort.split(',').map {|order_criteria| "#{order_criteria} #{@sort_direction}"}.join(',')
    end
  end
end
FILE
end

inject_into_file 'config/application.rb', :after => "# Custom directories with classes and modules you want to be autoloadable.\n" do
<<-'FILE'
    config.autoload_paths += %W(#{config.root}/lib)
FILE
end
