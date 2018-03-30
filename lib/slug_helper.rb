module SlugHelper

  ##
  # Creates a slug from the given +param+.
  #
  # Params:
  # +param+::Parameter to slugify.
  # +max+::Max length of slug.
  def slugify (param, max = 45)

    # Ensure a name exists
    return '' unless param

    # Strip apostrophes
    slug = param.gsub /['`]/, ''

    # Change '@' to 'at' and '&' to 'and'.
    slug.gsub! /\s*@\s*/, ''
    slug.gsub! /\s*&\s*/, ''

    # Use Rail's parameterize method to handle the rest
    slug = slug.parameterize

    # Truncate to max chars
    slug = slug.truncate max, omission: ''

    # Remove final dash, if one exists
    slug.chop! if slug[-1] == '-'

    slug

  end

end