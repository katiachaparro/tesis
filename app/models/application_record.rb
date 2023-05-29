class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def version_by_attribute(attr)
    changes = audits.select { |v| v.audited_changes[attr].present? && v.audited_changes[attr][1].present? }
    return self[attr] unless changes.many?

    first = changes.shift
    changes.reduce(get_version_value(first, attr)) { |result, v| "#{result} <font size='9'><i>(#{v.created_at&.strftime('%d-%m-%Y %H:%M')})</i></font><br>#{ get_version_value(v, attr) }" }
  end

  private
  def get_version_value(v, attr)
    v.audited_changes[attr].is_a?(String) ? v.audited_changes[attr] : v.audited_changes[attr][1]
  end
end
