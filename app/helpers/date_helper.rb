module DateHelper
  def format_date_and_month_year(date, format = '%B %d, %Y')
    date.strftime(format).to_s
  end
end