module ApplicationHelper

  ###
  # Renders a search field for the given +url+.
  #
  # Params:
  # +url+::URL to post query to.
  # +placeholder+::Search input's placeholder text.
  def render_search (url, placeholder)
    render partial: 'application/search',
           locals: {
             url: url,
             placeholder: placeholder
           }
  end

  def field_errors(model, field)
    render 'application/field_errors', model: model, field: field
  end
end
