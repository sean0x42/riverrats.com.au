# frozen_string_literal: true

# A helper for admin views
module Admin::AdminHelper
  def danger_zone(model, button_label, button_path, confirmation)
    return unless model.persisted?

    render partial: 'admin/danger_zone',
           locals: {
             button_label: button_label,
             button_path: button_path,
             confirmation: confirmation
           }
  end
end
