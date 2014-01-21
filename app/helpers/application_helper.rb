module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def price(thing)
    number_to_currency(thing, unit: "")
  end

  def current_cycle
    @current_cycle = Cycle.where('startdate <= ? AND lastdate > ?', Time.now + 1.week, Time.now + 1.week).first
  end

end
