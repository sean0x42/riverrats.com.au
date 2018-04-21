class FlashMessage

  @title
  @body

  def initialize (title, body)
    self.title = title
    self.body = body
  end

  attr_accessor :title, :body

end