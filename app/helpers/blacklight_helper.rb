
module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior
  
  def render_document_show_field_value args
    #binding.pry
    value = args[:value]
    value ||= args[:document].get(args[:field], :sep => nil) if args[:document] and args[:field]
    
    if blacklight_config.show_fields[args[:field]].try(:custom) && blacklight_config.show_fields[args[:field]].try(:link)
      value = [value] unless value.respond_to? :map
      value = value.map { |x| 
        y = x
        link_to("#{x} #{is_date_estimated? blacklight_config.show_fields[args[:field]]}", 
                catalog_index_url(:f => { args[:field] => [y] }) 
                ) 
      }      
    elsif blacklight_config.show_fields[args[:field]].try(:custom)
      value = [value] unless value.respond_to? :map
      value = value.map { |x| "#{x} #{is_date_estimated? blacklight_config.show_fields[args[:field]]}" }
    elsif blacklight_config.show_fields[args[:field]].try(:link)
      value = [value] unless value.respond_to? :map
      value = value.map { |x| y = x; link_to(x, catalog_index_url(:f => { args[:field] => [y] }) ) }
    end

    render_field_value value
  end
  
  def is_date_estimated? args
    if args.field == 'date_created_s'
      args.custom
    else
      ''
    end
  end

  def render_index_field_value args
    value = args[:value]
    value ||= args[:document].get(args[:field], :sep => nil) if args[:document] and args[:field]

    if blacklight_config.index_fields[args[:field]].try(:link)
      value = [value] unless value.respond_to? :map
      value = value.map { |x| link_to(x, catalog_index_url(:f => { args[:field] => [x] }) ) }
    end

    render_field_value value
  end

  
   def render_search_context_options
      
        render :partial => 'catalog/search_context'
  end
 
   def link_to_query(query)
    p = params.dup
    p.delete :page
    p.delete :action
    p[:q]=query
    p[:side_q]=query
    link_url = catalog_index_path(p)
    link_to(query, link_url)
  end
 
   def has_search_parameters?
    !params[:q].blank? or !params[:side_q].blank? or !params[:f].blank? or !params[:search_field].blank?
  end

  def render_constraints_query(localized_params = params)
    # So simple don't need a view template, we can just do it here.
    if (!localized_params[:side_q].blank?)
      label = 
        if (localized_params[:search_field].blank? || (default_search_field && localized_params[:search_field] == default_search_field[:key] ) )
         nil
        else
          label_for_search_field(localized_params[:search_field])
        end
    
      render_constraint_element(label,
            localized_params[:side_q], 
            :classes => ["query"], 
            :remove => catalog_index_path(localized_params.merge(:side_q=>nil, :action=>'index')))
    else
      "".html_safe
    end
  end

end
