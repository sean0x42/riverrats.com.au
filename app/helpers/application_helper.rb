# frozen_string_literal: true

# A helper which is available application wide.
module ApplicationHelper
  def render_search(url, placeholder)
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
