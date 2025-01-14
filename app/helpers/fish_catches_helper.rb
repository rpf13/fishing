module FishCatchesHelper

  def total_weight(fish_catches)
    fish_catches.map(&:weight).reduce(0, &:+)
  end

  def sort_link_to(name, column)
    name = raw("#{name} #{direction_indicator(column)}")

    params = request.params.
      merge(sort: column, direction: next_direction(column))

    # the data attribute is used to add the url attributes to the link in order to make it work with Turbo
    # and to have the possibliity to use bookmark a the filtered view.
    link_to name, params, data: { turbo_action: "advance" }
  end

  def next_direction(column)
    if currently_sorted?(column)
      params[:direction] == "asc" ? "desc" : "asc"
    else
      "asc"
    end
  end

  def direction_indicator(column)
    if currently_sorted?(column)
      tag.span(class: "sort sort-#{next_direction(column)}")
    end
  end

  def currently_sorted?(column)
    params[:sort] == column.to_s
  end

end
