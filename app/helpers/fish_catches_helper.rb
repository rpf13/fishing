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
    # the action attribute is used to trigger the updateForm method in the sort-link stimulus controller
    # in the fish_catches/index.html.erb file, there is a all enclosing div, which contains the data-controller="sort-link"
    # attribute. This means that the sort-link stimulus controller is active on this div and all its children, but finally
    # only used with this action attribute.
    link_to name, params, data: {
      turbo_action: "advance",
      action: "turbo:click->sort-link#updateForm"
    }
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
