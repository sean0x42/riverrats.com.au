class TheProdigy < Achievement
  def title
    I18n.t('achievement.the_prodigy.title')
  end

  def description
    I18n.t('achievement.the_prodigy.description')
  end

  def self.type
    :multi
  end
end