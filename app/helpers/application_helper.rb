module ApplicationHelper

  # default color_tag
  # TODO: User can create different color_tag to choose

  def color_tag_class(prefix, color_tag)
    color_arr = ['gray','blue','green','red','yellow','qing']
    "#{prefix}#{color_arr[color_tag]}"
  end

  def options_for_color
    [['灰色(Grey)','0'],['蓝色(Blue)','1'],['绿色(Green)','2'],['红色(Red)','3'],['黄色(Yellow)','4'],['青色(Qing)','5']]
  end

end
