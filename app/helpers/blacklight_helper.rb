module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior
  include ItemsHelper

  def render_document_show_field_value args
    value = args[:value]
    value ||= args[:document].get(args[:field], :sep => nil) if args[:document] and args[:field]

    if blacklight_config.show_fields[args[:field]].try(:link)
      value = [value] unless value.respond_to? :map
      value = value.map { |x| link_to(x, catalog_index_url(:f => { args[:field] => [x] }) ) }
    end

    render_field_value value
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
  
end
