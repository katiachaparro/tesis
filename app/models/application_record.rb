class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def version_by_attribute(attr, size=9)
    changes = audits.select { |v| v.audited_changes[attr].present? && v.audited_changes[attr][1].present? }
    return self[attr] unless changes.many?

    first = changes.shift
    changes.reduce(get_version_value(first, attr)) { |result, v| "#{result} <font size='#{size}'><i>(#{v.created_at&.strftime('%d-%m-%Y %H:%M')})</i></font><br>#{ get_version_value(v, attr) }" }
  end

  def full_version_by_attribute(attr, size=9)
    changes = audits.select { |v| v.audited_changes[attr].present? && v.audited_changes[attr][1].present? }
    return self[attr] unless changes.many?

    changes.reduce('') { |result, v| "#{result} <font size='#{size}'>#{ get_version_value(v, attr) } <i>(#{v.created_at&.strftime('%d-%m-%Y %H:%M')})</i></font><br>" }
  end

  private
  def get_version_value(v, attr)
    v.audited_changes[attr].is_a?(String) ? v.audited_changes[attr] : v.audited_changes[attr][1]
  end
end
