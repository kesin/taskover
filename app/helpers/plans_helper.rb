module PlansHelper

  # default color_tag
  # TODO: User can create different color_tag to choose
  def color_tag_class(color_tag)
    color_id = color_tag.to_i - 1
    color_arr = ['gray','blue','green','red','yellow','qing'] # add expect 'gray' at the begin to advoid problem
    "bs-callout-#{color_arr[color_id]}"
  end

end
