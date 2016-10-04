module ApplicationHelper

  # default color_tag
  # TODO: User can create different color_tag to choose

  def color_tag_class(prefix, color_tag)
    color_arr = ['gray','blue','green','red','yellow','qing']
    "#{prefix}#{color_arr[color_tag]}"
  end

  def options_for_color
    [['#777777','0'],['#428bca','1'],['#5cb85c','2'],['#d9534f','3'],['#f0ad4e','4'],['#5bc0de','5']]
  end


  # used for set head params easily
  def title(title)
    content_for(:title, title)
  end

  def meta_keywords(keywords)
    content_for(:meta_keywords){keywords}
  end

  def meta_description(description)
    content_for(:meta_description) {description}
  end

end
