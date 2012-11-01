  <%= form_tag catalog_index_path, :id=>"top_search", :method => :get do %>
      <%= radio_button_tag :search_field, "collections", true, :class=>"search_field" %>
      <%= label_tag(:search_field, " collections ") %>
      <%= radio_button_tag :search_field, "blog", false, :class=>"search_field" %>
      <%= label_tag(:search_field, " blog ") %>
  <% end %>
