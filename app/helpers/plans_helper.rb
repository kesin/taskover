module PlansHelper

  # default color_tag
  # TODO: User can create different color_tag to choose

  def color_tag_class(prefix, color_tag)
    color_arr = ['gray','blue','green','red','yellow','qing']
    "#{prefix}#{color_arr[color_tag]}"
  end

end
